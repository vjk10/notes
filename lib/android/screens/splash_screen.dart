import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scientisst_db/scientisst_db.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late DocumentSnapshot _onboardingSnapshot;

  @override
  void initState() {
    getTheme();
    getAppInfo();
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        _onboardingSnapshot = await ScientISSTdb.instance
            .collection("userPref")
            .document("onboarding")
            .get();
        if (kDebugMode) {
          print("ONBOARDING COMPLETED: " +
              _onboardingSnapshot.data["completed"].toString());
        }
        if (_onboardingSnapshot.data["completed"] == true) {
          Get.offNamedUntil('/mainScreen', (route) => false);
        } else {
          Get.offNamedUntil('/onboarding1', (route) => false);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        Get.offNamedUntil('/onboarding1', (route) => false);
      }
    });
    super.initState();
  }

  getTheme() {
    var themeID = DynamicTheme.of(context)!.themeId;
    setState(() {
      selectedThemeId = themeID;
    });

    if (kDebugMode) {
      print("SELECTED THEME: " + selectedThemeId.toString());
    }
  }

  getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: t.textTheme.headline6?.copyWith(fontSize: 24),
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
                const NotesLoadingAndroid(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Loading your notes",
                    style: TextStyle(
                      color: c.onBackground,
                      fontFamily: 'Theme Black',
                      fontSize: 18,
                    ),
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
