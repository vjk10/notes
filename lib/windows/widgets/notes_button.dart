import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/theme/colors.dart';

class NotesButtonWin extends StatefulWidget {
  final String buttonText;
  final double width;
  final double height;
  final double fontSize;
  const NotesButtonWin({
    Key? key,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.fontSize,
  }) : super(key: key);

  @override
  State<NotesButtonWin> createState() => _NotesButtonWinState();
}

class _NotesButtonWinState extends State<NotesButtonWin> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: SvgPicture.asset(
            "assets/images/button_bg.svg",
            width: widget.width,
            height: widget.height,
          ),
        ),
        Positioned(
          bottom: widget.height / 5,
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: grey,
              fontFamily: 'Theme Font',
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
