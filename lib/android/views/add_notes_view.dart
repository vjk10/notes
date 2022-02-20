import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/mainScreen');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: c.background,
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
              )),
          title: const NotesLogo(),
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
                  note = Note(
                    body: bodyController.text.toString(),
                    creationTime: DateTime.now(),
                    title: titleController.text.toString(),
                  );
                  NotesDatabase().addNote(note);
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
