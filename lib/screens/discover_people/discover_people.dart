import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class DiscoverPeople extends StatelessWidget {
  final String userID;
  const DiscoverPeople({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: Get.put<Usercontroller>(Usercontroller()),
      initState: (GetXState<Usercontroller> initState) {
        initState.controller!.discoverPeopleList.bindStream(
          initState.controller!
              .discoverPeople(initState.controller!.userProfileId.value),
        );
      },
      builder: (Usercontroller controller) {
        if (controller.getDiscoverPeopleList.isEmpty) {
          if (controller.loadDiscoverPeople.value) {
            Future.delayed(
              const Duration(seconds: 1),
              () => controller.updataloadDiscoverPeople(false),
            );
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomText(
                text: 'No People to show..',
                fontSize: 12,
                alignment: Alignment.center,
              ),
            ),
          );
        } else {
          return Container(
            height: 200,
            margin: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemCount: controller.getDiscoverPeopleList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                if (controller.loadDiscoverPeople.value) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () => controller.updataloadDiscoverPeople(false),
                  );
                }
                return InkWell(
                  onTap: () {
                    controller.loadDiscoverPeople.value = false;
                    controller.showDiscoverPeople.value = false;
                    Get.to(
                      () => ProfileBody(
                        uuid: controller.getDiscoverPeopleList[index].id,
                        oldId: userID,
                      ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                    controller.setUserProfileInitData(
                      controller.getDiscoverPeopleList[index].id!,
                    );
                  },
                  child: BuildDiscoverPeopleCard(
                    user: controller.getDiscoverPeopleList[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 5),
            ),
          );
        }
      },
    );
  }
}
