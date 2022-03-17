import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

import '../../../models/user.dart';

class BuildRowButtons extends StatelessWidget {
  final Usercontroller controller;
  final AsyncSnapshot<Usermodels> snap;

  const BuildRowButtons({
    Key? key,
    required this.controller,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: FollowButtom(
              user: snap.data!,
            ),
          ),
          const SizedBox(width: 5),
          CustomButtom(
            onPreessed: () {
              controller.showDiscoverPeople.value =
                  !controller.showDiscoverPeople.value;
              controller.updataloadDiscoverPeople(true);
            },
            bgColor: controller.showDiscoverPeople.value
                ? kSecondaryColor
                : Colors.transparent,
            borderColor: kSecondaryColor,
            borderWidth: 1,
            borderRdius: 5,
            cardMargin: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: controller.loadDiscoverPeople.value
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          kPrimaryColor,
                        ),
                        strokeWidth: 2.0,
                      ),
                    )
                  : Icon(
                      controller.showDiscoverPeople.value
                          ? FontAwesomeIcons.userMinus
                          : FontAwesomeIcons.userPlus,
                      size: 15,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
