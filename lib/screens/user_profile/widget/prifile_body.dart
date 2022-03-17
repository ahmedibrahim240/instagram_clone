import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user.dart';
import '../../screens_export.dart';

class ProfileBody extends GetWidget<Usercontroller> {
  final String? uuid;
  final String? oldId;
  const ProfileBody({
    Key? key,
    this.uuid,
    this.oldId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.setUserProfileInitData(
          oldId ?? authControllers.currentUser.value.id!,
        );
        return true;
      },
      child: StreamBuilder(
        stream: controller.getUserData(uuid!),
        builder: (_, AsyncSnapshot<Usermodels> snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            );
          } else if (snap.hasError) {
            return const CustomText(
              text: 'error',
              alignment: Alignment.center,
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(kBlueColor),
              ),
            );
          } else {
            return BuildProfileBody(
              snap: snap,
              controller: controller,
            );
          }
        },
      ),
    );
  }
}
