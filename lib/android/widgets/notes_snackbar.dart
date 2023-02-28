import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/data/data.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/theme/colors.dart';

class NotesSnackBar {
  successSnackBar(String messageText) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: success,
        messageText: Text(
          messageText,
          style:
              StaticData.t.textTheme.bodyMedium?.copyWith(color: popWhite500),
        ),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: popWhite500,
        ),
        duration: const Duration(seconds: 1),
        shouldIconPulse: false,
      ),
    );
  }

  errorSnackBar(String messageText) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: error,
        messageText: Text(
          messageText,
          style:
              StaticData.t.textTheme.bodyMedium?.copyWith(color: popWhite500),
        ),
        icon: Icon(
          Icons.error_outline,
          color: popWhite500,
        ),
        duration: const Duration(seconds: 1),
        shouldIconPulse: false,
      ),
    );
  }

  warningSnackBar(String messageText) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: error,
        messageText: Text(
          messageText,
          style:
              StaticData.t.textTheme.bodyMedium?.copyWith(color: popWhite500),
        ),
        icon: Icon(
          Icons.warning_amber_outlined,
          color: popWhite500,
        ),
        duration: const Duration(seconds: 1),
        shouldIconPulse: false,
      ),
    );
  }

  infoSnackBar(String messageText) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: info,
        messageText: Text(
          messageText,
          style:
              StaticData.t.textTheme.bodyMedium?.copyWith(color: popWhite500),
        ),
        icon: Icon(
          NotesIcon.info,
          color: popWhite500,
        ),
        duration: const Duration(seconds: 1),
        shouldIconPulse: false,
      ),
    );
  }

  regularSnackBar(String messageText) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: popWhite500,
        messageText: Text(
          messageText,
          style:
              StaticData.t.textTheme.bodyMedium?.copyWith(color: popWhite500),
        ),
        icon: Icon(
          NotesIcon.info,
          color: popBlack600,
        ),
        duration: const Duration(seconds: 1),
        shouldIconPulse: false,
      ),
    );
  }
}
