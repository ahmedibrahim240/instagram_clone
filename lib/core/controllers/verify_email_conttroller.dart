import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController instance = Get.find();

  Rx<User?>? firebaseUser = Rx<User?>(firebaseAuth.currentUser);

  Rx<bool> reSentEmail = Rx<bool>(false);

  Rx<int> reSentCont = 1.obs;

  @override
  void onInit() {
    super.onInit();

    reSentEmail.value = false;
    firebaseUser!.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser!, _goToHome);
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  initState() async {
    if (!firebaseAuth.currentUser!.emailVerified) {
      _sendEmailVerification();
    }
  }

  _sendEmailVerification() async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();
      await Future.delayed(
        const Duration(seconds: 5),
        () => checkEmailVerified(),
      );
    } on FirebaseException catch (error) {
      debugPrint(error.message);

      authEroorSnackBar("Erorr", error);
    }
  }

  checkEmailVerified() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () async {
        await firebaseAuth.currentUser!.reload();
        reSentEmail.value = true;
      },
    );

    update();
  }

  reSendEmailVerification() async {
    reSentEmail.value = false;
    int minute = 1;
    minute *= reSentCont.value;
    _sendEmailVerification();

    await Future.delayed(
      Duration(minutes: minute),
      () {
        checkEmailVerified();
        reSentCont.value++;
      },
    );

    update();
  }

  _goToHome(User? user) {
    if (user != null) {
      if (user.emailVerified) {
        authControllers.currentUser.bindStream(
          authControllers.listenToUser(user.uid),
        );
        routeController.routePage(
          type: RouteType.OFALL,
          page: const CustonNavBar(),
          arguments: 0.obs,
        );
      } else {
        checkEmailVerified();
      }
    }
  }
}
