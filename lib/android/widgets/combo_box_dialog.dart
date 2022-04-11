import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/number_text_field.dart';

Future<T?> showComboBoxDialog<T>(
  BuildContext context, {
  required String title,
  required int value,
  required ThemeData t,
  required ColorScheme c,
  required int max,
  required int min,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => ComboBoxDialogWidget(
        title: title,
        value: value,
        t: t,
        c: c,
        max: max,
        min: min,
      ),
    );

class ComboBoxDialogWidget extends StatefulWidget {
  final String title;
  final int value;
  final ThemeData t;
  final ColorScheme c;
  final int max;
  final int min;

  const ComboBoxDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.t,
    required this.c,
    required this.max,
    required this.min,
  }) : super(key: key);

  @override
  _ComboBoxDialogWidgetState createState() => _ComboBoxDialogWidgetState();
}

class _ComboBoxDialogWidgetState extends State<ComboBoxDialogWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value.toString());
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
        // content: TextField(
        //   controller: controller,
        //   decoration: const InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(
        //           25,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        content: NumberTextField(
          step: 1,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          controller: _controller,
          borderWidth: 5,
          max: widget.max,
          min: widget.max,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: widget.c.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(-1),
            ),
          ),
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
              onPressed: () => Navigator.of(context).pop(_controller.text),
            ),
          ),
        ],
      );
}
