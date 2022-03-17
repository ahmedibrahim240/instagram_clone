import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens_export.dart';

class ChangePasswordScreen extends StatelessWidget {
  final bool isLogin;
  final bool forgetting;

  const ChangePasswordScreen({
    Key? key,
    this.isLogin = true,
    this.forgetting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GetX(
      init: Get.put<SettingsController>(SettingsController()),
      builder: (SettingsController controller) {
        return Scaffold(
          appBar: appBar(controller, formKey, forgetting),
          body: (controller.restPass.value || forgetting)
              ? Center(
                  child: ResetPassword(
                    formKey: formKey,
                    isLogin: isLogin,
                  ),
                )
              : controller.oldPassword.value.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : changePassrodbody(formKey, controller),
        );
      },
    );
  }
}
