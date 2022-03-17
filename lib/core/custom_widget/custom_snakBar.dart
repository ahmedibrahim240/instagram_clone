// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core_export.dart';

customErrorSnakBar({required String error}) {
  Get.snackbar(
    'Error',
    error,
    snackPosition: SnackPosition.TOP,
    colorText: Colors.redAccent.shade700,
    backgroundColor: kMobileSearchColor,
    duration: const Duration(seconds: 5),
  );
}

customSnakBar({required String mass}) {
  Get.snackbar(
    'Done',
    mass,
    snackPosition: SnackPosition.TOP,
    colorText: kBlueColor,
    backgroundColor: kMobileSearchColor,
    duration: const Duration(seconds: 5),
  );
}

authEroorSnackBar(String title, var error) {
  return Get.snackbar(
    title,
    "Try again\n${error.message}",
    titleText: const CustomText(
      text: "Sign In Failed",
      color: kPrimaryColor,
    ),
    colorText: kBlueColor,
    backgroundColor: kMobileSearchColor,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 5),
  );
}
