import 'dart:async';

import 'package:get/get.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import '../../domains/Message.dart';


class MessageController extends GetxController{

  final RxList<Message> messages = [
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
    Message('上官婉儿', '谢谢你~', '2024-06-05 21:30', 'assets/images/icon/avatar1.png'),
    Message('王昭君', '不用客气~', '2024-06-05 21:30', 'assets/images/icon/avatar2.png'),
    Message('杨玉环', '吃饭了没~', '2024-06-05 21:30', 'assets/images/icon/avatar3.png'),
    Message('西施', '出去玩~', '2024-06-05 21:30', 'assets/images/icon/avatar4.png'),
    Message('貂蝉', '有空没~', '2024-06-05 21:30', 'assets/images/icon/avatar5.png'),
    Message('李清照', '约不~', '2024-06-05 21:30', 'assets/images/icon/avatar6.png'),
    Message('蔡文姬', '不约~', '2024-06-05 21:30', 'assets/images/icon/avatar7.png'),
    Message('卓文君', '浪起来~', '2024-06-05 21:30', 'assets/images/icon/avatar8.png'),
    Message('唐伯虎', '作诗~', '2024-06-05 21:30', 'assets/images/icon/avatar9.png'),
    Message('祝枝山', '把妹~', '2024-06-05 21:30', 'assets/images/icon/avatar10.png'),
    Message('文征明', '哈哈~', '2024-06-05 21:30', 'assets/images/icon/avatar11.png'),
    Message('徐祯卿', '呵呵~', '2024-06-05 21:30', 'assets/images/icon/avatar12.png'),
  ].obs;
  StreamSubscription? friendDelSub;

  @override
  void onInit() {
    super.onInit();
    friendDelSub = eventBus.on<FriendDeleteEvent>().listen((event) {
      ///删除好友，这里也应该删除对应的聊天记录,更新聊天列表
    });
  }

  @override
  void onClose() {
    friendDelSub?.cancel();
    super.onClose();
  }


}
