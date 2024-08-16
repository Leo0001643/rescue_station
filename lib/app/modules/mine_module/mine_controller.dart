import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/modules/mine_module/user_model.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils_bak.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import '../../domains/upload_file_entity.dart';
import '../../routes/api_info.dart';
import '../../utils/dio_utils.dart';


class MineController extends GetxController{
  var userInfo = UserInfoEntity().obs;
  var profileImagePath = ''.obs;
  StreamSubscription? loginSub;

  var user = UserModel(
    nickname: '上官婉儿',
    chatNo: '18865654445',
    gender: '男',
    birthdate: DateTime(1998, 8, 18),
    address: '北京市海淀区',
    phoneNumber: '16315665412',
  ).obs;


  @override
  void onInit() {
    loginSub = eventBus.on<LoginEvent>().listen((event) {
      ///登录成功
      userInfo.value = AppData.getUser()!;
    });
  }

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

  void logout() async{
    try {
      await EasyLoading.show(status: '正在登出...',maskType: EasyLoadingMaskType.black);
      await DioUtil().get(Api.LOGOUT);
      await AppData.clearUser();
      await SocketUtils().destroy();
      eventBus.fire(LogoutEvent());
      // await DbHelper().clearUser();
      await Future.delayed(const Duration(milliseconds: 500));
      await EasyLoading.dismiss();
      EasyLoading.showSuccess('登出成功!');
      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      EasyLoading.showError("登出异常！");
    }
  }


  Future<void> pickImage(ImageSource source) async {
    try{
      UploadFileEntity? uploadFile;
      if (GetPlatform.isWeb) {
        // Web 特定代码
        final ImagePicker _picker = ImagePicker();
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          profileImagePath.value = image.path;
          UserInfoEntity? userInfoCache =  await AppData.getUser();
          userInfoCache?.portrait = profileImagePath.value;
          await AppData.setUser(userInfoCache!);
          var imageName = image.name;
          await EasyLoading.show(status: '正在上传头像...', maskType: EasyLoadingMaskType.black);
          final bytes = await image.readAsBytes();
          uploadFile = await DioUtil.uploadWebFile(imageName, bytes);
        }
      }else{
        // 移动端特定代码
        await checkAndRequestPhotosPermission();// 请求相册权限
        final ImagePicker _picker = ImagePicker();
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          var imageName = image.name;
          uploadFile = await DioUtil.uploadFile(imageName, image.path);
        }
      }
      if (isNotEmpty(uploadFile)) {
        var path = uploadFile?.fullPath;
        await DioUtil().post(Api.EDIT_PORTRAIT, data: {"portrait": path});
        userInfo.update((user) {
          user?.portrait = uploadFile?.fullPath!;
          return user!;
        });
        UserInfoEntity? userInfoCache =  AppData.getUser();
        userInfoCache?.portrait = path;
        await AppData.setUser(userInfoCache!);
        EasyLoading.showSuccess('修改成功!');
      }
      await EasyLoading.dismiss();
      refresh();
    }catch(e){
      EasyLoading.showError("修改头像异常，请稍后再试！");
      print(e);
    }
  }



  Future<void> checkAndRequestPhotosPermission() async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      print('照片权限已授权');
    } else if (status.isDenied) {
      // 权限被拒绝，尝试请求权限
      final result = await Permission.photos.request();
      result.isGranted? print('照片权限已授权') : print('照片权限未授权，请在设置中启用');
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  ///修改昵称
  void updateNickname(String nickname) {
    user.update((val) {
      val?.nickname = nickname;
      return val!;
    });
  }

  ///修改微聊号
  void updateChatNo(String chatNo) {
    user.update((val) {
      val?.chatNo = chatNo;
      return val!;
    });
  }

  ///修改等级
  void updateGender(String gender) {
    user.update((val) {
      val?.gender = gender;
      return val!;
    });
  }

  ///修改生日
  void updateBirthdate(DateTime birthdate) {
    user.update((val) {
      val?.birthdate = birthdate;
      return val!;
    });
  }

  ///修改地址
  void updateAddress(String address) {
    user.update((val) {
      val?.address = address;
      return val!;
    });
  }

  ///修改手机号
  void updatePhoneNumber(String phoneNumber) {
    user.update((val) {
      val?.phoneNumber = phoneNumber;
      return val!;
    });
  }

  ///修改密码
  void updatePassword(String newPassword) {
    // Handle password update logic here
  }
}
