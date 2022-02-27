import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/folders_model.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:unicons/unicons.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed('/mainScreen');
            },
            icon: Icon(
              UniconsLine.arrow_left,
              color: c.onBackground,
              size: 36,
            )),
        title: const NotesLogo(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              UniconsLine.folder,
              color: c.tertiary,
              size: Get.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: Get.width - 30,
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
                    hintText: "Folder Name",
                    hintStyle: t.textTheme.button,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    filled: true,
                    fillColor: c.surface,
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
                width: Get.width - 30,
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
                    hintText: "Folder Description",
                    hintStyle: t.textTheme.button,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(
                        color: c.surface,
                      ),
                    ),
                    filled: true,
                    fillColor: c.surface,
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
                width: Get.width - 30,
                height: 70,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: c.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        var folder = Folder(
                          description: descriptionController.text,
                          creationTime:
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          title: titleController.text,
                        );
                        NotesDatabase().createFolder(folder);
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
  }
}
