import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/data/data.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/other/auth_services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/isar_db/onboarding_schema.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? onboarded = "false";
  @override
  void initState() {
    getAppInfo();
    getNotificationPermission();
    checkOnboarding();
    super.initState();
  }

  checkOnboarding() async {
    await StaticData.isarDb.onboardings.get(1).then((value) {
      onboarded = value?.onboarding;
    });
    if (onboarded == "true") {
      await AuthServices().authChanges(true);
    } else {
      if (kDebugMode) {
        print("Trigger 2");
      }
      AuthServices().startOnboarding();
    }
  }

  getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    StaticData.appName = packageInfo.appName;
    StaticData.packageName = packageInfo.packageName;
    StaticData.version = packageInfo.version;
    StaticData.buildNumber = packageInfo.buildNumber;
  }

  getNotificationPermission() async {
    await Permission.notification.request();
  }

  @override
  void didChangeDependencies() {
    StaticData.t = Theme.of(context);
    StaticData.c = StaticData.t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: "logoTag",
                child: Text(
                  "notes",
                  style:
                      StaticData.t.textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NotesLoadingAndroid(
                  strokeWidth: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "loading your notes",
                    style: StaticData.t.textTheme.titleLarge,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
