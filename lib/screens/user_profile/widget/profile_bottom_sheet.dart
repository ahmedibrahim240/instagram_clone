import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

viewProfileBottomSheet() {
  return Get.bottomSheet(
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Wrap(
        children: [
          TextButton.icon(
            onPressed: () {
              Get.back();
              routeController.routePage(
                type: RouteType.To,
                page: () => const SettingsScrean(),
              );
            },
            icon: Icon(
              Icons.settings,
              color: themeController.getPrimaryColor,
            ),
            label: const CustomText(
              text: 'Settings',
              color: kBlueColor,
              fontSize: 14,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Get.back();
              authControllers.signOut();
            },
            icon: Transform.rotate(
              angle: 180 * 3.14 / 180,
              child: Icon(
                Icons.logout_rounded,
                color: themeController.getPrimaryColor,
              ),
            ),
            label: const CustomText(
              text: 'LogOut',
              color: kBlueColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
    backgroundColor:
        themeController.darkMode.value ? kMobileBackgroundColor : kPrimaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}
