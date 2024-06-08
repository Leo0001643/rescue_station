import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/register_module/register_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class registerPage extends GetView<registerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
