import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import 'notice_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class NoticePage extends GetView<NoticeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('站内信'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()=>Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {

            },
            child: const Text('一键已读', style: TextStyle(color: Colors.black)),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return  Column(
            children: [
              ListTile(
                onTap: ()=> Get.toNamed(Routes.NOTICE_DETAIL),
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Image.asset('assets/images/icon/unread_notice.png'),
                ),
                title: const Text('系统消息'),
                subtitle: const Text("你好很高兴认识你"),
                trailing: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("2024-06-06", style: TextStyle(color: Colors.grey)),
                    Text("12:00:00", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const Divider()
            ],
          );
        },
      ),
    );
  }
}
