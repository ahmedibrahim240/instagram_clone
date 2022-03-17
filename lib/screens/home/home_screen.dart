import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/core_export.dart';

class HomeScrean extends StatelessWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          Get.back();
          authControllers.signOut();
        },
        icon: Transform.rotate(
          angle: 180 * 3.14 / 180,
          child: const Icon(
            Icons.logout_rounded,
          ),
        ),
        label: const CustomText(
          text: 'LogOut',
          color: kBlueColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
