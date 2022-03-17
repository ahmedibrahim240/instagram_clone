import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class AuthScreenRowText extends StatelessWidget {
  final String mass, buttomText;

  const AuthScreenRowText({
    Key? key,
    required this.mass,
    required this.buttomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: CustomText(
            text: mass,
            fontSize: 12,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        GetBuilder<AuthControllers>(
          builder: (cont) => GestureDetector(
            onTap: () {
              cont.isSginUpScreen.value = !cont.isSginUpScreen.value;
              cont.setUserInitData();
            },
            child: Container(
              child: CustomText(
                text: buttomText,
                color: kBlueColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}
