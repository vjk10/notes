import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/theme/colors.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

class NotePage extends StatefulWidget {
  final String noteId;
  const NotePage({
    required this.noteId,
    Key? key,
  }) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  late Note note;
  late DocumentSnapshot noteSnapshot;
  late String title, body;
  bool isLoading = false;

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    noteSnapshot = await ScientISSTdb.instance
        .collection("notes")
        .document(widget.noteId)
        .get();
    setState(() {
      titleController.text = noteSnapshot.data["title"].toString();
      bodyController.text = noteSnapshot.data["body"].toString();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: black.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation(black),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              bool _autosave = await NotesDatabase().checkAutoSave();
              if (_autosave) {
                if (noteSnapshot.data["title"].toString() !=
                        titleController.text ||
                    noteSnapshot.data["body"].toString() !=
                        bodyController.text) {
                  note = Note(
                    body: bodyController.text.toString(),
                    creationTime:
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    title: titleController.text.toString(),
                  );
                  NotesDatabase().updateNote(note, widget.noteId, true);
                } else {
                  Get.offAllNamed('/mainScreen');
                }
              } else {
                Get.offAllNamed('/mainScreen');
              }
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "notes",
                  style: t.textTheme.headline6,
                ),
                toolbarHeight: 80,
                leading: IconButton(
                  onPressed: () async {
                    bool _autosave = await NotesDatabase().checkAutoSave();
                    if (_autosave) {
                      if (noteSnapshot.data["title"].toString() !=
                              titleController.text ||
                          noteSnapshot.data["body"].toString() !=
                              bodyController.text) {
                        note = Note(
                          body: bodyController.text.toString(),
                          creationTime:
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          title: titleController.text.toString(),
                        );
                        NotesDatabase().updateNote(note, widget.noteId, true);
                      } else {
                        Get.offAllNamed('/mainScreen');
                      }
                    } else {
                      Get.offAllNamed('/mainScreen');
                    }
                  },
                  icon: Icon(
                    UniconsLine.arrow_left,
                    color: c.onBackground,
                    size: 36,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () async {
                        note = Note(
                          body: bodyController.text.toString(),
                          creationTime:
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          title: titleController.text.toString(),
                        );
                        NotesDatabase()
                            .updateNote(note, noteSnapshot.id, false);
                      },
                      icon: Icon(
                        UniconsLine.save,
                        color: c.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (kDebugMode) {
                        print("DOC ID: " + noteSnapshot.id.toString());
                      }
                      NotesDatabase().deleteNote(noteSnapshot.id);
                    },
                    icon: Icon(
                      UniconsLine.trash,
                      color: c.error,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size(Get.width, 70),
                  child: TextFormField(
                    controller: titleController,
                    style: t.textTheme.headline4,
                    onChanged: (value) {
                      setState(() {
                        title = value.toString();
                      });
                    },
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15.0,
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Title",
                      hintStyle: t.textTheme.headline4,
                    ),
                  ),
                ),
              ),
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: TextFormField(
                  controller: bodyController,
                  onChanged: (value) {
                    setState(() {
                      body = value.toString();
                    });
                  },
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Type something....",
                    hintStyle: t.textTheme.bodyText1?.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ),
          );
  }
}
