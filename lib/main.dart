// import 'package:dynamic_colorscheme/dynamic_colorscheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:notes/data/data.dart';
import 'package:notes/android/screens/onboarding/onboarding_one.dart';
import 'package:notes/android/screens/onboarding/onboarding_two.dart';
import 'package:notes/android/screens/settings_screen.dart';
import 'package:notes/android/theme/android_theme.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/services/isar_db/isar_db.dart';
import 'package:notes/under_construction.dart';

import 'android/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StaticData.isarDb = await IsarDB().instantiate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.windows) {
      // Android Application
      return GetMaterialApp(
        defaultTransition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 800),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: kDebugMode,
        theme: productiveTheme,
        darkTheme: productiveTheme,
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding1': (context) => const OnBoarding1(),
          '/onboarding2': (context) => const OnBoarding2(),
          '/settings': (contex) => const SettingsScreen(),
        },
        title: 'Notes',
        home: const SplashScreen(),
      );
    }
    return GetMaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Notes',
      home: const UnderConstruction(),
    );
  }
}
