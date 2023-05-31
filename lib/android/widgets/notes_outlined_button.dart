import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NotesOutlineButton extends StatefulWidget {
  Function()? onPressed;
  Widget child;
  NotesOutlineButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  State<NotesOutlineButton> createState() => _NotesOutlineButtonState();
}

class _NotesOutlineButtonState extends State<NotesOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 30,
      height: 80,
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}
