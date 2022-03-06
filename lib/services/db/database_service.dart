import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:unicons/unicons.dart';

class DatabaseService {
  backUpSingleNote(String uid, String noteId, String title, String body,
      String creationDate) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteId)
        .set(
      {
        "title": title,
        "body": body,
        "creationDate": creationDate,
      },
    ).whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.showSnackbar(
        GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            UniconsLine.cloud_check,
            color: c.primary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            title + " backed up",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
        ),
      );
    });
  }

  importNotes(String uid) async {
    var importSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .get();

    if (importSnapshot.docs.isNotEmpty) {
      for (var element in importSnapshot.docs) {
        if (kDebugMode) {
          print("Note Title: " + element.get("title"));
        }
      }
    }
  }
}
