
import 'dart:convert';
import 'dart:isolate';

import 'package:rescue_station/app/socket/isolate_msg_entity.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';
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
    loggerArray(["开始连接",url,SharedPreferencesUtil.getString("token")]);
    SendPort sendPort = params[0];
    WebSocketChannel channel = WebSocketChannel.connect(uri);
    channel.ready.then((value) {
      sendPort.send(buildMessage("connected"));
    });
    channel.stream.listen((event) {
      loggerArray(["异步任务收到长连接消息",event]);
      if(event is String){

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





}



