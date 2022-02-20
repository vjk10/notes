import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesLogo extends StatelessWidget {
  const NotesLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/notes.svg");
  }
}
