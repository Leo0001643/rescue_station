import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customer_service_controller.dart';

class CustomerServicePage extends GetView<CustomerServiceController> {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CustomerService Page')),
      body: Text("CustomerService"),
    );
  }
}
