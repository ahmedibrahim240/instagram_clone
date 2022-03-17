import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens_export.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(flex: 1),
          const AuthLogo(),
          const Spacer(flex: 1),
          const LoginForm(),
          CustomButtom(
            bgColor: Colors.transparent,
            child: const CustomText(
              text: 'Forgetting password?',
              color: kBlueColor,
              alignment: Alignment.center,
            ),
            onPreessed: () {
              routeController.routePage(
                type: RouteType.To,
                page: () => const ChangePasswordScreen(
                  isLogin: false,
                  forgetting: true,
                ),
                transition: Transition.downToUp,
              );
            },
          ),
          const Spacer(flex: 1),
          const AuthScreenRowText(
            mass: 'Dont have an account?',
            buttomText: ' Signup.',
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
