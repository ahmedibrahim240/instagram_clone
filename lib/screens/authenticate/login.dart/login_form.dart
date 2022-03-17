import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return GetBuilder<AuthControllers>(
      builder: (controller) => Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            CustomTextFormField(
              controller: emailController,
              onSaved: (value) {},
              validator: (value) => (value!.isEmpty) ? "email Required" : null,
              textInputType: TextInputType.emailAddress,
              hintText: 'username or email',
            ),
            SizedBox(height: defaultSize * 2),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'password',
              textInputType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.viewPassFun();
                },
                icon: Icon(
                  (controller.viewPass.value)
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                color: (controller.viewPass.value)
                    ? kBlueColor
                    : themeController.getPrimaryColor,
              ),
              obscureText: !controller.viewPass.value,
              validator: (value) => value!.isEmpty ? "Passwrod Required" : null,
              onSaved: (value) {},
            ),
            SizedBox(height: defaultSize * 2),
            CustomButtom(
              bgColor: themeController.darkMode.value
                  ? kMobileSearchColor
                  : Colors.blueGrey.shade100,
              cardMargin: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomText(
                text: 'SIGN IN',
                alignment: Alignment.center,
                color: kBlueColor,
              ),
              onPreessed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  controller.signInWithEmailAndPawwrod(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
