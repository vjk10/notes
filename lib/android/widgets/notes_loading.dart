import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

class NotesLoadingAndroid extends StatefulWidget {
  const NotesLoadingAndroid({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesLoadingAndroid> createState() => _NotesLoadingAndroidState();
}

class _NotesLoadingAndroidState extends State<NotesLoadingAndroid> {
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: c.onBackground.withOpacity(0.2),
      valueColor: AlwaysStoppedAnimation(c.onBackground),
    );
  }
}
