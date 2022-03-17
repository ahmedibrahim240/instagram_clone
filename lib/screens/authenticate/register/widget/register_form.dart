import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';
import '../../authenticate_export.dart';

class RegisterFrom extends StatelessWidget {
  const RegisterFrom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController bioController = TextEditingController();

    return GetBuilder(
      builder: (AuthControllers controller) => Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: defaultSize * 2),
            CustomTextFormField(
              controller: userNameController,
              onChanged: (username) {
                controller.newUserName.value = userNameController.text.trim();
              },
              onSaved: (userName) {
                controller.newUser.value.userName =
                    userNameController.text.trim();
              },
              lable: 'User Name',
              hintText: 'User name...',
              textInputType: TextInputType.name,
              validator: (vale) => vale!.isEmpty ? "User Name Required " : null,
            ),
            const ValidatorUserNameFormat(),
            SizedBox(height: defaultSize),
            CustomTextFormField(
              controller: nameController,
              textInputType: TextInputType.name,
              lable: 'Name',
              onSaved: (name) {
                controller.newUser.value.name = nameController.text.trim();
              },
              validator: (vale) => vale!.isEmpty ? "Name Required " : null,
              hintText: 'name...',
            ),
            SizedBox(height: defaultSize),
            CustomTextFormField(
              controller: bioController,
              lable: 'Bio',
              textInputType: TextInputType.text,
              onSaved: (bio) {
                controller.newUser.value.bio = bioController.text.trim();
              },
              validator: (vale) => vale!.isEmpty ? "Bio Required " : null,
              hintText: 'bio...',
            ),
            SizedBox(height: defaultSize),
            CustomTextFormField(
              controller: emailController,
              lable: 'Email',
              textInputType: TextInputType.emailAddress,
              onSaved: (email) {
                controller.newUser.value.email = emailController.text.trim();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "email Required";
                } else {
                  RegExp reg = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
                  bool match = reg.hasMatch(emailController.text.trim());
                  if (match) {
                    return null;
                  } else {
                    return "The email address is badly formatted.";
                  }
                }
              },
              hintText: 'expale@gmail.com',
            ),
            SizedBox(height: defaultSize),
            CustomTextFormField(
              controller: passwordController,
              lable: 'Password',
              textInputType: TextInputType.visiblePassword,
              validator: (vale) => vale!.isEmpty ? "Password Required " : null,
              hintText: '********',
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
              onSaved: (vale) {},
            ),
            SizedBox(height: defaultSize),
            GetBuilder<ImagePickerConttroller>(
              builder: (imageCont) => CustomButtom(
                bgColor: themeController.darkMode.value
                    ? kMobileSearchColor
                    : Colors.blueGrey.shade100,
                cardMargin: const EdgeInsets.symmetric(horizontal: 20),
                child: const CustomText(
                  text: 'SIGN UP',
                  alignment: Alignment.center,
                  color: kBlueColor,
                ),
                onPreessed: () {
                  if (imageCont.imagefile.value != '') {
                    if (!controller.isExistUserName.value &&
                        controller.isFormatUserName.value) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        controller.signUpWithEmailAndPawwrod(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      }
                    } else {
                      customErrorSnakBar(
                        error: 'Username is badly formatted or is Exist..\n'
                            "plese chose anther username",
                      );
                    }
                  } else {
                    customErrorSnakBar(
                      error: 'Select Image First..',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
