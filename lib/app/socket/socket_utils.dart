import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:common_utils/common_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_notice_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/audio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:web_socket/io_web_socket.dart';
import 'package:web_socket_channel/adapter_web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constant/constant.dart';

/// Author: Soushin
/// Date: 2024/2/26 16:53
/// Description: websocket长连接处理
/// 932707629@qq.com
///
class SocketUtils{

  SocketUtils._internal();

  static SocketUtils? instance;

  static getInstance() {
    instance ??= SocketUtils._internal();
    return instance;
  }
  factory SocketUtils() => getInstance();
  ///长连接状态
  bool isConnect = false;
  int lastTimeMill = DateTime.now().millisecondsSinceEpoch;
  WebSocketChannel? channel;
  Timer? periodicTimer;
  Timer? heartBeatTimer;
  Timer? reconnectTimer;

  /// 最大重连次数
  static const int maxReconnectAttempts = 5000;
  int reconnectAttempts = 0;

  void connect({Function? callback}) async {
    if (isConnect) {
      callback?.call(isConnect);
      return;
    }
    var url ='${Constant.BASE_WS_URL}?Authorization=${AppData.getUser()?.token.em()}';
    var uri = Uri.parse(url);
    loggerArray(["开始连接", url]);

    try {
      if (GetPlatform.isWeb) {
        channel = WebSocketChannel.connect(uri);
      } else {
        HttpClient client = HttpClient();
        client.badCertificateCallback = (X509Certificate cr, String host, int port) {
          return true;
        };
        channel = AdapterWebSocketChannel(IOWebSocket.fromWebSocket(await WebSocket.connect(url, customClient: client)));
      }
      channel?.sink.add({"version": Constant.VERSION});

      // 监听连接成功
      channel?.ready.then((value) {
        isConnect = true;
        reconnectAttempts = 0; // Reset reconnect attempts on successful connection
        callback?.call(isConnect);
        if (periodicTimer == null) {
          pengPeriodic();
        }
        if (heartBeatTimer == null) {
          startHeartBeat();
        }
      }, onError: (e) {
        isConnect = false;
        callback?.call(isConnect);
        loggerArray(["连接失败", e.toString()]);
        handleReconnect();
      });

      // 监听消息
      channel?.stream.listen((event) {
        loggerArray(["异步任务收到长连接消息", event]);
        if (event == "ok") {
          isConnect = true;
          lastTimeMill = DateTime.now().millisecondsSinceEpoch;
        } else if (event is String) {
          handleIncomingMessage(event);
        }
      }, onError: (e) {
        loggerArray(["消息接收失败", e.toString()]);
        isConnect = false;
        handleReconnect();
      });
    } catch (e) {
      isConnect = false;
      callback?.call(isConnect);
      loggerArray(["连接异常", e.toString()]);
      handleReconnect();
    }
  }

  /// 处理消息
  void handleIncomingMessage(String event) {
    var dataMap = jsonDecode(event);
    switch (dataMap["pushType"]) {
      case "MSG":
        handleMessage(dataMap);
        break;
      case "NOTICE":
        handleNotice(dataMap);
        break;
    }
  }
  /// 处理消息类型
  void handleMessage(Map<String, dynamic> dataMap) {
    SocketMessageEntity response;
    if (isEmpty(dataMap["groupInfo"])) {
      response = SocketMessageEntity.fromJson(dataMap);
      response.groupInfo = null;
    } else {
      response = SocketMessageEntity();
      response.msgId = dataMap["msgId"];
      response.pushType = dataMap["pushType"];
      response.createTime = dataMap["createTime"];
      response.msgContent = SocketMsgContent.fromJson(dataMap["msgContent"]);
      response.fromInfo = UserInfoEntity.fromJson(dataMap["fromInfo"]);
      var group = GroupInfoEntity();
      group.name = dataMap["groupInfo"]["nickName"];
      group.groupId = dataMap["groupInfo"]["userId"];
      group.portrait = (jsonDecode(dataMap["groupInfo"]["portrait"]) as List).map<String>((e) => e.toString()).toList();
      if (isNotEmpty(group.groupId)) {
        response.groupInfo = group;
      }
    }
    DbHelper().messageInsertOrUpdate(false, response).then((v) {
      if (v) {
        eventBus.fire(response);
        eventBus.fire(NewChatEvent());
        AudioUtils().playReceiveMsg();
      }
    });
  }

  /// 处理通知类型
  void handleNotice(Map<String, dynamic> dataMap) {
    var response = SocketNoticeEntity.fromJson(dataMap);
    eventBus.fire(response);
    AudioUtils().playReceiveMsg();
  }

