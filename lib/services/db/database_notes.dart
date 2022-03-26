import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/views/folder_view.dart';
import 'package:notes/services/db/folders_model.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../android/data/data.dart';

class NotesDatabase {
  //NOTES SECTION

  Future<List<DocumentSnapshot>> getNotes() async {
    var _notes = await ScientISSTdb.instance.collection("notes").getDocuments();
    notesSnapshot = _notes;
    return notesSnapshot;
  }

  Future<List<DocumentSnapshot>> getFolders() async {
    var _folders =
        await ScientISSTdb.instance.collection("folders").getDocuments();
    foldersSnapshot = _folders;
    return foldersSnapshot;
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

  addNote(Note note, bool importing) async {
    if (kDebugMode) {
      print(note.title);
    }
    await ScientISSTdb.instance.collection("notes").add({
      "title": note.title,
      "body": note.body,
      "creationTime": note.creationTime,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      if (!importing) {
        Get.offAllNamed('/mainScreen');
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.check_circle,
            color: c.primary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Note Added Successfully!",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      }
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
          Icons.check_circle,
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
          Icons.delete,
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
    try {
      await ScientISSTdb.instance.collection("notes").delete().whenComplete(() {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.delete,
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
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //FOLDER SECTION

  createFolder(Folder folder) async {
    await ScientISSTdb.instance.collection("folders").add({
      "title": folder.title,
      "description": folder.description,
      "creationTime": folder.creationTime,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.offAll(() => const MainScreen(selectedIndex: 1));
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.check_circle,
          color: c.primary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Folder Created Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }

  addToFolder(String folderName, String noteId, String noteTitle,
      String noteBody) async {
    await ScientISSTdb.instance.collection(folderName).document(noteId).set(
      {
        "title": noteTitle,
        "body": noteBody,
      },
    ).whenComplete(
      () {
        HapticFeedback.heavyImpact();
        Get.offAllNamed('/mainScreen');
        Get.showSnackbar(
          GetSnackBar(
            shouldIconPulse: false,
            backgroundColor: Get.theme.colorScheme.surface,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            borderRadius: 10,
            icon: Icon(
              Icons.check_circle,
              color: c.primary,
            ),
            duration: const Duration(seconds: 2),
            messageText: Text(
              "Added to Folder Successfully!",
              style: Get.textTheme.caption
                  ?.copyWith(color: Get.theme.colorScheme.onSurface),
            ),
          ),
        );
      },
    );
  }

  deleteFolder(String folderId) async {
    await ScientISSTdb.instance
        .collection("folders")
        .document(folderId)
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
          Icons.delete,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Folder Deleted Successfully!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }

  Future<List<DocumentSnapshot>> getFolderNotes(String folderName) async {
    var _folderNotes =
        await ScientISSTdb.instance.collection(folderName).getDocuments();
    for (var element in _folderNotes) {
      if (kDebugMode) {
        print(element.id);
      }
      var noteSnapshot = await ScientISSTdb.instance
          .collection("notes")
          .document(element.id)
          .get();
      folderNotesSnapshot.add(noteSnapshot);
    }
    // folderNotesSnapshot = _folderNotes;
    return folderNotesSnapshot;
  }

  deleteFromFolder(String folderName, String noteId) async {
    await ScientISSTdb.instance
        .collection(folderName)
        .document(noteId)
        .delete()
        .whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.offAll(() => FolderView(folderName: folderName));
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.delete,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Note Removed from Folder",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    });
  }
}
