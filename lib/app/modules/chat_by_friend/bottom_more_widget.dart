import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/Icon.dart';

///聊天框下方底部更多
class BottomMoreWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=>StateBottomMoreWidget();

}

class StateBottomMoreWidget extends State<BottomMoreWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_d2d,
      child: Row(
        children: [
          IconButton(
              onPressed: (){},
              icon: Image.asset(ImageFont.select_img,width: 60.r, height: 60.r,),
          ),
          SizedBox(width: 10.w,),
          IconButton(
            onPressed: (){},
            icon: Image.asset(ImageFont.select_file,width: 60.r, height: 60.r,),
          ),
        ],
      ),
    );
  }

}
