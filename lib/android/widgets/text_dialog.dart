import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

Future<T?> showTextDialog<T>(
  BuildContext context, {
  required String title,
  required String value,
  required ThemeData t,
  required ColorScheme c,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
        t: t,
        c: c,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  final ThemeData t;
  final ColorScheme c;

  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.t,
    required this.c,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
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
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
            errorBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
            focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
            enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
            disabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
            focusedErrorBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
              color: c.onBackground,
              width: 1,
            )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: widget.c.onPrimary,
                backgroundColor: widget.c.primary,

              ),
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(controller.text),
            ),
          )
        ],
      );
}
