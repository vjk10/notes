import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../../android/data/data.dart';

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
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/onboarding1.png",
              width: Get.width.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150.w,
                height: 70.h,
                child: Button(
                  onPressed: () {
                    Get.toNamed('/onboarding2');
                  },
                  child: Text(
                    "Get Started",
                    style: t.textTheme.button?.copyWith(
                      fontSize: 18.sp,
                      color: c.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height / 8.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: (Get.statusBarHeight - (Get.height / 2)).isNegative
                    ? c.surface
                    : Colors.transparent,
              ),
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
                          fontSize: 18.sp,
                          color: c.onBackground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
