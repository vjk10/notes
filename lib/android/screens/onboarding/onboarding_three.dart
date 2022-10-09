import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:notes/services/db/database_notes.dart';
import '../../data/data.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  bool _autoSave = true;

  @override
  void initState() {
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
      backgroundColor: c.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/onboarding3.png",
              width: Get.width.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: Get.height / 8.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "auto save notes",
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
                    style: t.textTheme.bodyText1?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FlutterSwitch(
                  activeColor: c.primary,
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.save_outlined,
                      color: c.onPrimaryContainer,
                    ),
                  ),
                  activeTextColor: c.onPrimary,
                  activeToggleColor: c.onPrimary,
                  inactiveColor: c.secondary,
                  inactiveIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.highlight_off_rounded,
                      color: c.surfaceVariant,
                    ),
                  ),
                  inactiveTextColor: c.surfaceVariant,
                  inactiveToggleColor: c.outline,
                  width: 150.w,
                  height: 70.h,
                  valueFontSize: 18.0,
                  toggleSize: 48.0,
                  value: _autoSave,
                  borderRadius: 50.0,
                  padding: 8.0,
                  // showOnOff: true,
                  onToggle: (val) {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      _autoSave = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: 150.w,
                  height: 70.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.primary,
                      elevation: 20,
                      shadowColor: c.background,
                    ),
                    onPressed: () async {
                      await NotesDatabase().setAutoSave(_autoSave);
                      Get.offNamedUntil('/onboarding4', (route) => false);
                    },
                    child: Text(
                      "Next",
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
