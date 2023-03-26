import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotesBottomSheetDouble extends StatefulWidget {
  final Widget child;
  const NotesBottomSheetDouble({Key? key, required this.child})
      : super(key: key);

  @override
  State<NotesBottomSheetDouble> createState() => _NotesBottomSheetDoubleState();
}

class _NotesBottomSheetDoubleState extends State<NotesBottomSheetDouble> {
  TextEditingController saveAsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 4.5,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/bottom_sheet_double_decker.svg",
            // width: Get.width,
            fit: BoxFit.fill,
          ),
          widget.child,
        ],
      ),
    );
  }
}
