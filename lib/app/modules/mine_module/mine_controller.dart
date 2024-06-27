import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_station/app/modules/mine_module/user_model.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import '../../db/db_helper.dart';
import '../../db/user_info_table.dart';
import '../../routes/api_info.dart';
import '../../utils/dio_utils.dart';
import '../../utils/shared_preferences_util.dart';


class MineController extends GetxController{
  var userInfo = UserInfoTable().obs;

  var user = UserModel(
    nickname: '上官婉儿',
    accountNumber: '18865654445',
    gender: '男',
    birthdate: DateTime(1998, 8, 18),
    address: '北京市海淀区',
    phoneNumber: '16315665412',
  ).obs;

  var profileImagePath = ''.obs;

  @override
  void onReady() {

  }

  @override
  void onClose() {

  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }


  void getUserInfo() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await EasyLoading.dismiss();
      String? localUserInfo = SharedPreferencesUtil.getString("userInfo");
      userInfo.value = UserInfoTable.fromJson(json.decode(localUserInfo!));
      await EasyLoading.dismiss();
      update();
    } catch (e) {
      EasyLoading.showError("获取会员信息！");
    }
  }


  void logout() async{
    try {
      await EasyLoading.show(status: '正在登出...',maskType: EasyLoadingMaskType.black,);
        await DioUtil().get(Api.LOGOUT);
        await SharedPreferencesUtil.remove("userInfo");
        // await DbHelper().clearUser();
        await Future.delayed(const Duration(seconds: 2));
        await EasyLoading.dismiss();
        EasyLoading.showSuccess('登出成功!');
        Get.toNamed(Routes.LOGIN);
    } catch (e) {
      EasyLoading.showError("登出异常！");
    }
  }


  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      profileImagePath.value = image.path;
      // Upload the image to your server and update the user's profile picture URL
      // Example: await uploadImage(image.path);
    }
  }

  void updateNickname(String nickname) {
    user.update((val) {
      val?.nickname = nickname;
    });
  }

  void updateAccountNumber(String accountNumber) {
    user.update((val) {
      val?.accountNumber = accountNumber;
    });
  }

  void updateGender(String gender) {
    user.update((val) {
      val?.gender = gender;
    });
  }

  void updateBirthdate(DateTime birthdate) {
    user.update((val) {
      val?.birthdate = birthdate;
    });
  }

  void updateAddress(String address) {
    user.update((val) {
      val?.address = address;
    });
  }

  void updatePhoneNumber(String phoneNumber) {
    user.update((val) {
      val?.phoneNumber = phoneNumber;
    });
  }

  void updatePassword(String newPassword) {
    // Handle password update logic here
  }


}
