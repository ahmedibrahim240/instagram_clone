import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

import '../../models/user.dart';

class FollowButtom extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? cardMargin;

  const FollowButtom({
    Key? key,
    required this.user,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.cardMargin,
  }) : super(key: key);

  final Usermodels user;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: Get.put<Usercontroller>(Usercontroller()),
        initState: (GetXState<Usercontroller> intiState) {
          intiState.controller!.getSecndUserData(user.id!);
        },
        builder: (Usercontroller controller) {
          return CustomButtom(
            onPreessed: () {
              FollowState followState =
                  controller.checkFollowUserState(user.id!);
              if (followState == FollowState.IsMe) {
                routeController.routePage(
                  type: RouteType.To,
                  page: const EditProfileScren(),
                  transition: Transition.downToUp,
                );
              } else {
                controller.folloUser(followId: user.id!);
              }
            },
            bgColor: _getBgCollor(controller, user.id!),
            borderColor: _getBorderColor(controller, user.id!),
            borderWidth: 1,
            borderRdius: 5,
            margin: margin,
            cardMargin: cardMargin,
            child: CustomText(
              text: _getButtomText(controller, user.id!).toString(),
              fontSize: 14,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ),
          );
        });
  }

  _getButtomText(Usercontroller controller, String id) {
    FollowState followState = controller.checkFollowUserState(id);

    late String title;

    switch (followState) {
      case FollowState.IsMe:
        {
          title = 'Edit Proifle';
          return title;
        }
      case FollowState.Follow:
        {
          title = 'Follow';
          return title;
        }
      case FollowState.UnFollow:
        {
          title = 'UnFollow';
          return title;
        }
      case FollowState.FollowBack:
        {
          title = 'Follow back';
          return title;
        }
      default:
        {
          return '';
        }
    }
  }

  _getBgCollor(Usercontroller controller, String id) {
    FollowState followState = controller.checkFollowUserState(id);

    switch (followState) {
      case FollowState.Follow:
        {
          return kBlueColor;
        }

      default:
        {
          return Colors.transparent;
        }
    }
  }

  _getBorderColor(Usercontroller controller, String id) {
    FollowState followState = controller.checkFollowUserState(id);

    switch (followState) {
      case FollowState.Follow:
        {
          return Colors.transparent;
        }

      default:
        {
          return kSecondaryColor;
        }
    }
  }
}
