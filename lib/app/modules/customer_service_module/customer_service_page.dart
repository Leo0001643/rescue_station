import 'package:flutter/material.dart';
import 'dart:html' as html;  // 引入 dart:html
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/utils/Icon.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/AppLayout.dart';
import 'customer_service_controller.dart';
import '../../theme/app_colors.dart';

class CustomerServicePage extends GetView<CustomerServiceController> {
  CustomerServicePage({super.key});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://mdkhk3.kefuzixun.cn/web/im?cptid=4ebeda2b9808');
    if (!await launchUrl(url)) {
      throw Exception('无法打开网址 $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: AppLayout.heigth(60),
      backgroundColor: color_703,
      centerTitle: true,
      title: Text("在线客服", style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(18),fontWeight: FontWeight.w500)),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Gap(AppLayout.heigth(220)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(AppLayout.width(180), AppLayout.heigth(36)),
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 居中显示
                      children: [
                        Icon(IconFont.CUSTOMER, color: Colors.white, size: AppLayout.fontSize(20)),  // 添加Icon
                        SizedBox(width: AppLayout.width(8)),  // 控制图标和文字的间距
                        Text('美洽客服',style: TextStyle(color: Colors.white,fontSize: AppLayout.fontSize(14),fontWeight: FontWeight.w400)),
                      ],
                    ),
                    onPressed: (){
                    String url = 'https://mdkhk3.kefuzixun.cn/web/im?cptid=4ebeda2b9808';
                    html.window.location.href = url;  // 替换当前页面
                    },
                  )
                ],
              )
            )
          ],
        ),
      ),
    ),
    );
  }
}
