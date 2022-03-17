import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens_export.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: NetworkSensitive(
          child: (authControllers.isSginUpScreen.value)
              ? const RegisterScreen()
              : const LogInScreen(),
        ),
      ),
    );
  }
}
