import 'package:flutter/material.dart';

import '../data/data.dart';

class NotesTypeIcon extends StatefulWidget {
  final String type;
  const NotesTypeIcon({Key? key, required this.type}) : super(key: key);

  @override
  State<NotesTypeIcon> createState() => _NotesTypeIconState();
}

class _NotesTypeIconState extends State<NotesTypeIcon> {
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'Note':
        {
          return Icon(
            Icons.description,
            color: c.outline,
            size: 14,
          );
        }
      case 'List':
        {
          return Icon(
            Icons.add_task,
            color: c.outline,
            size: 14,
          );
        }
      case 'Expense':
        {
          return Icon(
            Icons.request_page,
            color: c.outline,
            size: 14,
          );
        }
      default:
        return Icon(
          Icons.description,
          color: c.outline,
          size: 12,
        );
    }
  }
}
