import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';

part 'boards_local_schema.g.dart';

@collection
class BoardsLocal {
  Id id = Isar.autoIncrement;
  String? boardname;
  String? createdby;
  String? createdon;
  NotesLocal? notesLocal;
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
  ImagesNoteLocal? imagesNoteLocal;
}

@embedded
class ImagesNoteLocal {
  int? noteid;
  String? imagepath;
  @ignore
  Image? image;
}
