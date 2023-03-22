import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotesBottomSheet extends StatefulWidget {
  final Widget child;
  const NotesBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  State<NotesBottomSheet> createState() => _NotesBottomSheetState();
}

class _NotesBottomSheetState extends State<NotesBottomSheet> {
  TextEditingController saveAsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 2,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/bottom_sheet.svg",
            width: Get.width,
          ),
          widget.child,
        ],
      ),
    );
  }
}
