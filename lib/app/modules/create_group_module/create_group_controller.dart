import 'package:get/get.dart';
import '../../domains/contact.dart';

class CreateGroupController extends GetxController{

  RxList filteredContacts = [].obs;

  final List<Contact> contacts = [
    Contact('AMang Tan', 'assets/avatar1.jpg'),
    Contact('安迪', 'assets/avatar2.jpg'),
    Contact('【北尚吉他】小七 (2)', 'assets/avatar3.jpg'),
    Contact('爸', 'assets/avatar4.jpg'),
    Contact('表姐夫', 'assets/avatar5.jpg'),
    Contact('不过尔尔', 'assets/avatar6.jpg'),
    Contact('陈娟国', 'assets/avatar7.jpg'),
  ];

}
