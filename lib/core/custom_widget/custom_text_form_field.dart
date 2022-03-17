import 'package:flutter/material.dart';
import '../core_export.dart';

class CustomTextFormField extends StatelessWidget {
  final String? lable;
  final String hintText;
  final bool? obscureText;
  final bool? filled;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? suffixIcon;
  const CustomTextFormField({
    Key? key,
    this.lable,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.onSaved,
    required this.controller,
    this.validator,
    this.onChanged,
    this.filled = true,
    this.initialValue = '',
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Column(
      children: [
        TextFormField(
          onSaved: onSaved,
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          obscureText: obscureText!,
          decoration: customTextFormDecoratins(
            inputBorder: inputBorder,
          ),
        ),
      ],
    );
  }

  customTextFormDecoratins({required OutlineInputBorder inputBorder}) {
    return InputDecoration(
      focusedBorder: inputBorder,
      suffixIcon: suffixIcon,
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 2,
        ),
      ),
      enabledBorder: inputBorder,
      labelText: lable,
      labelStyle: const TextStyle(
        color: kBlueColor,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: kSecondaryColor,
      ),
      filled: true,
    );
  }
}
