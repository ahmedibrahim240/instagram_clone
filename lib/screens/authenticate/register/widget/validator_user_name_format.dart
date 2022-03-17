import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class ValidatorUserNameFormat extends StatelessWidget {
  const ValidatorUserNameFormat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (authControllers.userName.isEmpty) {
          return Container();
        } else if (authControllers
            .validatorUserNameFormat(authControllers.userName)) {
          return const CheckUserName();
        } else {
          return const CustomText(
            text: ''' - more than 6 letters username must not contain
                       - [ __,._,-,_.,..,space ]
                      - [ .,_ ] in first or last''',
            fontSize: 10,
            color: Colors.redAccent,
          );
        }
      },
    );
  }
}

class CheckUserName extends StatelessWidget {
  const CheckUserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: authControllers.checkUsernameExist(
            authControllers.userName,
          ),
          builder: (context, AsyncSnapshot<bool> snap) {
            if (!snap.hasData) {
              return Container();
            } else if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            } else {
              bool? isExist = snap.data;

              if (isExist == null) {
                authControllers.isExistUserName.value = false;

                return Container();
              } else {
                authControllers.isExistUserName.value = isExist;
                return checkEixtBody(isExist);
              }
            }
          },
        ),
      ),
    );
  }

  checkEixtBody(bool isExist) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CustomText(
              text: authControllers.userName,
              fontSize: 10,
              color: !isExist ? kBlueColor : Colors.red,
            ),
            if (isExist)
              CustomText(
                text: ' Is already exist',
                fontSize: 10,
                color: !isExist ? kBlueColor : Colors.red,
              ),
          ],
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: !isExist ? kBlueColor : Colors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isExist ? Icons.close : Icons.done,
            size: 15,
          ),
        ),
      ],
    );
  }
}
