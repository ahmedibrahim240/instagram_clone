import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens_export.dart';

class ResetPassword extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLogin;
  const ResetPassword({
    Key? key,
    required this.formKey,
    required this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCont = TextEditingController();
    final TextEditingController userNameCont = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isLogin) ...[
                buildTextForm(
                  controller: userNameCont,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  lable: 'UserName',
                  validator: (vale) =>
                      vale!.isEmpty ? "User name Required " : null,
                ),
                const SizedBox(height: 10),
              ],
              buildTextForm(
                controller: emailCont,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                lable: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email Required";
                  } else {
                    if (isLogin) {
                      if (emailCont.text.trim() !=
                          authControllers.getcurrentUser.email) {
                        return "The email not matching with your crrent email.";
                      } else {
                        return emailForrmat(emailCont.text.trim());
                      }
                    } else {
                      return emailForrmat(emailCont.text.trim());
                    }
                  }
                },
              ),
              Obx(
                () => settingsController.error.value.isEmpty
                    ? Container()
                    : CustomText(
                        text: settingsController.error.value,
                        color: Colors.redAccent,
                        fontSize: 12,
                        maxLines: 3,
                      ),
              ),
              CustomButtom(
                bgColor: Colors.transparent,
                child: const CustomText(
                  text: 'Reset Password',
                  color: kBlueColor,
                  alignment: Alignment.center,
                ),
                onPreessed: () async {
                  if (formKey.currentState!.validate()) {
                    if (isLogin) {
                      settingsController.resetPassword(
                        emailCont.text.trim(),
                        isLogin,
                      );
                    } else {
                      showLoading();
                      dynamic userEmail = await authControllers
                          .getUserEmailByUserName(userNameCont.text.trim());

                      if (userEmail == null) {
                        settingsController.error.value = 'UserName not found..';
                        dismissLoadingWidget();
                      } else {
                        if (userEmail == emailCont.text.trim()) {
                          settingsController.resetPassword(
                            emailCont.text.trim(),
                            isLogin,
                          );
                        } else {
                          settingsController.error.value =
                              "The email not matching with your crrent email.";
                          dismissLoadingWidget();
                        }
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
