import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class SettingsController extends GetxController {
  static SettingsController instance = Get.find();
  RxBool loadedData = false.obs;
  RxBool restPass = false.obs;

  RxString oldPassword = ''.obs;
  RxString error = ''.obs;
  RxString newPassword = ''.obs;
  RxString confirmNewPassword = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    oldPassword.value = await MySharedPreferences.getUserPassword();
    newPassword.value = '';
    confirmNewPassword.value = '';
    error.value = '';
    loadedData.value = false;
    restPass.value = false;
  }

  loading() {
    loadedData.value = !loadedData.value;
  }

  _setinitData() {
    newPassword.value = '';
    confirmNewPassword.value = '';
    error.value = '';

    loadedData.value = false;
  }

  bool isAvailableToChange() {
    if (newPassword.value.isNotEmpty && confirmNewPassword.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? validatorOldPassword(String newValue) {
    if (newValue == oldPassword.value) {
      return null;
    } else {
      return 'Wrong old password..';
    }
  }

  String? validatorconfirmPassword() {
    if (newPassword.value == confirmNewPassword.value) {
      return null;
    } else {
      return 'New password not matching...';
    }
  }

  Future<void> changePasswrod() async {
    try {
      User crrentUser = firebaseAuth.currentUser!;
      await crrentUser.updatePassword(newPassword.value);
      loading();
      _setinitData();
      await authControllers.signOut();
      customSnakBar(mass: 'Password was changed please login again...');
    } on FirebaseException catch (e) {
      error.value = e.message.toString();
      loading();
    }
  }

  resetPassword(String email, bool isLogin) async {
    try {
      showLoading();
      await firebaseAuth.sendPasswordResetEmail(email: email);
      dismissLoadingWidget();
      restPass.value = false;

      _setinitData();
      if (isLogin) {
        await authControllers.signOut();
      } else {
        dismissLoadingWidget();
        Get.back();
      }
      customSnakBar(
        mass: 'We sent email to reset your password to\n'
            '$email\n'
            'please reset password and login again...',
      );
    } on FirebaseException catch (e) {
      dismissLoadingWidget();
      error.value = e.message.toString();
    }
  }
}
