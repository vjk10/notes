import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../data/data.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  void initState() {
    startOnboarding();
    super.initState();
  }

  startOnboarding() async {
    await ScientISSTdb.instance
        .collection("userPref")
        .document("onboarding")
        .set(
      {
        "completed": false,
      },
    );
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
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/onboarding1.png",
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: c.primary,
                    elevation: 20,
                    shadowColor: c.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/onboarding2');
                  },
                  child: Text(
                    "Get Started",
                    style: t.textTheme.button?.copyWith(
                      fontSize: 18,
                      color: c.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height / 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.statusBarHeight - 100,
                  ),
                  const NotesLogo(
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width - 30,
                    child: Text(
                      onBoarding1Message,
                      style: t.textTheme.bodyText1?.copyWith(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
