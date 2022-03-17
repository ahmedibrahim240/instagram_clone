import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class SettingsModels {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  SettingsModels({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

List<SettingsModels> settingsBodyList = [
  SettingsModels(
    onTap: () {
      routeController.routePage(
        type: RouteType.To,
        page: () => const ChangePasswordScreen(),
        transition: Transition.downToUp,
      );
    },
    title: 'Password',
    icon: Icons.key_outlined,
  ),
  SettingsModels(
    onTap: () {
      routeController.routePage(
        type: RouteType.To,
        page: () => const ChangeTheme(),
      );
    },
    title: 'Theme',
    icon: Icons.color_lens_rounded,
  ),
];
