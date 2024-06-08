import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/AppLayout.dart';
import 'add_friend_controller.dart';

class AddFriendPage extends GetView<AddFriendController> {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('搜索结果', style: TextStyle(fontSize: AppLayout.fontSize(20), fontWeight: FontWeight.bold)),
            Gap(AppLayout.heigth(30)),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppLayout.heigth(10)),
              ),
              color: Colors.lightBlue[100],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: AppLayout.width(48),height: AppLayout.width(48),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppLayout.width(5))),
                      child: Image.asset("assets/images/icon/avatar1.png", fit: BoxFit.cover),
                    ),
                    Gap(AppLayout.width(16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('性别：女', style: TextStyle(fontSize: AppLayout.fontSize(16))),
                          Text('地址：北京市海淀区育新花园10栋', style: TextStyle(fontSize:AppLayout.fontSize(16)),maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,),
                          Text('昵称：海棠朵朵', style: TextStyle(fontSize: AppLayout.fontSize(16))),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), backgroundColor: const Color.fromRGBO(112, 50, 255, 1),
                      ),
                      child: Text('添加好友', style: TextStyle(fontSize: AppLayout.fontSize(16),fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  PreferredSizeWidget _appBar(BuildContext context){
    return AppBar(
        toolbarHeight: AppLayout.heigth(80),
        leading:IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: ()=>Get.back()
        ),
        backgroundColor: const Color.fromRGBO(112, 50, 255, 1),
        title: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: AppLayout.heigth(80),
              maxWidth: double.infinity
          ),
          child: TextField(
            // controller: _searchController,
            decoration: InputDecoration(
              hintText: '账号/手机号',
              prefixIcon: const Icon(Icons.search, color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: AppLayout.width(8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppLayout.width(8)),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
    );
  }
}
