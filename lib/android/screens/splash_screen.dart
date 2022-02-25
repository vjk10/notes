import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/theme/colors.dart';
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
    Future.delayed(const Duration(seconds: 2), () async {
      AdaptiveTheme.of(context).setSystem();
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
            const Center(
              child: Hero(
                tag: "logoTag",
                child: NotesLogo(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator.adaptive(
                  backgroundColor: white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Loading your notes",
                    style: TextStyle(
                      color: white,
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
