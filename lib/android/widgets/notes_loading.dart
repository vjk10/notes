import 'package:flutter/material.dart';
import 'package:notes/data/data.dart';

class NotesLoadingAndroid extends StatefulWidget {
  final double strokeWidth;
  const NotesLoadingAndroid({
    Key? key,
    required this.strokeWidth,
  }) : super(key: key);

  @override
  State<NotesLoadingAndroid> createState() => _NotesLoadingAndroidState();
}

class _NotesLoadingAndroidState extends State<NotesLoadingAndroid> {
  @override
  void didChangeDependencies() {
    StaticData.t = Theme.of(context);
    StaticData.c = StaticData.t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      strokeWidth: widget.strokeWidth,
      backgroundColor: StaticData.c.onBackground.withOpacity(0.2),
      valueColor: AlwaysStoppedAnimation(StaticData.c.onBackground),
    );
  }
}
