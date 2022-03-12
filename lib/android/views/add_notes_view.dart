import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:unicons/unicons.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late Note note;
  late String title, body;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool _autosave = await NotesDatabase().checkAutoSave();
        if (_autosave) {
          if (titleController.text.isNotEmpty ||
              bodyController.text.isNotEmpty) {
            note = Note(
              body: bodyController.text.toString(),
              creationTime: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              title: titleController.text.toString(),
            );
            NotesDatabase().addNote(note, true);
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
          toolbarHeight: 80,
          leading: IconButton(
              onPressed: () async {
                bool _autosave = await NotesDatabase().checkAutoSave();
                if (_autosave) {
                  if (titleController.text.isNotEmpty ||
                      bodyController.text.isNotEmpty) {
                    note = Note(
                      body: bodyController.text.toString(),
                      creationTime:
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      title: titleController.text.toString(),
                    );
                    NotesDatabase().addNote(note, false);
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
              )),
          title: Text(
            "notes",
            style: t.textTheme.headline6,
          ),
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                onPressed: () async {
                  if (titleController.text.isNotEmpty ||
                      bodyController.text.isNotEmpty) {
                    note = Note(
                      body: bodyController.text.toString(),
                      creationTime:
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      title: titleController.text.toString(),
                    );
                    NotesDatabase().addNote(note, false);
                  } else {
                    Get.showSnackbar(GetSnackBar(
                      shouldIconPulse: false,
                      backgroundColor: Get.theme.colorScheme.surface,
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      borderRadius: 10,
                      icon: Icon(
                        UniconsLine.exclamation_octagon,
                        color: c.tertiary,
                      ),
                      duration: const Duration(seconds: 2),
                      messageText: Text(
                        "Empty Note!",
                        style: Get.textTheme.caption
                            ?.copyWith(color: Get.theme.colorScheme.onSurface),
                      ),
                    ));
                  }
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
          ],
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
