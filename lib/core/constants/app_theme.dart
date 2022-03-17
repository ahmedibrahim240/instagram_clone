import 'package:flutter/material.dart';

import '../core_export.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kMobileBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kMobileBackgroundColor,

      centerTitle: false,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),

      titleTextStyle: TextStyle(
        color: kPrimaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      // ignore: deprecated_member_use
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: kPrimaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: kPrimaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: kMobileBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: kMobileBackgroundColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      // ignore: deprecated_member_use
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: kMobileBackgroundColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: kMobileBackgroundColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
