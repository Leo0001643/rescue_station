
import 'package:just_audio/just_audio.dart';

class AudioUtils{
  AudioUtils._internal();

  static AudioUtils? instance;

  static getInstance() {
    instance ??= AudioUtils._internal();
    return instance;
  }

  factory AudioUtils() => getInstance();

  static const message = 'assets/music/messagemp3';

  var messagePlayer = AudioPlayer();
  ///当前应用是否在前台显示
  var appForeground = true;

  ///收到消息通知
  void playReceiveMsg(){
    if(appForeground){
      messagePlayer.setAsset(message);
      messagePlayer.play();
    }
  }


  void pause(){
    messagePlayer.pause();
  }

  ///停止
  void stop(){
    messagePlayer.stop();
  }

  ///实例不再被继续使用
  void dispose(){
    messagePlayer.dispose();
  }


}




