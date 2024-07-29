import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';

import '../../routes/app_pages.dart';

class GroupAvatarWidget extends StatefulWidget {
  final List<String> portrait;
  int unreadCount;

  GroupAvatarWidget(this.portrait,{Key? key,this.unreadCount = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateGroupAvatarWidget();
}

class StateGroupAvatarWidget extends State<GroupAvatarWidget> {
  var list = List<String>.empty(growable: true);

  @override
  void initState() {
    list.addAll(widget.portrait);
    // list.addAll(widget.portrait);
    // list.addAll(widget.portrait);
    // list.addAll(widget.portrait);
    // list.addAll(widget.portrait);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.r,
      height: 45.r,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5.r),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: isEmpty(list)
                ? Container()
                : list.length == 1
                ? GFAvatar(
              radius: 20.r,
              shape: GFAvatarShape.standard,
              borderRadius: BorderRadius.circular(5.r),
              backgroundImage: NetworkImage(list.first,),
            )
                : Wrap(
              spacing: 2.r,
              runSpacing: 2.r,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: buildGroupAvatar(list),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: widget.unreadCount > 0,
              child: GFBadge(
                size: 20.r,
                shape: GFBadgeShape.circle,
                border: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildGroupAvatar(List<String> portrait) {
    var list = portrait.length >= 4 ? portrait.sublist(0, 4) : portrait;
    return list
        .map((v) => Image.network(
              v,
              fit: BoxFit.fill,
              width: 20.r,
              height: 20.r,
            ))
        .toList();
  }
}
