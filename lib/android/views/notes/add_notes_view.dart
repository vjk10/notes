import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/expenses/add_expense_tracker.dart';
import 'package:notes/android/views/list/add_list_view.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/services/utils.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  AddNoteViewState createState() => AddNoteViewState();
}

class AddNoteViewState extends State<AddNoteView> {
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
        bool autosave = await NotesDatabase().checkAutoSave();
        if (autosave) {
          if (titleController.text.isNotEmpty ||
              bodyController.text.isNotEmpty) {
            note = Note(
              body: bodyController.text.toString(),
              creationTime:
                  DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
              title: titleController.text.toString(),
              pinned: false,
              isList: false,
              isExpense: false,
              totalItems: 0,
              type: "Note",
            );
            await NotesDatabase().addNote(note, false);
          } else {
            // ignore: use_build_context_synchronously
            Utils().confirmationForSave(context, t, c);
          }
        } else {
          // ignore: use_build_context_synchronously
          Utils().confirmationForSave(context, t, c);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: c.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: c.surface,
          toolbarHeight: 80,
          leading: IconButton(
              onPressed: () async {
                bool autosave = await NotesDatabase().checkAutoSave();
                if (autosave) {
                  if (titleController.text.isNotEmpty ||
                      bodyController.text.isNotEmpty) {
                    note = Note(
                      body: bodyController.text.toString(),
                      creationTime: DateFormat.yMMMMEEEEd()
                          .format(DateTime.now())
                          .toString(),
                      title: titleController.text.toString(),
                      pinned: false,
                      isList: false,
                      isExpense: false,
                      totalItems: 0,
                      type: "Note",
                    );
                    NotesDatabase().addNote(note, false);
                  } else {
                    Get.offAllNamed('/mainScreen');
                    // Get.back();
                  }
                } else {
                  Get.offAllNamed('/mainScreen');
                  // Get.back();
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: c.onBackground,
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
                hintText: "title",
                hintStyle: t.textTheme.headline4,
              ),
            ),
          ),
          actions: [
            Hero(
              tag: 'expenseButtonTag',
              child: IconButton(
                onPressed: () {
                  Get.offAll(() => const AddExpenseTrackerView());
                },
                icon: Icon(
                  Icons.request_quote_outlined,
                  color: c.primary,
                ),
              ),
            ),
            Hero(
              tag: 'listButtonTag',
              child: IconButton(
                onPressed: () {
                  Get.offAll(() => const AddListView());
                },
                icon: Icon(
                  Icons.add_task,
                  color: c.primary,
                ),
              ),
            ),
            Hero(
              tag: 'noteButtonTag',
              child: IconButton(
                onPressed: () async {
                  if (titleController.text.isNotEmpty ||
                      bodyController.text.isNotEmpty) {
                    note = Note(
                      body: bodyController.text.toString(),
                      creationTime: DateFormat.yMMMMEEEEd()
                          .format(DateTime.now())
                          .toString(),
                      title: titleController.text.toString(),
                      pinned: false,
                      isList: false,
                      isExpense: false,
                      totalItems: 0,
                      type: "Note",
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
                        Icons.warning_rounded,
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
                  Icons.save_outlined,
                  color: c.primary,
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
              hintText: "type something....",
              hintStyle: t.textTheme.bodyText1?.copyWith(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
