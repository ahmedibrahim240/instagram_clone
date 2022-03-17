import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user.dart';
import '../../screens_export.dart';

class BuildProfileBody extends StatelessWidget {
  final AsyncSnapshot<Usermodels> snap;
  final Usercontroller controller;
  const BuildProfileBody({
    Key? key,
    required this.snap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bildAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                ProfileHeader(snap: snap),
                BuildRowButtons(
                  controller: controller,
                  snap: snap,
                ),
                Obx(
                  () => controller.showDiscoverPeople.value
                      ? DiscoverPeople(
                          // controller: controller,
                          userID: snap.data!.id!,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultSize,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: BuildUsersPost(snap: snap),
          ),
        ],
      ),
    );
  }

  _bildAppBar() {
    return AppBar(
      title: Text(snap.data!.userName!),
      centerTitle: false,
      actions:
          (controller.checkFollowUserState(snap.data!.id!) == FollowState.IsMe)
              ? [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_box_outlined),
                  ),
                  IconButton(
                    onPressed: () => viewProfileBottomSheet(),
                    icon: const Icon(Icons.menu_sharp),
                  ),
                ]
              : null,
    );
  }
}
