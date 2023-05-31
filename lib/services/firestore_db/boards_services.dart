import 'dart:io';

import 'package:notes/android/widgets/notes_snackbar.dart';
import 'package:notes/services/firestore_db/user_model.dart';

import '../other/local_model.dart';

class BoardsOnlineService {
  Future<ReturnValue> addBoard(String uid, BoardsModel boardsModel) async {
    ReturnValue returnValue =
        ReturnValue(HttpStatus.expectationFailed, "Not Processed");
    await UserModelCollectionReference()
        .doc(uid)
        .boards
        .add(boardsModel)
        .then((value) {
      returnValue = ReturnValue(HttpStatus.accepted, value.id);
    });
    return returnValue;
  }

  Future<ReturnValue> deleteBoard(String uid, String boardIdFb) async {
    ReturnValue returnValue =
        ReturnValue(HttpStatus.expectationFailed, "Not Processed");
    await UserModelCollectionReference()
        .doc(uid)
        .boards
        .doc(boardIdFb)
        .delete()
        .whenComplete(() {
      returnValue = ReturnValue(HttpStatus.accepted, "Success");
    });
    return returnValue;
  }

  Future<ReturnValue> addNoteToBoard(
      String uid, String boardIdFb, NotesModel notesModel) async {
    ReturnValue returnValue =
        ReturnValue(HttpStatus.expectationFailed, "Not Processed");
    await UserModelCollectionReference()
        .doc(uid)
        .boards
        .doc(boardIdFb)
        .notes
        .add(notesModel)
        .then((value) {
      NotesSnackBar().successSnackBar("Note was added successfully!");
      returnValue = ReturnValue(HttpStatus.accepted, value.id);
    });
    return returnValue;
  }
}
