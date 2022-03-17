import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens_export.dart';

appBar(SettingsController controller, GlobalKey<FormState> formKey,
    bool forgetting) {
  return AppBar(
    title: Obx(
        () => Text(controller.restPass.value ? 'Reset password' : 'Password')),
    centerTitle: false,
    leading: IconButton(
      onPressed: () {
        if (controller.restPass.value) {
          controller.restPass.value = false;
        } else {
          Get.back();
        }
      },
      icon: const Icon(
        Icons.close,
      ),
    ),
    actions: forgetting
        ? null
        : [
            Obx(
              () {
                if (controller.restPass.value) {
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                } else {
                  if (controller.isAvailableToChange()) {
                    if (controller.loadedData.value) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.loading();
                            controller.changePasswrod();
                          }
                        },
                        icon: const Icon(
                          Icons.done,
                          color: kBlueColor,
                        ),
                      );
                    }
                  } else {
                    return const Icon(
                      Icons.done,
                      color: kSecondaryColor,
                    ).paddingAll(10);
                  }
                }
              },
            ),
          ],
  );
}

changePassrodbody(GlobalKey<FormState> formKey, SettingsController controller) {
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    children: [
      const CustomText(
        text: 'Your password must be at last 6 characters and \n'
            'should include a combinatons of numbers and letters',
        color: kSecondaryColor,
        fontSize: 14,
        maxLines: 3,
      ),
      const SizedBox(height: 10),
      ChagePasswordForm(
        formKey: formKey,
        controller: controller,
      ),
      Row(
        children: [
          const CustomText(
            text: 'If you forgot your password,you can',
            color: kSecondaryColor,
            fontSize: 14,
          ),
          TextButton(
            onPressed: () {
              controller.restPass.value = true;
            },
            child: const CustomText(
              text: 'reset it.',
              fontSize: 15,
            ),
          ),
        ],
      ),
      if (controller.error.isNotEmpty)
        CustomText(
          text: controller.error.value,
          color: Colors.redAccent,
          fontSize: 12,
          maxLines: 3,
        ),
    ],
  );
}

buildTextForm({
  required TextEditingController controller,
  required String lable,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  void Function(String?)? onChanged,
  TextInputType? keyboardType = TextInputType.visiblePassword,
  bool obscureText = true,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: const TextStyle(
          fontSize: 13,
          color: kSecondaryColor,
        ),
        focusedBorder: lineInputBorder(),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        enabledBorder: lineInputBorder(),
      ),
    ),
  );
}

lineInputBorder() {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      color: themeController.getPrimaryColor,
      width: 2,
    ),
  );
}

String? emailForrmat(String email) {
  RegExp reg = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
  bool match = reg.hasMatch(email);
  if (match) {
    return null;
  } else {
    return "The email address is badly formatted.";
  }
}
