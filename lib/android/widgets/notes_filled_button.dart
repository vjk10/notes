import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/data/data.dart';
import 'package:notes/theme/colors.dart';

// ignore: must_be_immutable
class NotesFilledButton extends StatefulWidget {
  Function()? onPressed;
  Widget child;
  NotesFilledButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  State<NotesFilledButton> createState() => _NotesFilledButtonState();
}

class _NotesFilledButtonState extends State<NotesFilledButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 30,
      height: 80,
      child: FilledButton(
        style: StaticData.t.filledButtonTheme.style?.copyWith(
          foregroundColor: MaterialStateProperty.all(lightBlack),
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}
