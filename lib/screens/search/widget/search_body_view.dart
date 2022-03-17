import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';
import '../../../models/user.dart';

class SearchBodyView extends StatelessWidget {
  final SearchController controller;
  const SearchBodyView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.searchByUserName(),
      builder: (_, AsyncSnapshot<List<Usermodels>> snap) {
        if (!snap.hasData) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: CustomText(
              text: 'No results found for'
                  "${controller.searshText.value}",
              fontSize: 14,
              alignment: Alignment.topCenter,
            ),
          );
        } else if (snap.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                CustomText(
                  text: 'Searching for'
                      "${controller.searshText.value}",
                  alignment: Alignment.topCenter,
                  fontSize: 14,
                  maxLines: 3,
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              if (snap.data!.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomText(
                    text: 'No results found for'
                        " \"${controller.searshText.value}\"",
                    fontSize: 14,
                    alignment: Alignment.topLeft,
                    maxLines: 3,
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: snap.data!.length,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        usercontroller.setUserProfileInitData(
                          snap.data![index].id!,
                        );
                        Get.to(
                          () => UserProfileScrean(uuid: snap.data![index].id!),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: _buildListTile(snap.data![index]),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  _buildListTile(Usermodels user) {
    return ListTile(
      title: CustomText(
        text: user.userName!,
        alignment: Alignment.centerLeft,
        fontSize: 13,
      ),
      subtitle: CustomText(
        text: user.name!,
        color: kSecondaryColor,
        alignment: Alignment.centerLeft,
        fontSize: 12,
      ),
      leading: CircleImge(
        height: 55,
        width: 55,
        radius: 30,
        url: user.image,
        boxFit: BoxFit.cover,
      ),
    );
  }
}
