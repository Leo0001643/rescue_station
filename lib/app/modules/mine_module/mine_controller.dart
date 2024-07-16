import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/modules/mine_module/user_model.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import '../../routes/api_info.dart';
import '../../utils/dio_utils.dart';
import '../../utils/shared_preferences_util.dart';


class MineController extends GetxController{
  var userInfo = UserInfoEntity().obs;
  StreamSubscription? loginSub;

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
    var user = AppData.getUser();
    if(isNotEmpty(user)){
      userInfo.value = user!;
    }
    loginSub = eventBus.on<LoginEvent>().listen((event) {
      ///登录成功
      userInfo.value = AppData.getUser()!;
    });
  }

  @override
  void onClose() {

  }


  void logout() async{
    try {
      await EasyLoading.show(status: '正在登出...',maskType: EasyLoadingMaskType.black,);
        await DioUtil().get(Api.LOGOUT);
        await AppData.clearUser();
        SocketUtils().destroy();
        eventBus.fire(LogoutEvent());
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
