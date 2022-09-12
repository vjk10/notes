import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/data.dart';

class SliverAppBarNotes extends StatefulWidget {
  final String title;
  final bool leading;
  final List<Widget>? actions;

  const SliverAppBarNotes({
    Key? key,
    required this.title,
    this.leading = true,
    this.actions,
  }) : super(key: key);

  @override
  State<SliverAppBarNotes> createState() => _SliverAppBarNotesState();
}

class _SliverAppBarNotesState extends State<SliverAppBarNotes> {
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      leading: widget.leading
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: c.onBackground,
              ),
            )
          : const SizedBox(),
      backgroundColor: c.background,
      surfaceTintColor: c.surfaceTint,
      primary: true,
      title: Text(widget.title),
      actions: widget.actions,
    );
  }
}
