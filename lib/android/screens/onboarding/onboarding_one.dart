import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:notes/android/screens/onboarding/onboarding_two.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/theme/colors.dart';

import '../../../data/data.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    StaticData.t = Theme.of(context);
    StaticData.c = StaticData.t.colorScheme;
    super.didChangeDependencies();
  }

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
                vertical: Get.bottomBarHeight + 80, horizontal: 30),
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
                      ' Build all kinds of tasks, routines, schedules etc.',
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
                Hero(
                  tag: StaticData.mainButtonTag,
                  child: SizedBox(
                    width: 115,
                    height: 48,
                    child: NeoPopButton(
                      animationDuration: const Duration(milliseconds: 250),
                      color: popWhite500,
                      onTapDown: () => HapticFeedback.vibrate(),
                      onTapUp: () {
                        Get.to(
                          () => const OnBoarding2(),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "let's begin",
                            style: StaticData.t.textTheme.bodyMedium?.copyWith(
                              color: popBlack600,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            NotesIcon.button_arrow_right,
                            color: popBlack500,
                            size: 6,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
