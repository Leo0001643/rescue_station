import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_station/app/modules/mine_module/user_model.dart';


class MineController extends GetxController{
  var user = UserModel(
    nickname: '上官婉儿',
    accountNumber: '18865654445',
    gender: '男',
    birthdate: DateTime(1998, 8, 18),
    address: '北京市海淀区',
    phoneNumber: '16315665412',
  ).obs;

  var profileImagePath = ''.obs;

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
