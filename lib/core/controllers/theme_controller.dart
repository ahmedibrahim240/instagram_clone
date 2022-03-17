import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../core_export.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();
  Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.system);
  final Rx<Color> _kPrimaryColor = Rx<Color>(kPrimaryColor);
  Color get getPrimaryColor => _kPrimaryColor.value;
  RxInt groupValue = 0.obs;
  int get getGroupValue => groupValue.value;
  Rx<bool> darkMode = false.obs;
  Rx<bool> isSystemMode = true.obs;
  @override
  void onInit() async {
    super.onInit();

    if (await MySharedPreferences.getisDartMode() == null &&
        await MySharedPreferences.getiisSystemMode() == null) {
      darkMode.value = false;
      isSystemMode.value = true;
      await MySharedPreferences.saveisDartMode(darkMode.value);
      await MySharedPreferences.saveisDartMode(isSystemMode.value);
    } else {
      darkMode.value = await MySharedPreferences.getisDartMode();
      isSystemMode.value = await MySharedPreferences.getiisSystemMode();
    }

    setInitData();
  }

  setInitData() async {
    if (isSystemMode.value) {
      groupValue.value = 2;
    } else {
      if (darkMode.value) {
        groupValue.value = 1;
      } else {
        groupValue.value = 0;
      }
    }
    await onChangedThemeMode();
  }

  getThemeMode() async {
    final _brightness = SchedulerBinding.instance!.window.platformBrightness;
    switch (_brightness) {
      case Brightness.dark:
        {
          themeMode.value = ThemeMode.dark;
          darkMode.value = true;
          await MySharedPreferences.saveisDartMode(darkMode.value);
          switchDartMode();
          update();
          break;
        }
      case Brightness.light:
        {
          themeMode.value = ThemeMode.light;
          darkMode.value = false;
          await MySharedPreferences.saveisDartMode(darkMode.value);
          switchDartMode();
          update();
          break;
        }
      default:
        {
          themeMode.value = ThemeMode.light;
          darkMode.value = false;
          await MySharedPreferences.saveisDartMode(darkMode.value);
          switchDartMode();
          update();
        }
    }
  }

  switchDartMode() {
    if (darkMode.value) {
      themeMode.value = ThemeMode.dark;
      update();
      primaryColorSwitch();
      return Get.changeTheme(AppTheme.darkTheme);
    } else {
      themeMode.value = ThemeMode.light;
      primaryColorSwitch();
      update();
      return Get.changeTheme(AppTheme.lightTheme);
    }
  }

  onChangedThemeMode() async {
    if (getGroupValue == 2) {
      isSystemMode.value = true;
      await MySharedPreferences.saveisSystemMode(isSystemMode.value);
      getThemeMode();
    } else {
      isSystemMode.value = false;
      await MySharedPreferences.saveisSystemMode(isSystemMode.value);
      if (getGroupValue == 1) {
        darkMode.value = true;
      } else {
        darkMode.value = false;
      }
      await MySharedPreferences.saveisDartMode(darkMode.value);

      switchDartMode();
    }
    darkMode.value = await MySharedPreferences.getisDartMode();
    isSystemMode.value = await MySharedPreferences.getiisSystemMode();

    update();
  }

  primaryColorSwitch() {
    switch (darkMode.value) {
      case true:
        {
          _kPrimaryColor.value = kPrimaryColor;
          break;
        }
      default:
        {
          _kPrimaryColor.value = kMobileBackgroundColor;
          break;
        }
    }
    update();
  }
}
