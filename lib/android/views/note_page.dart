import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/theme/colors.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

class NotePage extends StatefulWidget {
  // final int noteId;
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

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    // note = await NotesDatabase.instance.readNote(widget.noteId) as Note;
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
              Get.offAllNamed('/mainScreen');
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: const NotesLogo(),
                toolbarHeight: 80,
                leading: IconButton(
                  onPressed: () {
                    Get.offAllNamed('/mainScreen');
                    Get.back();
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
                    child: TextButton.icon(
                      onPressed: () async {
                        note = Note(
                          body: bodyController.text.toString(),
                          creationTime: DateTime.now(),
                          title: titleController.text.toString(),
                        );
                        NotesDatabase().updateNote(note, noteSnapshot.id);
                      },
                      icon: Icon(
                        UniconsLine.save,
                        color: c.onBackground,
                        size: 24,
                      ),
                      label: Text(
                        "Save",
                        style: t.textTheme.button?.copyWith(fontSize: 18),
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
                      color: c.onBackground,
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
