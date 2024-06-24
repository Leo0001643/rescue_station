import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import '../../routes/app_pages.dart';
import 'notice_detail_controller.dart';

class NoticeDetailPage extends GetView<NoticeDetailController> {
  const NoticeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统消息'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()=>Get.back(),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: AppLayout.fontSize(20)),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.width(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('6月5日 23:14',style: TextStyle(color: Colors.grey, fontSize: AppLayout.fontSize(16))),
            ),
            SizedBox(height: AppLayout.heigth(16)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // backgroundColor: Colors.purple,
                  child: Image.asset("assets/images/icon/notice_message.png"),
                ),
                SizedBox(width: AppLayout.heigth(8)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(AppLayout.width(8)),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(AppLayout.width(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '公告',
                          style: TextStyle(color: Colors.purple, fontSize: AppLayout.fontSize(18), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '尊敬的用户您好:\n\n' '李清照（1084年3月13日—1155年5月12日），北宋齐州（今山东省济南市）人，为中国历史上最著名的女词人。',
                          style: TextStyle(fontSize: AppLayout.fontSize(16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
