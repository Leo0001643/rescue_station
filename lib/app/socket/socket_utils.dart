
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/isolate_msg_entity.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
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

  void connect(String token,{Function? callback}) async {
    ReceivePort receivePort = ReceivePort();
    mainSendPort = receivePort.sendPort;
    isolate = await Isolate.spawn(isolateMain, [mainSendPort!,token]);
    receivePort.listen((message) {
      loggerArray(["收到来自子Isolate的消息",message]);
      if(message is String){
        var msg = IsolateMsgEntity.fromJson(jsonDecode(message));
        switch(msg.key){
          case "connected":
            isConnect = true;
            callback?.call();
            break;
        }
      }else if(message is SocketMessageEntity){
        eventBus.fire(message);
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
    WebSocketChannel channel = WebSocketChannel.connect(uri);
    channel.ready.then((value) {
      sendPort.send(buildMessage("connected"));
    });
    channel.stream.listen((event) {
      loggerArray(["异步任务收到长连接消息",event]);
      ///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}
      if(event is String){
        var dataMap = jsonDecode(event);
        switch(dataMap["pushType"]){
          case "MSG":
            var response = SocketMessageEntity.fromJson(dataMap);
            sendPort.send(response);
            break;
        }
      }
    });

    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) {
      loggerArray(["收到来自主Isolate的消息",message]);
      var msg = IsolateMsgEntity.fromJson(jsonDecode(message));
      switch(msg.key){
        case "close":
          channel.sink.close(status.goingAway);
          logger("已关闭长连接");
          break;
      }
    });
  }

  static String buildMessage(String key,{String? value}){
    return jsonEncode(IsolateMsgEntity(key: key,value: value).toJson());
  }


  types.Message buildUserText(String text,UserInfoTable user){
    return types.TextMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
    );
  }

  types.Message buildUserImage(PlatformFile image,UserInfoTable user){
    return types.ImageMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  types.Message buildUserFile(PlatformFile image,UserInfoTable user){
    return types.FileMessage(
      author: types.User(id: user.userId.em(),imageUrl: user.portrait.em()),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

}


