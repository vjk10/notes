import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/screens/onboarding/onboarding_one.dart';
import 'package:notes/android/screens/onboarding/onboarding_three.dart';
import 'package:notes/android/screens/onboarding/onboarding_two.dart';
import 'package:notes/android/screens/settings_screen.dart';
import 'package:notes/under_construction.dart';
import 'package:notes/windows/screens/splash_screen_win.dart';
import 'package:notes/windows/screens/theme/windows_theme.dart';

import 'android/screens/splash_screen.dart';
import 'android/theme/android_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows && !kIsWeb) {
      // Windows Application
      return fluent_ui.FluentApp(
        debugShowCheckedModeBanner: kDebugMode,
        theme: windowsThemeLight,
        darkTheme: windowsThemeDark,
        themeMode: fluent_ui.ThemeMode.system,
        routes: {
          '/splash': (context) => const SplashScreenWin(),
        },
        title: 'Notes',
        home: const SplashScreenWin(),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android Application
      return GetMaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        theme: androidThemeLight,
        darkTheme: androidThemeDark,
        themeMode: ThemeMode.system,
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/mainScreen': (context) => const MainScreen(),
          '/onboarding1': (context) => const OnBoarding1(),
          '/onboarding2': (context) => const OnBoarding2(),
          '/onboarding3': (context) => const OnBoarding3(),
          '/settings': (contex) => const SettingsScreen(),
        },
        title: 'Notes',
        home: const SplashScreen(),
      );
    }
    if (kIsWeb) {
      return GetMaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          title: 'Notes',
          debugShowCheckedModeBanner: kDebugMode,
          home: const UnderConstruction());
    }
    return GetMaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: kDebugMode,
        title: 'Notes',
        home: const UnderConstruction());
  }
}
