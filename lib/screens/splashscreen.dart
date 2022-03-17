import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class SplashScreen extends GetWidget<ThemeController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: NetworkSensitive(
        child: Center(
          child: SvgPicture.asset(
            instagramSvg,
            color: controller.getPrimaryColor,
            height: 64,
          ),
        ),
      ),
    );
  }
}
