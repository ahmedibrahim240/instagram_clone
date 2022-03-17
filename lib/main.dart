// ignore_for_file: invalid_language_version_override

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';
import 'package:instagram_clone/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await initializationFireBaseWeb;
  } else {
    await initializationFireBaseApp;
  }

  var initialData = await ConnectivityService().getIntState();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (_) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: initialData,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (themeController.isSystemMode.value) {
        themeController.getThemeMode();
      }

      return;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: Get.put<ThemeController>(ThemeController()),
      builder: (ThemeController controller) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        title: 'Instagram clone Demo',
        themeMode: controller.themeMode.value,
        theme: controller.switchDartMode(),
        darkTheme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
