import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NotesBottomSheetDouble extends StatefulWidget {
  final Widget childBottom;
  final Widget childTop;
  double? width = Get.width;
  double? heightTop = Get.height / 8;
  double? heightBottom = 200;
  NotesBottomSheetDouble({
    Key? key,
    required this.childBottom,
    required this.childTop,
    this.width,
    this.heightTop,
    this.heightBottom,
  }) : super(key: key);

  @override
  State<NotesBottomSheetDouble> createState() => _NotesBottomSheetDoubleState();
}

class _NotesBottomSheetDoubleState extends State<NotesBottomSheetDouble> {
  TextEditingController saveAsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/bottom_sheet_top.svg",
                width: widget.width,
                height: widget.heightTop,
                fit: BoxFit.contain,
              ),
              widget.childTop,
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                "assets/images/bottom_sheet_bottom.svg",
                width: widget.width,
                height: widget.heightBottom,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                child: widget.childBottom,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
