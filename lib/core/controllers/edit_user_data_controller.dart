import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';
import 'package:instagram_clone/models/models_export.dart';

class EditProfileController extends GetxController {
  static EditProfileController instance = Get.find();
  RxString name = ''.obs;
  RxString userName = ''.obs;
  RxString bio = ''.obs;
  RxBool loadedData = false.obs;
  Rx<bool> isExistUserName = false.obs;
  Rx<bool> isFormatUserName = false.obs;

  String get getName => name.value;
  String get getBio => bio.value;
  String get getUserName => userName.value;
  bool get getLoadedData => loadedData.value;
  @override
  void onInit() {
    super.onInit();
    loadedData.value = false;
    setInitDate();
  }

  setInitDate() {
    name.value = authControllers.getcurrentUser.name!;
    userName.value = authControllers.getcurrentUser.userName!;
    bio.value = authControllers.getcurrentUser.bio!;
    isExistUserName.value = false;
    isFormatUserName.value = false;
  }

  loading() {
    loadedData.value = !loadedData.value;
  }

  updataProfileData() async {
    if (checkedIsAvailableToUpdate()) {
      try {
        Map<String, dynamic> newData = {
          Usermodels.BIO: getBio,
          Usermodels.NAME: getName,
          Usermodels.USERNAME: getUserName,
        };
        await authControllers.updateUserData(newData);
        await Future.delayed(
          const Duration(seconds: 2),
          () {
            loading();
            Get.back();
          },
        );
      } on FirebaseException catch (e) {
        loading();
        setInitDate();

        Get.back();
        customErrorSnakBar(
          error: "${e.message.toString()}\n try again late...",
        );
      }
    } else {
      loading();
      setInitDate();
      Get.back();
    }
  }

  bool checkedIsAvailableToUpdate() {
    String name = authControllers.getcurrentUser.name!;
    String userName = authControllers.getcurrentUser.userName!;
    String bio = authControllers.getcurrentUser.bio!;

    if ((getName == name) && (getUserName == userName) && (getBio == bio)) {
      return false;
    } else {
      return true;
    }
  }
}
