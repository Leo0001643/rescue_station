import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/contacts_module/contacts_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ContactsPage extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
