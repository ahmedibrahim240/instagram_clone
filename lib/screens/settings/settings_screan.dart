import 'package:flutter/material.dart';

import '../screens_export.dart';

class SettingsScrean extends StatelessWidget {
  const SettingsScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
      ),
      body: const SettingsBody(),
    );
  }
}
