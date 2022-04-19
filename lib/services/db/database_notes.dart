import 'package:intl/intl.dart';
import 'package:scientisst_db/scientisst_db.dart';

import 'package:notes/services/imports.dart';

class NotesDatabase {
  //NOTES SECTION

  Future<List<DocumentSnapshot>> getNotes() async {
    var _notes = await ScientISSTdb.instance.collection("notes").getDocuments();
    _notes.removeWhere((element) => element.data["pinned"] == true);
    notesSnapshot = _notes;
    return notesSnapshot;
  }

  Future<List<DocumentSnapshot>> getPinnedNotes() async {
    var _notes = await ScientISSTdb.instance.collection("notes").getDocuments();
    _notes.removeWhere((element) => element.data["pinned"] != true);
    pinnedNotesSnapshot = _notes;
    return pinnedNotesSnapshot;
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
    var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
    if (kDebugMode) {
      print("CREATION TIME: " + creationTime);
    }
    await ScientISSTdb.instance.collection("notes").add({
      "title": note.title,
      "body": note.body,
      "creationTime": creationTime,
      "pinned": note.pinned,
      "isList": note.isList,
      "isExpense": note.isExpense,
      "totalItems": note.totalItems,
      "type": note.type,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      if (!importing) {
        // Get.offAllNamed('/mainScreen');
        Get.back();
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.check_circle_outline,
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

  Future updateNote(Note note, String noteId, bool goBack) async {
    if (kDebugMode) {
      print(note.title);
    }
    var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
    if (kDebugMode) {
      print("CREATION TIME: " + creationTime);
    }

    await ScientISSTdb.instance.collection("notes").document(noteId).update({
      "title": note.title,
      "body": note.body,
      "creationTime": creationTime,
      "pinned": note.pinned,
      "isList": note.isList,
      "isExpense": note.isExpense,
      "totalItems": note.totalItems,
      "type": note.type,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      if (goBack) {
        Get.back();
      }
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.check_circle_outline,
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
      Get.back();
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.delete_outline,
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
            Icons.delete_outline,
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

  Future createFolder(Folder folder) async {
    var creationTime = DateFormat.yMMMMd().format(DateTime.now()).toString();
    if (kDebugMode) {
      print("CREATION TIME: " + creationTime);
    }

    await ScientISSTdb.instance.collection("folders").add({
      "title": folder.title,
      "description": folder.description,
      "creationTime": creationTime,
    }).whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.to(() => const MainScreen(selectedIndex: 1));
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.check_circle_outline,
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
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            shouldIconPulse: false,
            backgroundColor: Get.theme.colorScheme.surface,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            borderRadius: 10,
            icon: Icon(
              Icons.check_circle_outline,
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
      // Get.offAllNamed('/mainScreen');
      Get.back();
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.delete_outline,
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
      if (kDebugMode) {
        print("NOTE SNAPSHOT");
        print(noteSnapshot.data['isExpense']);
      }
      folderNotesSnapshot.add(noteSnapshot);
    }
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
          Icons.delete_outline,
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

  Future saveList(
    TextEditingController titleController,
    List<TextEditingController> controllers,
    bool pinned,
    List<NoteListItem> noteList,
  ) async {
    if (controllers.isNotEmpty) {
      if (titleController.text.isNotEmpty && noteList.isNotEmpty) {
        var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
        if (kDebugMode) {
          print("CREATION TIME: " + creationTime);
        }
        var note = Note(
            title: titleController.text,
            body: noteList.first.text,
            creationTime: creationTime,
            pinned: pinned,
            isList: true,
            isExpense: false,
            totalItems: noteList.length,
            type: "List");
        await ScientISSTdb.instance.collection("notes").add({
          "title": note.title,
          "body": note.body,
          "creationTime": creationTime,
          "pinned": note.pinned,
          "isList": note.isList,
          "isExpense": note.isExpense,
          "totalItems": note.totalItems,
          "type": note.type,
        }).then((value) {
          for (var c = 0; c < noteList.length; c++) {
            if (kDebugMode) {
              print(noteList[c].text.toString());
              print("ID" + value.id.toString());
            }
            ScientISSTdb.instance
                .collection("notes")
                // .document(titleController.text)
                .document(value.id)
                .collection(c.toString())
                .document(c.toString())
                .set({
              "text": noteList[c].text,
              "checked": noteList[c].checked,
              "index": noteList[c].index,
            });
          }
        });
      } else if (noteList.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.warning_rounded,
            color: c.error,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Empty List!",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      } else if (titleController.text.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.warning_rounded,
            color: c.error,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Enter a List Name",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.error_outline_outlined,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Error Occured, Please try again!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    }
  }

  Future updateList(
    TextEditingController titleController,
    List<TextEditingController> controllers,
    bool pinned,
    List<NoteListItem> noteList,
    String noteId,
  ) async {
    if (controllers.isNotEmpty) {
      if (titleController.text.isNotEmpty &&
          controllers.first.text.isNotEmpty) {
        var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
        if (kDebugMode) {
          print("CREATION TIME: " + creationTime);
        }

        if (kDebugMode) {
          print(noteId);
        }
        await ScientISSTdb.instance
            .collection("notes")
            .document(noteId)
            .update({
          "title": titleController.text,
          "body": noteList.first.text,
          "creationTime": creationTime,
          "pinned": pinned,
          "isList": true,
          "isExpense": false,
          "totalItems": noteList.length,
          "type": "List",
        });
        for (var c = 0; c < noteList.length; c++) {
          if (kDebugMode) {
            print(noteList[c].text.toString());
          }
          await ScientISSTdb.instance
              .collection("notes")
              .document(noteId)
              .collection(c.toString())
              .document(c.toString())
              .set({
            "text": noteList[c].text,
            "checked": noteList[c].checked,
            "index": noteList[c].index,
          });
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.warning_rounded,
            color: c.tertiary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Empty List!",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.warning_rounded,
          color: c.tertiary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Empty List!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    }
  }

  Future saveExpenseSheet(
    TextEditingController titleController,
    TextEditingController bodyController,
    bool pinned,
    List<ExpenseModel> expenses,
  ) async {
    if (titleController.text.isNotEmpty) {
      if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
        var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
        if (kDebugMode) {
          print("CREATION TIME: " + creationTime);
        }

        var note = Note(
          title: titleController.text,
          body: bodyController.text,
          creationTime: creationTime,
          pinned: pinned,
          isList: false,
          isExpense: true,
          totalItems: expenses.length,
          type: "Expense",
        );
        await ScientISSTdb.instance.collection("notes").add({
          "title": note.title,
          "body": note.body,
          "creationTime": note.creationTime,
          "pinned": note.pinned,
          "isList": note.isList,
          "isExpense": note.isExpense,
          "totalItems": note.totalItems,
          "type": note.type,
        }).then((value) async {
          for (var c = 0; c < expenses.length; c++) {
            if (kDebugMode) {
              print(expenses[c].type.toString());
            }
            await ScientISSTdb.instance
                .collection("notes")
                .document(value.id)
                .collection(c.toString())
                .document(c.toString())
                .set({
              "index": expenses[c].index,
              "type": expenses[c].type,
              "amount": expenses[c].amount,
              "description": expenses[c].description,
            });
          }
        });
      } else {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.warning_rounded,
            color: c.tertiary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Empty List!",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.warning_rounded,
          color: c.tertiary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Empty List!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    }
  }

  Future updateExpenseSheet(
    TextEditingController titleController,
    TextEditingController bodyController,
    bool pinned,
    List<ExpenseModel> expenses,
    String noteId,
  ) async {
    if (titleController.text.isNotEmpty) {
      if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
        var creationTime = DateFormat.MMMd().format(DateTime.now()).toString();
        if (kDebugMode) {
          print("CREATION TIME: " + creationTime);
        }
        await ScientISSTdb.instance
            .collection("notes")
            .document(noteId)
            .update({
          "title": titleController.text,
          "body": bodyController.text,
          "creationTime": creationTime,
          "pinned": pinned,
          "isList": false,
          "isExpense": true,
          "totalItems": expenses.length,
          "type": "Expense",
        });
        for (var c = 0; c < expenses.length; c++) {
          if (kDebugMode) {
            print(expenses[c].type.toString());
          }
          await ScientISSTdb.instance
              .collection("notes")
              .document(noteId)
              .collection(c.toString())
              .document(c.toString())
              .set({
            "index": expenses[c].index,
            "type": expenses[c].type,
            "amount": expenses[c].amount,
            "description": expenses[c].description,
          });
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: Get.theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.warning_rounded,
            color: c.tertiary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Empty List!",
            style: Get.textTheme.caption
                ?.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.warning_rounded,
          color: c.tertiary,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Empty List!",
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ));
    }
  }
}
