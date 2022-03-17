// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static String dartMode = 'isDartMode';
  static String systemMode = 'isSystemMode';
  static String userPassword = 'userPassword';

  //!save data
  static Future<bool> saveisDartMode(bool isDartMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(dartMode, isDartMode);
  }

  static Future<bool> saveUserPassword(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userPassword, password);
  }

  static Future<bool> saveisSystemMode(bool isSystemMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(systemMode, isSystemMode);
  }
  //!end save data

  //todo get data
  static getisDartMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(dartMode);
  }

  static getUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(userPassword);
  }

  static getiisSystemMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(systemMode);
  }
  //todo ned get data
}
