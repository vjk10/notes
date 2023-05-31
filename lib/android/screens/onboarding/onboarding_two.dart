import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/screens/onboarding/onboarding_three.dart';
import 'package:notes/services/firestore_db/google_sign_in.dart';
import 'package:notes/services/other/auth_services.dart';
import 'package:notes/theme/colors.dart';

import '../../../notes_icon_icons.dart';
import '../../../data/data.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  void didChangeDependencies() {
    StaticData.t = Theme.of(context);
    StaticData.c = StaticData.t.colorScheme;
    super.didChangeDependencies();
  }

  initUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          SvgPicture.asset("assets/images/waves.svg"),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.bottomBarHeight + 80, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        NotesIcon.logo,
                        color: popWhite500,
                        size: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      ' Login to help us keep track of all your data to keep you',
                      style: StaticData.t.textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'NOTES',
                      style: StaticData.t.textTheme.displayLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: StaticData.mainButtonTag,
                      child: SizedBox(
                        width: 189,
                        height: 48,
                        child: NeoPopButton(
                          animationDuration: const Duration(milliseconds: 250),
                          color: googleBlue,
                          onTapDown: () => HapticFeedback.vibrate(),
                          onTapUp: () async {
                            var status = await signInWithGoogle(context);
                            setState(() {
                              AuthServices().authChanges();
                            });
                            if (kDebugMode) {
                              print(status.toString());
                            }
                            if (status == StaticData.successStatus.toString()) {
                              Get.to(() => const Onboarding3(
                                    cameSignedIn: true,
                                  ));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 2,
                              ),
                              Container(
                                  color: popWhite500,
                                  height: 45,
                                  width: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        "assets/images/Google Logo.svg"),
                                  )),
                              const SizedBox(width: 15),
                              Text(
                                "sign in with google",
                                style:
                                    StaticData.t.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 112,
                      height: 48,
                      child: NeoPopButton(
                        buttonPosition: Position.bottomRight,
                        animationDuration: const Duration(milliseconds: 250),
                        color: popBlack300,
                        rightShadowColor: pakGreen600,
                        bottomShadowColor: pakGreen400,
                        border: Border.all(
                          color: pakGreen500,
                          width: 1,
                        ),
                        onTapUp: () => HapticFeedback.vibrate(),
                        onTapDown: () {
                          Get.to(() => const Onboarding3(
                                cameSignedIn: false,
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "go offline",
                              style:
                                  StaticData.t.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: popWhite500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: poliPurple100,
                    size: 14,
                  ),
                  label: Text(
                    'Privacy Policy: Terms & Conditions',
                    style: StaticData.t.textTheme.bodySmall?.copyWith(
                      fontFamily: 'Cirka',
                      fontWeight: FontWeight.bold,
                      color: poliPurple100,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
