import 'package:flutter/material.dart';

import '../core_export.dart';

class CircleImge extends StatelessWidget {
  final double radius, width, height;
  final String? url;
  final BoxFit boxFit;
  const CircleImge({
    Key? key,
    required this.radius,
    required this.width,
    required this.height,
    required this.url,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: CustomCachedNetworkImage(
          url: url,
          context: context,
          width: width,
          height: height,
          boxFit: boxFit,
        ),
      ),
    );
  }
}
