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
              child: Text('8月8日 00:00',style: TextStyle(color: Colors.grey, fontSize: AppLayout.fontSize(16))),
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
                          '小水滴帮扶计划-及时雨: \n\n项目：2017年10月成立，主要帮助全国各地因多次就医导致不能维持正常生活的患病儿童家庭，解决实际生活问题，为其提供1000元到50000元不等的帮扶资金，并辅以专业志愿者陪伴支持，引导患儿及其家属正确面对疾病，积极配合治疗，从而收获更好的治疗效果。',
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
