
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:common_utils/common_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/isolate_msg_entity.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_notice_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

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

  Isolate? isolate;

  SendPort? mainSendPort;
  SendPort? childSendPort;
  ///长连接状态
  bool isConnect = false;

  void connect({Function? callback}) async {
    ReceivePort receivePort = ReceivePort();
    mainSendPort = receivePort.sendPort;
    try{
      isolate = await Isolate.spawn(isolateMain, [mainSendPort!,AppData.getUser()?.token.em()]);
    }catch(e){
      callback?.call(false);
      logger(e);
    }
    receivePort.listen((message){
      loggerArray(["收到来自子Isolate的消息",message]);
      if(message is String){
        var msg = IsolateMsgEntity.fromJson(jsonDecode(message));
        switch(msg.key){
          case "connected":
            isConnect = true;
            callback?.call(true);
            break;
          case "closed":
            isConnect = false;
            break;
        }
      }else if(message is SocketMessageEntity){
        DbHelper().messageInsertOrUpdate(false,message).then((v){
          eventBus.fire(message);
          eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
        });
      }else if(message is SocketNoticeEntity){
        eventBus.fire(message);///发送添加好友通知
      }
    });
  }


  void destroy(){
    childSendPort?.send(buildMessage("close"));
    isConnect = false;
    Future.delayed(const Duration(milliseconds: 100),(){
      childSendPort = null;
      mainSendPort = null;
      // ///立即停止异步任务
      isolate?.kill(priority: Isolate.immediate);
      isolate = null;
      logger("已关闭长连接");
    });
  }


  ///异步任务工作区
  static void isolateMain(List params) {
    // sendPort.send('Message from child Isolate');
    // var url = "ws://124.222.224.186:8800";
    var url = 'ws://103.143.80.82:9699/ws?Authorization=${params[1]}';
    var uri = Uri.parse(url);
    loggerArray(["开始连接",url,]);
    SendPort sendPort = params[0];
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cr, String host, int port) {
      return true;
    };
    WebSocketChannel channel = IOWebSocketChannel.connect(uri,customClient: client);
    channel.ready.then((value) {
      sendPort.send(buildMessage("connected"));
    });
    channel.stream.interval(const Duration(seconds: 1)).listen((event) {
      loggerArray(["异步任务收到长连接消息",event]);
      ///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}
      ///{"msgId":"1805438066169634817","pushType":"NOTICE","msgContent":{"friendApply":{"count":1},"topicRed":{},"topicReply":{}},"createTime":"2024-06-24 19:09:13","groupInfo":{}}
      ///{"msgId":"1808765416252825601","pushType":"MSG","msgContent":{"msgType":"ALERT","content":"你邀请貂蝉加入了群聊","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿的群聊-hi1f(2)","portrait":"[\"https://img.alicdn.com/imgextra/i3/87413133/O1CN01mHA9DJ1Z0xlORnKuW_!!87413133.png\"]","userId":"1808765416043110401","userType":"normal"},"createTime":"2024-07-03 23:30:55","groupInfo":{"nickName":"上官婉儿的群聊-hi1f(2)","portrait":"[\"https://img.alicdn.com/imgextra/i3/87413133/O1CN01mHA9DJ1Z0xlORnKuW_!!87413133.png\"]","userId":"1808765416043110401"}}
      if(event is String){
        var dataMap = jsonDecode(event);
        switch(dataMap["pushType"]){
          case "MSG":
            if(ObjectUtil.isEmpty(dataMap["groupInfo"])){
              var response = SocketMessageEntity.fromJson(dataMap);
              response.groupInfo = null;
              sendPort.send(response);
            } else {
              var response = SocketMessageEntity();
              response.msgId = dataMap["msgId"];
              response.pushType = dataMap["pushType"];
              response.createTime = dataMap["createTime"];
              response.msgContent = SocketMsgContent.fromJson(dataMap["msgContent"]);
              response.fromInfo = UserInfoEntity.fromJson(dataMap["fromInfo"]);
              var group = GroupInfoEntity();
              group.name = dataMap["groupInfo"]["nickName"];
              group.groupId = dataMap["groupInfo"]["userId"];
              group.portrait = (jsonDecode(dataMap["groupInfo"]["portrait"]) as List).map<String>((e) => e.toString()).toList();
              if(ObjectUtil.isNotEmpty(group.groupId)){
                response.groupInfo = group;
              }
              sendPort.send(response);
            }
            break;
          case "NOTICE":
            var response = SocketNoticeEntity.fromJson(dataMap);
            sendPort.send(response);
            break;
        }
      }
    },onDone: (){
      logger("长连接已关闭");
      sendPort.send(buildMessage("closed"));
    });

    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) {
      loggerArray(["收到来自主Isolate的消息",message]);
      var msg = IsolateMsgEntity.fromJson(jsonDecode(message));
      switch(msg.key){
        case "close":
          channel.sink.close(status.normalClosure);
          logger("已关闭长连接");
          break;
      }
    });
  }

  static String buildMessage(String key,{String? value}){
    return jsonEncode(IsolateMsgEntity(key: key,value: value).toJson());
  }


  types.Message buildUserText(String text,UserInfoEntity user,{int? createdAt}){
    return types.TextMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
    );
  }

  types.Message buildUserImage(PlatformFile image,UserInfoEntity user,{int? createdAt}){
    return types.ImageMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  types.Message buildUserFile(PlatformFile image,UserInfoEntity user,{int? createdAt}){
    return types.FileMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  types.Message buildUserImageUrl(String url,UserInfoEntity user,{int? createdAt}){
    return types.ImageMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: url,
      size: 0,
      name: "",
    );
  }

  types.Message buildUserFileUrl(String url,UserInfoEntity user,{int? createdAt}){
    return types.FileMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: url,
      size: 0,
      name: "",
    );
  }

  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }


}



