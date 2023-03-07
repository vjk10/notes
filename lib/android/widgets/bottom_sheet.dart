import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:notes/theme/colors.dart';

class NotesBottomSheet extends StatelessWidget {
  const NotesBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: popWhite500),
        width: Get.width - 30,
        height: 391,
        child: Stack(children: <Widget>[
          Positioned(
              top: -3,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Transform.rotate(
                      angle: 90.00000250447827 * (math.pi / 180),
                      child: SvgPicture.asset('assets/images/leftcut.svg',
                          semanticsLabel: 'leftcut'),
                    ),
                    const SizedBox(width: 0),
                    Container(
                        width: 363,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 224, 224, 1),
                        )),
                    const SizedBox(width: 0),
                    Transform.rotate(
                      angle: -180 * (math.pi / 180),
                      child: SvgPicture.asset('assets/images/rightcut.svg',
                          semanticsLabel: 'rightcut'),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: -20.783203125,
              left: 155.5,
              child: Container(
                  width: 60,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ))),
        ]));
  }
}
