import 'package:dynamic_themes/dynamic_themes.dart';
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

import '../../../services/theme/android_app_themes.dart';

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
    try {
      var themeID = DynamicTheme.of(context)!.themeId;
      setState(() {
        selectedThemeId = themeID;
        selectedTheme = AppThemes().getThemeName(themeID);
      });

      if (kDebugMode) {
        print("SELECTED THEME: $selectedTheme");
      }
    } catch (e) {
      var pref = await SharedPreferences.getInstance();
      selectedThemeId = pref.getInt('selectedThemeId')!;
      if (kDebugMode) {
        print("Selected Theme: $selectedThemeId");
      }
      if (selectedTheme.isEmpty) {
        setState(() {
          selectedTheme = AppThemes().getThemeName(selectedThemeId);
        });
      }
    }
  }

  void changeTheme(int index, BuildContext context) {
    HapticFeedback.heavyImpact();
    Get.back();
    setState(() {
      selectedTheme = AppThemes().getThemeName(index);
      selectedThemeId = index;
    });
    DynamicTheme.of(context)!.setTheme(index);
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
                        "hey! your device supports dynamic color :)",
                        style: t.textTheme.headline6,
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
                              color: c.onError,
                            ),
                          ),
                          inactiveTextColor: c.onSecondary,
                          inactiveToggleColor: c.error,
                          width: 150.w,
                          height: 70.h,
                          valueFontSize: 18.0.sp,
                          toggleSize: 35.0,
                          value: notifier.material3,
                          borderRadius: 50.0,
                          padding: 8.0.w,
                          showOnOff: true,
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
                        "switch on to use dynamic color",
                        style: t.textTheme.bodyLarge,
                      )
                    ],
                  ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Visibility(
                    visible: !notifier.material3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "choose themes",
                          style: t.textTheme.headline4?.copyWith(
                            fontFamily: 'Theme Black',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: Get.width.w,
                          height: (Get.bottomBarHeight + 200).h,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: themesList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      changeTheme(index, context);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Image.asset(
                                              themesList[index]["url"]
                                                  .toString(),
                                              width: 60.w,
                                              height: 60.h,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: selectedThemeId == index
                                                ? c.primary.withOpacity(0.2)
                                                : c.secondary.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              themesList[index]["name"]
                                                  .toString(),
                                              style:
                                                  t.textTheme.button?.copyWith(
                                                color: selectedThemeId == index
                                                    ? c.primary
                                                    : c.onSecondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
                      primary: c.primary,
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
