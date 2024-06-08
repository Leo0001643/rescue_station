import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/customer_service_module/customer_service_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CustomerServicePage extends GetView<CustomerServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CustomerService Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
