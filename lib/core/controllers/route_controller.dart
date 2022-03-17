// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core_export.dart';

class RouteController extends GetxController {
  static RouteController instance = Get.find();
  @override
  void onReady() {
    super.onReady();
  }

  routePage({
    required RouteType type,
    required dynamic page,
    dynamic arguments,
    Transition? transition,
  }) {
    if (type == RouteType.OFALL) {
      Get.offAll(
        page,
        transition: transition ?? Transition.rightToLeft,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        arguments: arguments,
      );
    } else {
      Get.to(
        page,
        transition: transition ?? Transition.rightToLeft,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        arguments: arguments,
      );
    }
  }
}
