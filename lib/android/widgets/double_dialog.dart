import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

Future<T?> showDoubleDialog<T>(
  BuildContext context, {
  required String title,
  required String value,
  required ThemeData t,
  required ColorScheme c,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => DoubleDialogWidget(
        title: title,
        value: value,
        c: c,
        t: t,
      ),
    );

class DoubleDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  final ThemeData t;
  final ColorScheme c;

  const DoubleDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.t,
    required this.c,
  }) : super(key: key);

  @override
  _DoubleDialogWidgetState createState() => _DoubleDialogWidgetState();
}

class _DoubleDialogWidgetState extends State<DoubleDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.all(15),
        backgroundColor: widget.c.background,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.title,
            style: t.textTheme.headline6?.copyWith(
              color: c.onBackground,
            ),
          ),
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  25,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: widget.c.primary,
                onPrimary: widget.c.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(controller.text),
            ),
          )
        ],
      );
}
