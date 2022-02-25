import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';
import '../../data/data.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  bool _autoSave = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/Document.png",
              scale: 1,
            ),
          ),
          Positioned(
            top: Get.height / 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const NotesLogo(
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: Get.width - 30,
                    child: Text(
                      onBoarding3Message,
                      style: t.textTheme.bodyText1?.copyWith(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FlutterSwitch(
                    activeColor: c.primary,
                    activeIcon: Icon(
                      UniconsLine.save,
                      color: c.background,
                    ),
                    activeTextColor: c.onPrimary,
                    activeToggleColor: c.onPrimary,
                    inactiveColor: c.secondary,
                    inactiveIcon: Icon(
                      UniconsLine.times_circle,
                      color: c.onError,
                    ),
                    inactiveTextColor: c.onSecondary,
                    inactiveToggleColor: c.error,
                    width: 100,
                    height: 50,
                    valueFontSize: 18.0,
                    toggleSize: 35.0,
                    value: _autoSave,
                    borderRadius: 30.0,
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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: c.primary,
                        backgroundColor: c.primary,
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
                        await NotesDatabase().setAutoSave(_autoSave);
                        Get.offNamedUntil('/mainScreen', (route) => false);
                      },
                      child: Text(
                        "Continue",
                        style: t.textTheme.button?.copyWith(
                          fontSize: 18,
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
