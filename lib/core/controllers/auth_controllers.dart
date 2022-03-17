import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:instagram_clone/screens/authenticate/verify_email.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class AuthControllers extends GetxController {
  static AuthControllers instance = Get.find();
  Rx<User?>? firebaseUser = Rx<User?>(firebaseAuth.currentUser);

  String usersCollection = "users";
  RxString newUserName = ''.obs;
  String get userName => newUserName.value;
  Rx<Usermodels> currentUser = Usermodels().obs;
  Usermodels get getcurrentUser => currentUser.value;
  Rx<Usermodels> newUser = Usermodels().obs;
  Rx<bool> isSginUpScreen = false.obs;
  Rx<bool> viewPass = false.obs;
  Rx<bool> isExistUserName = false.obs;
  Rx<bool> isFormatUserName = false.obs;

  @override
  void onReady() async {
    super.onReady();
    setUserInitData();
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        _setIntScreen(firebaseAuth.currentUser);
      },
    );
  }

  viewPassFun() {
    viewPass.value = !viewPass.value;
    update();
  }

  setUserInitData() {
    viewPass.value = false;
    isExistUserName.value = false;
    isFormatUserName.value = false;
    newUserName.value = '';
    newUser = Usermodels().obs;

    update();
  }

  //* Sign Up whih email add passrod
  void signUpWithEmailAndPawwrod(
      {required String email, required String password}) async {
    try {
      showLoading();

      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (userCer) async {
          await imagePickerConttroller
              .uploadImage(
            imagePickerConttroller.userChildName,
            userCer.user!.uid,
          )
              .then(
            (userImage) async {
              newUser.value.image = userImage;
              newUser.value.id = userCer.user!.uid;
              newUser.value.followers = [];
              newUser.value.following = [];
              await MySharedPreferences.saveUserPassword(password);

              await _addUserToFirestore(userCer.user!);
              _setIntScreen(userCer.user!);
            },
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      debugPrint("error:${error.message}");

      dismissLoadingWidget();
      authEroorSnackBar("Sign In Failed", error);
    }
  }

  _addUserToFirestore(User user) async {
    return await firebaseFirestore
        .collection(usersCollection)
        .doc(user.uid)
        .set(
          newUser.value.toJson(),
        );
  }
  //* end Sign Up whih email add passrod

  //* Sign in whih email add passrod
  void signInWithEmailAndPawwrod(
      {required String email, required String password}) async {
    try {
      showLoading();
      dynamic userEmail = await _checkLogninIsEmailOrUserName(email);
      await MySharedPreferences.saveUserPassword(password);

      if (userEmail == null) {
        dismissLoadingWidget();
        customErrorSnakBar(error: 'username not found..');

        return;
      }

      UserCredential? user = await firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: password,
      );
      if (user.user != null) {
        _setIntScreen(user.user);
      }

      dismissLoadingWidget();
    } on FirebaseAuthException catch (error) {
      dismissLoadingWidget();
      authEroorSnackBar("Sign In Failed", error);
    } on PlatformException catch (error) {
      dismissLoadingWidget();
      authEroorSnackBar("Sign In Failed", error);
    }
  }

  dynamic _checkLogninIsEmailOrUserName(String data) async {
    RegExp reg = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (reg.hasMatch(data)) {
      return data;
    } else {
      dynamic email = await getUserEmailByUserName(data);
      return email;
    }
  }

  getUserEmailByUserName(String data) async {
    try {
      QuerySnapshot snap = await firebaseFirestore
          .collection(usersCollection)
          .where(Usermodels.USERNAME, isEqualTo: data)
          .get();

      return snap.docs.isEmpty ? null : snap.docs[0][Usermodels.EMAIL];
    } on FirebaseException catch (error) {
      Get.snackbar(
        "Sign In Failed",
        "Try again\n${error.message}",
        titleText: const CustomText(
          text: "Sign In Failed",
          color: kPrimaryColor,
        ),
        backgroundColor: kMobileSearchColor,
        colorText: kBlueColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  //* end Sign in whih email add passrod

  updateUserData(Map<String, dynamic> data) async {
    return await firebaseFirestore
        .collection(usersCollection)
        .doc(getcurrentUser.id)
        .update(
          data,
        );
  }
  //* end Sign Up whih email add passrod

  signOut() async {
    isSginUpScreen.value = false;
    imagePickerConttroller.imagefile.value = '';

    setUserInitData();
    firebaseAuth.signOut();
    await MySharedPreferences.saveUserPassword('');

    currentUser = Usermodels().obs;
    _setIntScreen(null);
  }

  //? end facebook sign in methods

  void _setIntScreen(User? user) async {
    dismissLoadingWidget();
    if (user == null) {
      currentUser = Usermodels().obs;

      routeController.routePage(
        type: RouteType.OFALL,
        page: () => const Authenticate(),
      );
    } else {
      currentUser.bindStream(listenToUser(user.uid));
      if (user.emailVerified) {
        routeController.routePage(
          type: RouteType.OFALL,
          page: const CustonNavBar(),
          arguments: 0.obs,
        );
      } else {
        routeController.routePage(
          type: RouteType.OFALL,
          page: () => const VerifyEmail(),
          // arguments: 0.obs,
        );
      }
    }
  }

  Stream<Usermodels> listenToUser(String id) {
    return firebaseFirestore
        .collection(usersCollection)
        .doc(id)
        .snapshots()
        .map(
          (snapshot) => Usermodels.fromJson(
            snapshot.data(),
          ),
        );
  }

  Stream<bool> checkUsernameExist(String name) {
    return firebaseFirestore
        .collection(usersCollection)
        .where(Usermodels.USERNAME, isEqualTo: name)
        .snapshots()
        .map(
      (map) {
        return map.docs.isNotEmpty;
      },
    );
  }

  validatorUserNameFormat(String value) {
    String rex = r"^(?=.{6,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$";
    RegExp regExp = RegExp(rex);

    isFormatUserName.value = regExp.hasMatch(value);

    return regExp.hasMatch(value);
  }
}
