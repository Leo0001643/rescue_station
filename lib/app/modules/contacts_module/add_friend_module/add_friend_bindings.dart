import 'package:get/get.dart';
import 'package:rescue_station/app/modules/contacts_module/add_friend_module/add_friend_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddFriendBinding implements Binding {

  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => AddFriendController())];
  }


}