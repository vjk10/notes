import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:notes/data/data.dart';

part 'boards_local_schema.g.dart';

@collection
class BoardsLocal {
  Id id = Isar.autoIncrement;
  String? boardname;
  String? createdby;
  String? createdon;
  int? boardcolor;
  int? boardtextcolor;
  List<NotesLocal>? notesLocal;
}

@embedded
class NotesLocal {
  String? title;
  String? body;
  String? createdby;
  String? createdon;
  bool? backedup;
  int? boardid;
  String? boardname;
  List<ImagesNoteLocal>? imagesNoteLocal;
}

@embedded
class ImagesNoteLocal {
  int? noteid;
  String? imagepath;
  @ignore
  Image? image;
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
}
