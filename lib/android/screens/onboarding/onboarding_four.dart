import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding4 extends StatefulWidget {
  const OnBoarding4({Key? key}) : super(key: key);

  @override
  State<OnBoarding4> createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
  String selectedTheme = "";
  int selectedThemeId = 0;
  bool material3Available = false;

  @override
  void initState() {
    themesList = themes.toList();
    getTheme();
    super.initState();
  }

  getTheme() async {
    if (m3YouAvail) {
      var primary = palette.primary.toString();
      if (primary.isNotEmpty) {
        setState(() {
          material3Available = true;
        });
      }
    }
    var pref = await SharedPreferences.getInstance();
    selectedThemeId = pref.getInt(primaryKey) ?? 1;
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
          Container(
              width: Get.width.w,
              height: Get.height.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/onboarding4.png",
                  ),
                  fit: BoxFit.cover,
                ),
              )),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (material3Available)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: (Get.statusBarHeight).h,
                      ),
                      Text(
                        "Hey, Your device supports dynamic color!",
                        style: t.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<ThemeNotifier>(
                        builder: (context, notifier, child) => FlutterSwitch(
                          activeColor: c.primary,
                          activeIcon: Center(
                            child: Icon(
                              Icons.palette_outlined,
                              color: c.onPrimaryContainer,
                            ),
                          ),
                          activeTextColor: c.onPrimary,
                          activeToggleColor: c.onPrimary,
                          inactiveColor: c.secondary,
                          inactiveIcon: Center(
                            child: Icon(
                              Icons.highlight_off_rounded,
                              color: c.surfaceVariant,
                            ),
                          ),
                          inactiveTextColor: c.surfaceVariant,
                          inactiveToggleColor: c.outline,
                          width: 150.w,
                          height: 70.h,
                          valueFontSize: 18.0.sp,
                          toggleSize: 35.0,
                          value: notifier.material3,
                          borderRadius: 50.0,
                          padding: 8.0.w,
                          // showOnOff: true,
                          onToggle: (val) {
                            HapticFeedback.heavyImpact();
                            notifier.toggleTheme();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Switch on to use dynamic color",
                        style: t.textTheme.bodyLarge,
                      )
                    ],
                  ),
                const SizedBox(
                  height: 50,
                ),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Visibility(
                    visible: !notifier.material3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pick a Primary",
                          style: t.textTheme.headline4?.copyWith(
                            fontFamily: 'Theme Black',
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Consumer<ColorNotifier>(
                          builder: (context, notifier, child) {
                            return SizedBox(
                              width: Get.width.w,
                              height: (Get.bottomBarHeight + 100).h,
                              child: Center(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: primaryList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                          // Get.back();
                                          if (kDebugMode) {
                                            print(index);
                                          }
                                          setState(() {
                                            selectedThemeId = index;
                                            notifier.toggleColor(index + 1);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: c.onBackground,
                                                width: 2,
                                              )),
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? primaryList[index]["primary"]
                                                : primaryList[index]
                                                    ["primaryDark"],
                                            minRadius: 24,
                                            child: Visibility(
                                              visible: selectedThemeId == index,
                                              child: Center(
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  color: c.onBackground,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150.w,
                  height: 70.h,
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
                      await ScientISSTdb.instance
                          .collection("userPref")
                          .document("onboarding")
                          .set(
                        {
                          "completed": true,
                          "conditions": true,
                        },
                      );
                      Get.offAllNamed('/mainScreen');
                    },
                    child: Text(
                      "Continue",
                      style: t.textTheme.button?.copyWith(
                        fontSize: 18.sp,
                        color: c.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
