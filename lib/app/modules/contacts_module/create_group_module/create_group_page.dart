import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'create_group_controller.dart';


class CreateGroupPage extends GetView<CreateGroupController> {

  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("选择联系人",
      actions: [
        WidgetUtils.buildElevatedButton('完成', 50.w, 30.h, bg: color_65d,
            onPressed: ()=> controller.createGroup()),
        SizedBox(width: 10.w,),
      ]),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...controller.contacts.map((contact){
                return Column(
                  children: [
                    GFCheckboxListTile(
                      title: Row(
                        children: [
                          GFAvatar(
                            backgroundImage: NetworkImage(contact.portrait.em()),
                            radius: 20.r,
                            shape: GFAvatarShape.standard,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Text(contact.nickName.em(),style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                          ),
                        ],
                      ),
                      position: GFPosition.start,
                      type: GFCheckboxType.circle,
                      inactiveBorderColor: Colors.black54,
                      size: 25.r,
                      padding: EdgeInsets.all(8.r),
                      margin: EdgeInsets.symmetric(vertical: 5.r,horizontal: 16.r),
                      value: contact.select,
                      onChanged: (v){
                        contact.select = v;
                        controller.contacts.refresh();
                      },
                    ),
                    Container(
                      height: 1.h,
                      width: double.infinity,
                      color: AppStyles.lightGreyWile,
                      margin: EdgeInsets.only(left: 80.w,right: 10.w),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }),
    );
  }

}
