import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes/services/utils.dart';
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
        "conditions": false,
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
      backgroundColor: c.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/onboarding1.png",
              width: (Get.statusBarHeight - 100).isNegative
                  ? Get.width - 50
                  : Get.width.w,
              fit: (Get.statusBarHeight - 100).isNegative
                  ? BoxFit.scaleDown
                  : BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: Get.height / 9.h,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "notes",
                    style: t.textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width - 30.w,
                    child: Text(
                      onBoarding1Message,
                      style: t.textTheme.bodyText1?.copyWith(
                        fontSize: 14.sp,
                        color: c.onBackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 130.w,
                    height: 60.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: c.primary,
                        elevation: 20,
                        shadowColor: c.background,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(50),
                        // ),
                      ),
                      onPressed: () async {
                        bool conditions = await Utils().checkTerms();
                        if (conditions == false) {
                          // ignore: use_build_context_synchronously
                          Utils().licenseDialog(context, t, c, true);
                        } else {
                          Get.toNamed('/onboarding2');
                        }
                      },
                      child: Text(
                        "Get Started",
                        style: t.textTheme.button?.copyWith(
                          fontSize: 14.sp,
                          color: c.onPrimary,
                        ),
                      ),
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
