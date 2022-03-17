import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class EditProfileDataView extends StatelessWidget {
  final String title, textView;

  const EditProfileDataView({
    Key? key,
    required this.title,
    required this.textView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        routeController.routePage(
          type: RouteType.To,
          page: EditDataForm(
            title: title,
            initData: textView,
            isUserName: title == 'Username',
            isBio: title == 'Bio',
          ),
          transition: Transition.downToUp,
        );
      },
      child: Column(
        children: [
          CustomText(
            text: title,
            fontSize: 13,
            color: kSecondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CustomText(
                  text: textView,
                  color: themeController.getPrimaryColor,
                ),
                const SizedBox(height: 4),
                Divider(
                  color: themeController.getPrimaryColor,
                  thickness: 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
