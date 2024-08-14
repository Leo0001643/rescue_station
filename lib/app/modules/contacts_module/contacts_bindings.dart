import 'package:get/get.dart';
import 'package:rescue_station/app/modules/contacts_module/contacts_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ContactsBinding implements Binding {

  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => ContactsController())];
  }


}