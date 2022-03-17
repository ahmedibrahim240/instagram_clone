import 'package:flutter/material.dart';
import '../core_export.dart';

class CustomButtom extends StatelessWidget {
  final Widget child;
  final Function onPreessed;

  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final double borderWidth;
  final double borderRdius;
  final EdgeInsetsGeometry? cardMargin;

  const CustomButtom({
    Key? key,
    required this.child,
    required this.onPreessed,
    this.bgColor,
    this.borderColor = Colors.transparent,
    this.margin,
    this.borderWidth = 1.0,
    this.borderRdius = 5,
    this.cardMargin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPreessed(),
      child: Card(
        elevation: 0.0,
        color: bgColor,
        margin: cardMargin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRdius),
          ),
          side: BorderSide(
            color: borderColor!,
            width: borderWidth,
          ),
        ),
        child: Container(
          margin: margin ??
              EdgeInsets.symmetric(
                vertical: defaultSize * 2,
                horizontal: defaultSize * 2,
              ),
          child: child,
        ),
      ),
    );
  }
}
