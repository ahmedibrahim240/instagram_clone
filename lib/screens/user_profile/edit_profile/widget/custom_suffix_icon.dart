import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String initData;

  const CustomSuffixIcon({Key? key, required this.initData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (authControllers.getcurrentUser.userName ==
            editProfileController.userName.value) {
          return const SizedBox(height: 0, width: 0);
        } else if (authControllers.validatorUserNameFormat(
          editProfileController.userName.value,
        )) {
          return StreamBuilder(
            stream: authControllers.checkUsernameExist(
              editProfileController.userName.value,
            ),
            builder: (context, AsyncSnapshot<bool> snap) {
              if (!snap.hasData) {
                return const SizedBox(height: 0, width: 0);
              } else if (snap.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                bool? isExist = snap.data;

                if (isExist == null) {
                  return const SizedBox(height: 0, width: 0);
                } else {
                  editProfileController.isExistUserName.value = isExist;
                  editProfileController.isFormatUserName.value =
                      authControllers.validatorUserNameFormat(
                    editProfileController.userName.value,
                  );

                  if (isExist) {
                    return const Icon(
                      Icons.close,
                      color: Colors.red,
                    );
                  } else {
                    return const Icon(
                      Icons.done,
                      color: kBlueColor,
                    );
                  }
                }
              }
            },
          );
        } else {
          return const Icon(
            Icons.close,
            color: Colors.red,
          );
        }
      },
    );
  }
}
