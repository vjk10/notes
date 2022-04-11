import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: Get.height / 8,
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
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FlutterSwitch(
                  activeColor: c.primary,
                  activeIcon: Icon(
                    Icons.save_outlined,
                    color: c.primary,
                  ),
                  activeTextColor: c.onPrimary,
                  activeToggleColor: c.onPrimary,
                  inactiveColor: c.secondary,
                  inactiveIcon: Icon(
                    Icons.highlight_off_rounded,
                    color: c.onError,
                  ),
                  inactiveTextColor: c.onSecondary,
                  inactiveToggleColor: c.error,
                  width: 150,
                  height: 70,
                  valueFontSize: 18.0,
                  toggleSize: 35.0,
                  value: _autoSave,
                  borderRadius: 50.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      _autoSave = val;
                    });
                  },
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
                      await NotesDatabase().setAutoSave(_autoSave);
                      Get.offNamedUntil('/onboarding4', (route) => false);
                    },
                    child: Text(
                      "Next",
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
