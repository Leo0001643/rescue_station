import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../constant/api_code.dart';
import '../../domains/api_response.dart';
import '../../routes/api_info.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/app_data.dart';
import '../../utils/dio_utils.dart';
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
          Options options = Options(
            headers: {"version":"1.0.1", "Authorization": userInfo?.token},
          );
          await EasyLoading.show(status: '提交申请中',maskType: EasyLoadingMaskType.black);
          var response = await DioUtil().post(Api.LOAN_APPLY, data: data, options: options);
          var entity = ApiResponse.fromJson(response.data);
          if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
            await EasyLoading.dismiss();
            EasyLoading.showSuccess('提交成功,系统审批中,如有疑问请联系在线客服!');
            Get.back();
            //Get.snackbar("提交成功", "系统审批中！",snackPosition: SnackPosition.top,duration: const Duration(seconds: 1), backgroundColor: AppStyles.primaryColor, colorText: AppStyles.textWhiteColor);
          }else{
            await EasyLoading.dismiss();
            EasyLoading.showError('提交失败,请联系在线客服!');
          }
          Get.close();
          update();
      }else{
          Get.toNamed(Routes.LOGIN);
      }
    }
  }
}
