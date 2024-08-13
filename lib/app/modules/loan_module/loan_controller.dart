import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/app_data.dart';
import '../../utils/network/request_client.dart';


class LoanController extends GetxController{
  var realname = ''.obs;
  var phone = ''.obs;
  var identityId = ''.obs;
  var homeAddress = ''.obs;
  var homeRevenue = ''.obs;
  var loanAmount = ''.obs;
  var reason = ''.obs;

  StreamSubscription? loginSub;
  StreamSubscription? logoutSub;

  final formKey = GlobalKey<FormState>();

  Future<void> submitForm() async{
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save();
        var userInfo = AppData.getUser();
        if(isNotEmpty(userInfo)){
          var headers = {"version":"1.0.1", "Authorization": userInfo?.token};
          var data ={
            "realname": realname.value,
            "phone": phone.value,
            "identityId": identityId.value,
            "homeAddress": homeAddress.value,
            "homeRevenue": homeRevenue.value,
            "loanAmount": loanAmount.value,
            "reason": reason.value,
            "chatNo": userInfo?.chatNo,
            "userId": userInfo?.userId
          };
          RequestClient requestClient = RequestClient();
          var  user = await requestClient.post("loan/loanApplay", data: data, headers: headers);
          debugPrint("-------------$user");
          Get.snackbar("提交成功", "系统审批中！",snackPosition: SnackPosition.top,duration: const Duration(seconds: 1), backgroundColor: AppStyles.primaryColor, colorText: AppStyles.textWhiteColor);
          Get.close();
          update();
      }else{
          Get.toNamed(Routes.LOGIN);
      }
    }
  }
}
