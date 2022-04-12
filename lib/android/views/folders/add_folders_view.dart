import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/folders_model.dart';
import 'package:notes/services/db/notes_model.dart';

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
      backgroundColor: c.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: c.secondaryContainer.withAlpha(50),
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {
              // Get.offAllNamed('/mainScreen', arguments: MainScreenArgument(1));
              Get.offAll(() => const MainScreen(
                    selectedIndex: 1,
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: c.onBackground,
            )),
        title: Text(
          "notes",
          style: t.textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.folder_outlined,
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
