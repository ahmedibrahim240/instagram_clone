import 'package:flutter/material.dart';

import '../core_export.dart';

class CustomCircleIconBouttom extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? bgColor;
  final Color? iconsColor;
  const CustomCircleIconBouttom({
    Key? key,
    required this.onTap,
    required this.icon,
    this.width = 30,
    this.height = 30,
    this.bgColor = kMobileSearchColor,
    this.iconsColor,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: iconsColor,
          ),
        ),
      ),
    );
  }
}
