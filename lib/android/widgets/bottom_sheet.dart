import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NotesBottomSheet extends StatefulWidget {
  final Widget child;
  double? width = Get.width;
  double? height = Get.height;
  NotesBottomSheet({Key? key, required this.child, this.width, this.height})
      : super(key: key);

  @override
  State<NotesBottomSheet> createState() => _NotesBottomSheetState();
}

class _NotesBottomSheetState extends State<NotesBottomSheet> {
  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
  }

  TextEditingController saveAsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.bottomCenter,
        children: [
          SvgPicture.asset(
            "assets/images/bottom_sheet.svg",
            width: widget.width,
            height: widget.height,
            fit: BoxFit.contain,
          ),
          widget.child,
        ],
      ),
    );
  }
}