  /// 启动心跳检测
  void startHeartBeat() {
    heartBeatTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (isConnect) {
        try {
          channel?.sink.add("ping");
        } catch (e) {
          loggerArray(["心跳检测失败", e.toString()]);
          destroy();
        }
      }
    });
  }

  /// 处理重连
  void handleReconnect() {
    reconnectTimer?.cancel();
    reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isConnect && reconnectAttempts < maxReconnectAttempts) {
        reconnectAttempts++;
        loggerArray(["尝试重连", reconnectAttempts]);
        connect(callback: (result) {
          if (result) {
            reconnectTimer?.cancel();
          }
        });
      } else if (reconnectAttempts >= maxReconnectAttempts) {
        reconnectTimer?.cancel();
        loggerArray(["达到最大重连次数，停止重连"]);
      }
    });
  }

  /// 断开连接
  Future destroy() async {
    await channel?.sink.close(status.normalClosure);
    channel = null;
    periodicTimer?.cancel();
    periodicTimer = null;
    heartBeatTimer?.cancel();
    heartBeatTimer = null;
    isConnect = false;
    loggerArray(["已关闭长连接", channel == null, periodicTimer == null, heartBeatTimer == null]);
    return;
  }

  /// 定时器心跳
  void pengPeriodic() {
    periodicTimer?.cancel();
    periodicTimer = null;
    periodicTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (isConnect) {
        try {
          channel?.sink.add("ping");
        } catch (e) {
          periodicTimer?.cancel();
          periodicTimer = null;
        }
      }
    });
  }

  /// 重连
  void reConnect() {
    loggerArray(["开始重连>>>", !isConnect, AppData.getUser()?.token]);
    if (!isConnect && ObjectUtil.isNotEmpty(AppData.getUser()?.token)) {
      connect(callback: (result) {
        loggerArray(["连接结果", result]);
        if (result) {
          // 连接成功
          isConnect == true;
        } else {
          // 失败应退出登录
        }
      });
    }
  }

  // 创建消息
  types.Message buildSystemText(String text, UserInfoEntity user, {int? createdAt, types.Message? replied, String? msgId}) {
    return types.SystemMessage(
      author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
      repliedMessage: replied,
      metadata: {"msgId": msgId},
    );
  }

  types.Message buildUserText(String text, UserInfoEntity user, {int? createdAt, types.Message? replied, String? msgId}) {
    return types.TextMessage(
      author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
      repliedMessage: replied,
      metadata: {"msgId": msgId},
    );
  }

  types.Message buildUserImage(PlatformFile image, UserInfoEntity user, {int? createdAt, types.Message? replied}) {
    if (GetPlatform.isWeb) {
      return types.ImageMessage(
        author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: "",
        metadata: {"file": image.bytes},
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    } else {
      return types.ImageMessage(
        author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: image.path.em(),
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    }
  }

  types.Message buildUserFile(PlatformFile image, UserInfoEntity user, {int? createdAt, types.Message? replied}) {
    if (GetPlatform.isWeb) {
      return types.FileMessage(
        author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: "",
        metadata: {"file": image.bytes},
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    } else {
      return types.FileMessage(
        author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: image.path.em(),
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    }
  }

  types.Message buildUserImageUrl(String content, UserInfoEntity user, {int? createdAt, types.Message? replied, String? msgId}) {
    // Example implementation for building an image message
    return types.ImageMessage(
      author: types.User(id: user.userId.em(), firstName: user.nickName, imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: msgId ?? randomString(),
      uri: content,
      size: 0,
      name: 'Image',
      repliedMessage: replied,
    );
  }

  types.Message buildUserFileUrl(String content,UserInfoEntity user,{int? createdAt,types.Message? replied,String? msgId}){
    UploadFileEntity uploadFile;
    if(isURL(content)){
      uploadFile = UploadFileEntity(fullPath: content);
    } else {
      uploadFile = UploadFileEntity.fromJson(jsonDecode(content));
    }
    return types.FileMessage(
      author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: uploadFile.fullPath.em(),
      size: parseSize(uploadFile.fileSize.em()),
      name: uploadFile.fileName.em(),
      repliedMessage: replied,
      metadata: {"msgId":msgId},
    );
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  ///将KMGTPB转换为字节
  int parseSize(String sizeStr) {
    final regex = RegExp(r'(\d+(\.\d+)?)\s*([KMGTP]B)?', caseSensitive: false);
    final match = regex.firstMatch(sizeStr);

    if (match == null) {
      logger('文件大小值不可用: $sizeStr');
      return 0;
    }

    double size = double.parse(match.group(1)!);
    String unit = match.group(3) ?? 'B';

    return convertToBytes(size, unit);
  }

  int convertToBytes(double size, String unit) {
    switch (unit.toUpperCase()) {
      case 'B':
        return size.toInt();
      case 'KB':
        return (size * 1024).toInt();
      case 'MB':
        return (size * 1024 * 1024).toInt();
      case 'GB':
        return (size * 1024 * 1024 * 1024).toInt();
      case 'TB':
        return (size * 1024 * 1024 * 1024 * 1024).toInt();
      default:
        logger('Invalid unit: $unit');
        return 0;
    }
  }

  String parseFileSize(double size){
    if(size < 1024){
      return "${size.toStringAsFixed(2)}B";
    }else if(size < 1024 * 1024){
      return "${(size / 1024).toStringAsFixed(2)}KB";
    }else if(size < 1024 * 1024 * 1024){
      return "${(size / (1024 * 1024)).toStringAsFixed(2)}MB";
    }else if(size < 1024 * 1024 * 1024 * 1024){
      return "${(size / (1024 * 1024 * 1024)).toStringAsFixed(2)}GB";
    }else if(size < 1024 * 1024 * 1024 * 1024 * 1024){
      return "${(size / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(2)}TB";
    }else {
      return "文件过大";
    }
  }


}



