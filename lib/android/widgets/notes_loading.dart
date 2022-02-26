import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

class NotesLoadingAndroid extends StatelessWidget {
  const NotesLoadingAndroid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: c.onBackground.withOpacity(0.2),
      valueColor: AlwaysStoppedAnimation(c.onBackground),
    );
  }
}
