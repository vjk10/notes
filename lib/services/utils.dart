import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  Future<dynamic> confirmationForSave(
      BuildContext context, ThemeData t, ColorScheme c) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: c.secondaryContainer,
        title: Text(
          "Error Saving",
          style: t.textTheme.headline6?.copyWith(
            color: c.onSecondaryContainer,
          ),
        ),
        content: Text(
          "Do you wish to continue without saving the note?",
          style: t.textTheme.button?.copyWith(
            color: c.onSecondaryContainer,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed('/mainScreen');
            },
            child: Text(
              "Exit",
              style: t.textTheme.button?.copyWith(
                color: c.onSurface,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: c.primary,
                primary: c.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Edit",
              style: t.textTheme.button?.copyWith(
                color: c.onPrimary,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
