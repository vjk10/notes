import 'package:dynamic_color/dynamic_color.dart';
// import 'package:dynamic_colorscheme/dynamic_colorscheme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/screens/onboarding/onboarding_four.dart';
import 'package:notes/android/screens/onboarding/onboarding_one.dart';
import 'package:notes/android/screens/onboarding/onboarding_three.dart';
import 'package:notes/android/screens/onboarding/onboarding_two.dart';
import 'package:notes/android/screens/settings_screen.dart';
import 'package:notes/android/theme/android_theme.dart';
import 'package:notes/android/views/folders/add_folders_view.dart';
import 'package:notes/android/views/notes/add_notes_view.dart';
import 'package:notes/android/views/clipboard/clipboard_view.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/providers/android_app_themes.dart';
import 'package:notes/under_construction.dart';
import 'package:provider/provider.dart';

import 'android/screens/splash_screen.dart';
import 'windows/screens/splash_screen_win.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  token = await FirebaseMessaging.instance.getToken();
  await NotificationService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows && !kIsWeb) {
      // Windows Application
      return fluent_ui.FluentApp(
        debugShowCheckedModeBanner: kDebugMode,
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
      return ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
              builder: (context, ThemeNotifier notifier, child) {
            return DynamicColorBuilder(
                builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              if (lightDynamic != null && darkDynamic != null) {
                m3YouAvail = true;
                m3Light = lightDynamic.harmonized();
                m3Dark = darkDynamic.harmonized();
                if (notifier.material3) {
                  return ScreenUtilInit(
                    builder: (_, widget) => GetMaterialApp(
                      themeMode: ThemeMode.system,
                      debugShowCheckedModeBanner: kDebugMode,
                      theme: androidThemeDark.copyWith(
                        colorScheme: m3Light,
                        useMaterial3: true,
                        backgroundColor: m3Light!.background,
                        scaffoldBackgroundColor: m3Light!.background,
                        iconTheme: IconThemeData(color: m3Light!.onBackground),
                        listTileTheme:
                            ListTileThemeData(iconColor: m3Light!.onBackground),
                        appBarTheme: AppBarTheme(
                          toolbarHeight: 80,
                          iconTheme:
                              IconThemeData(color: m3Light!.onBackground),
                          backgroundColor: m3Light!.background,
                          surfaceTintColor: m3Light!.surfaceTint,
                        ),
                        brightness: Brightness.light,
                        dialogTheme: DialogTheme(
                          backgroundColor: m3Light!.background,
                        ),
                      ),
                      darkTheme: androidThemeRegular.copyWith(
                        colorScheme: m3Dark,
                        useMaterial3: true,
                        backgroundColor: m3Dark!.background,
                        scaffoldBackgroundColor: m3Dark!.background,
                        iconTheme: IconThemeData(color: m3Dark!.onBackground),
                        listTileTheme:
                            ListTileThemeData(iconColor: m3Dark!.onBackground),
                        appBarTheme: AppBarTheme(
                          toolbarHeight: 80,
                          iconTheme: IconThemeData(color: m3Dark!.onBackground),
                          backgroundColor: m3Dark!.background,
                          surfaceTintColor: m3Dark!.surfaceTint,
                        ),
                        brightness: Brightness.dark,
                        dialogTheme: DialogTheme(
                          backgroundColor: m3Dark!.background,
                        ),
                      ),
                      routes: {
                        '/splash': (context) => const SplashScreen(),
                        '/mainScreen': (context) => const MainScreen(
                              selectedIndex: 0,
                            ),
                        '/onboarding1': (context) => const OnBoarding1(),
                        '/onboarding2': (context) => const OnBoarding2(),
                        '/onboarding3': (context) => const OnBoarding3(),
                        '/onboarding4': (context) => const OnBoarding4(),
                        '/addFolder': (context) => const AddFolderView(),
                        '/addNote': (context) => const AddNoteView(),
                        '/settings': (contex) => const SettingsScreen(),
                        '/clipboard': (contex) => const ClipBoard(),
                      },
                      title: 'Notes',
                      home: const SplashScreen(),
                    ),
                    designSize: const Size(360, 800),
                  );
                } else {
                  return DynamicTheme(
                    themeCollection: themeCollection,
                    defaultThemeId: AppThemes.regular,
                    builder: (context, theme) => ScreenUtilInit(
                      builder: (_, widget) => GetMaterialApp(
                        debugShowCheckedModeBanner: kDebugMode,
                        theme: theme,
                        routes: {
                          '/splash': (context) => const SplashScreen(),
                          '/mainScreen': (context) => const MainScreen(
                                selectedIndex: 0,
                              ),
                          '/onboarding1': (context) => const OnBoarding1(),
                          '/onboarding2': (context) => const OnBoarding2(),
                          '/onboarding3': (context) => const OnBoarding3(),
                          '/onboarding4': (context) => const OnBoarding4(),
                          '/addFolder': (context) => const AddFolderView(),
                          '/addNote': (context) => const AddNoteView(),
                          '/settings': (contex) => const SettingsScreen(),
                          '/clipboard': (contex) => const ClipBoard(),
                        },
                        title: 'Notes',
                        home: const SplashScreen(),
                      ),
                      designSize: const Size(360, 800),
                    ),
                  );
                }
              } else {
                return DynamicTheme(
                  themeCollection: themeCollection,
                  defaultThemeId: AppThemes.regular,
                  builder: (context, theme) => ScreenUtilInit(
                    builder: (_, widget) => GetMaterialApp(
                      debugShowCheckedModeBanner: kDebugMode,
                      theme: theme,
                      routes: {
                        '/splash': (context) => const SplashScreen(),
                        '/mainScreen': (context) => const MainScreen(
                              selectedIndex: 0,
                            ),
                        '/onboarding1': (context) => const OnBoarding1(),
                        '/onboarding2': (context) => const OnBoarding2(),
                        '/onboarding3': (context) => const OnBoarding3(),
                        '/onboarding4': (context) => const OnBoarding4(),
                        '/addFolder': (context) => const AddFolderView(),
                        '/addNote': (context) => const AddNoteView(),
                        '/settings': (contex) => const SettingsScreen(),
                        '/clipboard': (contex) => const ClipBoard(),
                      },
                      title: 'Notes',
                      home: const SplashScreen(),
                    ),
                    minTextAdapt: true,
                    designSize: const Size(360, 800),
                  ),
                );
              }
            });
          }));
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
