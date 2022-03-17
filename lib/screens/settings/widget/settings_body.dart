import 'package:flutter/material.dart';
import 'package:instagram_clone/models/settings_models.dart';

import '../../screens_export.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: settingsBodyList.length,
          itemBuilder: (_, index) {
            SettingsModels settingsModels = settingsBodyList[index];
            return TextButton.icon(
              onPressed: settingsModels.onTap,
              icon: Transform.rotate(
                angle: (index != 0) ? 0 : 180 * 3.14 / 100,
                child: Icon(
                  settingsModels.icon,
                  color: themeController.getPrimaryColor,
                  size: 25,
                ),
              ),
              label: CustomText(
                text: settingsModels.title,
                fontSize: 12,
              ),
            );
          },
          separatorBuilder: (_, index) => SizedBox(
            height: defaultSize,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Divider(
            thickness: 1.5,
            color: kBlueColor,
          ),
        ),
        const CustomText(
          text: 'Logins',
        ),
        SizedBox(height: defaultSize),
        TextButton(
          onPressed: () {
            authControllers.signOut();
          },
          child: const CustomText(
            text: 'LogOut',
            color: kBlueColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
