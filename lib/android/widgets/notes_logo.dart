import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesLogo extends StatelessWidget {
  final double width;
  final double height;
  const NotesLogo({
    this.width = 24,
    this.height = 24,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/notes.svg",
      width: width,
      height: height,
    );
  }
}
