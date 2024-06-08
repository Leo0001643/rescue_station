import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/login_module/login_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class loginPage extends GetView<loginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
