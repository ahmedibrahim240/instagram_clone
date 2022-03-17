import 'package:flutter/material.dart';
import '../../screens_export.dart';

class ChagePasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SettingsController controller;

  const ChagePasswordForm({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordCont = TextEditingController();
    final TextEditingController newPasswordCont = TextEditingController();
    final TextEditingController confirmNewPasswordCont =
        TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            buildTextForm(
              controller: currentPasswordCont,
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return 'current password required...';
                } else {
                  if (controller.validatorOldPassword(newValue) != null) {
                    return controller.validatorOldPassword(newValue);
                  } else {
                    return null;
                  }
                }
              },
              lable: 'Current password'
                  '(updated on ${DateTime.now().year}-'
                  '${DateTime.now().month}-${DateTime.now().day})',
            ),
            buildTextForm(
              controller: newPasswordCont,
              lable: 'New password',
              onChanged: (value) {
                controller.newPassword.value = newPasswordCont.text.trim();
              },
              onSaved: (value) {
                controller.newPassword.value = newPasswordCont.text.trim();
              },
              validator: (value) =>
                  (value!.isEmpty) ? "New password required..." : null,
            ),
            buildTextForm(
              controller: confirmNewPasswordCont,
              lable: 'New password, again',
              onChanged: (value) {
                controller.confirmNewPassword.value =
                    confirmNewPasswordCont.text.trim();
              },
              onSaved: (value) {
                controller.confirmNewPassword.value =
                    confirmNewPasswordCont.text.trim();
              },
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return 'confirm password required...';
                } else {
                  if (controller.validatorconfirmPassword() != null) {
                    return controller.validatorconfirmPassword();
                  } else {
                    return null;
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
