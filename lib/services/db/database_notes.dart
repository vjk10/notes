import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

import '../../android/data/data.dart';

class NotesDatabase {
  Future<List<DocumentSnapshot>> getNotes() async {
    var _notes = await ScientISSTdb.instance.collection("notes").getDocuments();
    notesSnapshot = _notes;
    return notesSnapshot;
  }

  setAutoSave(bool autoSave) async {
    await ScientISSTdb.instance.collection("userPref").document("save").set(
      {
        "autoSave": autoSave,
      },
    );
  }

  checkAutoSave() async {
    if (kDebugMode) {
      print("AUTOSAVE CHECK");
    }
    var userPref = await ScientISSTdb.instance
        .collection("userPref")
        .document("save")
        .get();

    bool _returnSave = userPref.data["autoSave"];
    if (kDebugMode) {
      print("AUTOSAVE: " + _returnSave.toString());
    }

    return _returnSave;
  }

  addNote(Note note) async {
    if (kDebugMode) {
      print(note.title);
    }
    await ScientISSTdb.instance.collection("notes").add({
      "title": note.title,
      "body": note.body,
      "creationTime": note.creationTime,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.offAllNamed('/mainScreen');
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          UniconsLine.check_circle,
          color: c.primary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Note Added Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }

  updateNote(Note note, String noteId, bool goBack) async {
    if (kDebugMode) {
      print(note.title);
    }
    await ScientISSTdb.instance.collection("notes").document(noteId).update({
      "title": note.title,
      "body": note.body,
      "creationTime": note.creationTime,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      if (goBack) {
        Get.offAllNamed('/mainScreen');
      }
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          UniconsLine.check_circle,
          color: c.primary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Note Updated Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }

  deleteNote(String noteId) async {
    await ScientISSTdb.instance
        .collection("notes")
        .document(noteId)
        .delete()
        .whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.offAllNamed('/mainScreen');
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          UniconsLine.trash,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Note Deleted Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }

  clearAllNotes() async {
    await ScientISSTdb.instance.collection("notes").delete().whenComplete(() {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          UniconsLine.trash,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Notes Deleted Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }
}
