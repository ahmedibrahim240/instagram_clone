import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/controllers/controllers_export.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? textHeight;
  final Alignment? alignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  const CustomText({
    Key? key,
    required this.text,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.maxLines,
    this.alignment = Alignment.centerLeft,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign,
    this.textHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: GetBuilder(
        builder: (ThemeController controller) => Text(
          text,
          overflow: textOverflow,
          maxLines: maxLines,
          textAlign: textAlign,
          style: TextStyle(
            color: (color == null) ? controller.getPrimaryColor : color,
            height: textHeight,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
