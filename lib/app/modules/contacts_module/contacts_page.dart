import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../utils/Icon.dart';
import '../../utils/AppLayout.dart';
import '../../theme/app_colors_theme.dart';
import 'contacts_controller.dart';


class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildSearchAppBar(context, "通讯录",
        InkWell(
          onTap: (){},
          child: const Icon(IconFont.CONTACTS_ADD, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
              itemCount: controller.filteredContacts.length,
              separatorBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: AppLayout.width(80)),
                    child: Divider(height: AppLayout.heigth(0),color: AppStyles.lightGreyWile)
                );
              },
              itemBuilder: (context, index) {
                final contact = controller.filteredContacts[index];
                return Dismissible(
                  key: Key(contact),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteContact(contact);
                    Get.snackbar('删除', '$contact 已删除');
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: GFAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      radius: 25.r,
                      shape: GFAvatarShape.standard,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    title: Text(contact),
                    onTap: () {
                      // Handle contact tap
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }





}
