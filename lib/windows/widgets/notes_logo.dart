import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesLogoWin extends StatelessWidget {
  const NotesLogoWin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/notes.svg");
  }
}
