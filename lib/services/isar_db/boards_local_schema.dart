import 'package:isar/isar.dart';
import 'package:notes/data/data.dart';

import '../../android/widgets/notes_snackbar.dart';

part 'boards_local_schema.g.dart';

@collection
class BoardsLocal {
  Id id = Isar.autoIncrement;
  String? boardname;
  String? createdby;
  String? createdon;
  int? boardcolor;
  int? boardtextcolor;
  // List<NotesLocal>? notesLocal;
}

@collection
class NotesLocal {
  Id id = Isar.autoIncrement;
  String? title;
  String? body;
  String? bodyPlainText;
  String? createdby;
  String? createdon;
  bool? backedup;
  int? boardid;
  String? boardname;
}

class BoardsLocalServices {
  Future<String> addBoard(String boardname, String createdby, String createdon,
      int boardcolor, int boardtextcolor) async {
    String returnStatus = StaticData.errorStatus;
    await StaticData.isarDb.writeTxn(() async {
      BoardsLocal board = BoardsLocal();
      board.boardname = boardname;
      board.createdby = createdby;
      board.createdon = createdon;
      board.boardcolor = boardcolor;
      board.boardtextcolor = boardtextcolor;
      await StaticData.isarDb.boardsLocals.put(board).whenComplete(() {
        returnStatus = StaticData.successStatus;
      });
    });
    return returnStatus;
  }

  Future<String> deleteBoard(int id) async {
    String returnStatus = StaticData.errorStatus;
    await StaticData.isarDb.writeTxn(() async {
      await StaticData.isarDb.boardsLocals.delete(id).whenComplete(() {
        returnStatus = StaticData.successStatus;
      });
    });
    return returnStatus;
  }

  Future<String> addNote(int id, NotesLocal note) async {
    String returnStatus = StaticData.errorStatus;
    await StaticData.isarDb.writeTxn(() async {
      await StaticData.isarDb.notesLocals.put(note).then((value) {
        NotesSnackBar()
            .successSnackBar("note ${note.title} added to ${note.boardname}");
        returnStatus = StaticData.successStatus;
      }).onError((error, stackTrace) {
        NotesSnackBar().errorSnackBar(error.toString());
        returnStatus = StaticData.errorStatus;
      });
    }).onError(
      (error, stackTrace) {
        NotesSnackBar().errorSnackBar(
          error.toString(),
        );
        returnStatus = StaticData.errorStatus;
      },
    );
    return returnStatus;
  }

  Future<String> deleteNote(int id, NotesLocal note) async {
    String returnStatus = StaticData.errorStatus;
    // await StaticData.isarDb.boardsLocals.get(id).then((value) async {
    //   final BoardsLocal? board = value;
    //   List<NotesLocal> notes = List.empty(growable: true);
    //   notes = board!.notesLocal!.toList();
    //   notes.remove(note);
    //   board.notesLocal = notes;
    //   if (board.notesLocal!.isNotEmpty) {
    //     await StaticData.isarDb.writeTxn(() async {
    //       await StaticData.isarDb.boardsLocals.put(board).then((value) {
    //         NotesSnackBar().successSnackBar(
    //           "note ${note.title} deleted from ${board.boardname}",
    //         );
    //         returnStatus = StaticData.successStatus;
    //       }).onError((error, stackTrace) {
    //         NotesSnackBar().errorSnackBar(error.toString());
    //         returnStatus = StaticData.errorStatus;
    //       });
    //     });
    //   }
    // }).onError(
    //   (error, stackTrace) {
    //     NotesSnackBar().errorSnackBar(
    //       error.toString(),
    //     );
    //     returnStatus = StaticData.errorStatus;
    //   },
    // );
    return returnStatus;
  }
}
