import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/theme/app_themes.dart';
import 'package:scientisst_db/scientisst_db.dart';

class OnBoarding4 extends StatefulWidget {
  const OnBoarding4({Key? key}) : super(key: key);

  @override
  State<OnBoarding4> createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
  String selectedTheme = "";
  int selectedThemeId = 0;

  @override
  void initState() {
    themesList = themes.toList();
    getTheme();
    super.initState();
  }

  getTheme() {
    var themeID = DynamicTheme.of(context)!.themeId;
    setState(() {
      selectedThemeId = themeID;
      selectedTheme = AppThemes().getThemeName(themeID);
    });

    if (kDebugMode) {
      print("SELECTED THEME: " + selectedTheme);
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboarding4.png"),
                  fit: BoxFit.cover,
                ),
              )),
          Center(
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
                  width: Get.width - 30,
                  child: Text(
                    onBoarding3Message,
                    textAlign: TextAlign.center,
                    style: t.textTheme.bodyText1?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  height: Get.bottomBarHeight + 250,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: themesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 50.0),
                          child: GestureDetector(
                            onTap: () {
                              changeTheme(index, context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      themesList[index]["url"].toString(),
                                      width: 80,
                                      height: 80,
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      themesList[index]["name"].toString(),
                                      style: t.textTheme.button?.copyWith(
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
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                    onPressed: () async {
                      await ScientISSTdb.instance
                          .collection("userPref")
                          .document("onboarding")
                          .set(
                        {
                          "completed": true,
                        },
                      );
                      // Get.offNamedUntil('/mainScreen', (route) => false);
                      Get.offAllNamed('/mainScreen');
                    },
                    child: Text(
                      "Continue",
                      style: t.textTheme.button?.copyWith(
                        fontSize: 18,
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
