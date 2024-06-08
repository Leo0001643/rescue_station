import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import '../../routes/app_pages.dart';
import '../../utils/request_client.dart';
import '../tabs_module/tabs_controller.dart';


class LoanController extends GetxController{
  var realname = ''.obs;
  var phone = ''.obs;
  var identityId = ''.obs;
  var homeAddress = ''.obs;
  var homeRevenue = ''.obs;
  var loanAmount = ''.obs;
  var reason = ''.obs;

  final formKey = GlobalKey<FormState>();




  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      var data ={"realname": realname.value, "phone": phone.value, "identityId": identityId.value, "homeAddress": homeAddress.value, "homeRevenue": homeRevenue.value, "loanAmount": loanAmount.value, "reason": reason.value, "chatId": "1798367557139595266"};
      var headers = {"version":"1.0.1", "Authorization": "hs5sl9xwkfhjgb39uhn3omee16cgqkiu"};
      RequestClient requestClient = RequestClient();
      var  user = await requestClient.post("loan/loanApplay", data: data, headers: headers);
      debugPrint("-------------$user");
      Get.snackbar("提交成功", "系统审批中！",snackPosition: SnackPosition.TOP,duration: const Duration(seconds: 1), backgroundColor: AppStyles.primaryColor, colorText: AppStyles.textWhiteColor);
      // final tabsController = Get.find<TabsController>();
      // tabsController.refresh();
      // Get.toNamed(Routes.TABS);
      // Get.back(closeOverlays: true);
      Get.close(1);
      update();
    }
  }

}
