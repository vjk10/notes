import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/folders_model.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';

class AddFolderView extends StatefulWidget {
  const AddFolderView({Key? key}) : super(key: key);

  @override
  _AddFolderViewState createState() => _AddFolderViewState();
}

class _AddFolderViewState extends State<AddFolderView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Note note;
  late String title, description;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Container(
        decoration: BoxDecoration(
          color: c.background,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                Emojis.fileFolder,
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: Get.width - 50,
                  height: 75,
                  child: TextFormField(
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {
                        title = value.toString();
                      });
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "folder name",
                      hintStyle: t.textTheme.button,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      filled: true,
                      fillColor: c.secondaryContainer,
                      contentPadding: const EdgeInsets.all(
                        25.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: Get.width - 50,
                  height: 75,
                  child: TextFormField(
                    controller: descriptionController,
                    onChanged: (value) {
                      setState(() {
                        description = value.toString();
                      });
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "folder description",
                      hintStyle: t.textTheme.button,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        borderSide: BorderSide(
                          color: c.secondaryContainer,
                        ),
                      ),
                      filled: true,
                      fillColor: c.secondaryContainer,
                      contentPadding: const EdgeInsets.all(
                        25.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: Get.width - 50,
                  height: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: c.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        if (titleController.text.isNotEmpty) {
                          var folder = Folder(
                            description: descriptionController.text,
                            creationTime: DateFormat.yMMMMEEEEd()
                                .format(DateTime.now())
                                .toString(),
                            title: titleController.text,
                          );
                          NotesDatabase().createFolder(folder);
                          Get.back();
                        }
                      },
                      child: Text(
                        "Create Folder",
                        style: t.textTheme.button?.copyWith(
                          color: c.onPrimary,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
