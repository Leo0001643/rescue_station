
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
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/adapter_web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket/io_web_socket.dart';

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

  WebSocketChannel? channel;

  /// reconnect 是否需要重连
  void connect({Function? callback}) async {
    if(isConnect){
      callback?.call(isConnect);
      return;
    }
    // sendPort.send('Message from child Isolate');
    // var url = "ws://124.222.224.186:8800";
    var url ='${Constant.BASE_WS_URL}?Authorization=${AppData.getUser()?.token.em()}';
    var uri = Uri.parse(url);
    loggerArray(["开始连接",url,]);
    // SendPort sendPort = params[0];
    if(GetPlatform.isWeb){
      channel = WebSocketChannel.connect(uri);
    } else {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cr, String host, int port) {
        return true;
      };
      channel = AdapterWebSocketChannel(IOWebSocket.fromWebSocket(await WebSocket.connect(url,customClient: client)));
    }
    channel?.sink.add({
      "version": Constant.VERSION
    });

    channel?.ready.then((value) {
      isConnect = true;
      callback?.call(isConnect);
      if(periodicTimer == null){
        pengPeriodic();
      }
      // sendPort.send(buildMessage("connected"));
    },onError: (e){
      isConnect = false;
      callback?.call(isConnect);
      loggerArray(["连接失败",e.toString()]);
    });
    channel?.stream.interval(const Duration(seconds: 1)).listen((event) {
      loggerArray(["异步任务收到长连接消息",event]);
      ///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}
      ///{"msgId":"1805438066169634817","pushType":"NOTICE","msgContent":{"friendApply":{"count":1},"topicRed":{},"topicReply":{}},"createTime":"2024-06-24 19:09:13","groupInfo":{}}
      ///{"msgId":"1808765416252825601","pushType":"MSG","msgContent":{"msgType":"ALERT","content":"你邀请貂蝉加入了群聊","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿的群聊-hi1f(2)","portrait":"[\"https://img.alicdn.com/imgextra/i3/87413133/O1CN01mHA9DJ1Z0xlORnKuW_!!87413133.png\"]","userId":"1808765416043110401","userType":"normal"},"createTime":"2024-07-03 23:30:55","groupInfo":{"nickName":"上官婉儿的群聊-hi1f(2)","portrait":"[\"https://img.alicdn.com/imgextra/i3/87413133/O1CN01mHA9DJ1Z0xlORnKuW_!!87413133.png\"]","userId":"1808765416043110401"}}
      if(event == "ok"){
        isConnect = true;
        loggerArray(["什么情况，还活着呢",channel == null,periodicTimer == null]);
      } else if(event is String){
        var dataMap = jsonDecode(event);
        switch(dataMap["pushType"]){
          case "MSG":
            SocketMessageEntity response;
            if(isEmpty(dataMap["groupInfo"])){
              response = SocketMessageEntity.fromJson(dataMap);
              response.groupInfo = null;
              // sendPort.send(response);
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
              if(isNotEmpty(group.groupId)){
                response.groupInfo = group;
              }
            }
            DbHelper().messageInsertOrUpdate(false,response).then((v){
              if(v){
                eventBus.fire(response);
                eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
                AudioUtils().playReceiveMsg();//播放收到消息声音
              }
            });
            break;
          case "NOTICE":
            var response = SocketNoticeEntity.fromJson(dataMap);
            eventBus.fire(response);///发送添加好友通知
            AudioUtils().playReceiveMsg();//播放收到消息声音
            break;
        }
      }
    },onError: (e){
      loggerArray(["消息接收失败",e.toString()]);
      isConnect = false;
      callback?.call(isConnect);
      destroy();
    });
  }

  Future destroy() async {
    await channel?.sink.close(status.normalClosure);
    channel = null;
    periodicTimer?.cancel();
    periodicTimer = null;
    isConnect = false;
    loggerArray(["已关闭长连接1",channel==null,periodicTimer == null]);
    return;
  }

  Timer? periodicTimer;
  void pengPeriodic(){
    periodicTimer?.cancel();
    periodicTimer = null;
    periodicTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if(isConnect){
        try{
          channel?.sink.add("isConnect");
        }catch(e){
          periodicTimer?.cancel();
        }
      }
    });
  }


  void reConnect() {
    loggerArray(["开始重连",!isConnect,AppData.getUser()?.token]);
    if(!isConnect && ObjectUtil.isNotEmpty(AppData.getUser()?.token)){
      ///如果已经登录了，有token
      SocketUtils().connect(callback: (result){
        loggerArray(["连接结果",result]);
        if(result){
          ///连接成功
        } else {
          ///失败应退出登录
        }
      });
    }
  }

  types.Message buildSystemText(String text,UserInfoEntity user,{int? createdAt,types.Message? replied,String? msgId}){
    return types.SystemMessage(
      author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
      repliedMessage: replied,
      metadata: {"msgId":msgId},
    );
  }


  types.Message buildUserText(String text,UserInfoEntity user,{int? createdAt,types.Message? replied,String? msgId}){
    return types.TextMessage(
      author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
      repliedMessage: replied,
      metadata: {"msgId":msgId},
    );
  }

  types.Message buildUserImage(PlatformFile image,UserInfoEntity user,{int? createdAt,types.Message? replied}){
    if(GetPlatform.isWeb){
      return types.ImageMessage(
        author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: "",
        metadata: {"file":image.bytes},
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    } else {
      return types.ImageMessage(
        author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: image.path.em(),
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    }
  }

  types.Message buildUserFile(PlatformFile image,UserInfoEntity user,{int? createdAt,types.Message? replied}){
    if(GetPlatform.isWeb){
      return types.FileMessage(
        author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: "",
        metadata: {"file":image.bytes},
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    } else {
      return types.FileMessage(
        author: types.User(id: user.userId.em(),firstName: user.nickName,imageUrl: user.portrait.em()),
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        uri: image.path.em(),
        size: image.size,
        name: image.name,
        repliedMessage: replied,
      );
    }
  }

  types.Message buildUserImageUrl(String content,UserInfoEntity user,{int? createdAt,types.Message? replied,String? msgId}){
    UploadFileEntity uploadFile;
    loggerArray(["这个是图片地址吗",content,isURL(content)]);
    if(isURL(content)){
      uploadFile = UploadFileEntity(fullPath: content);
    } else {
      uploadFile = UploadFileEntity.fromJson(jsonDecode(content));
    }

    return types.ImageMessage(
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

  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
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



