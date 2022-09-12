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
  // ignore: library_private_types_in_public_api
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
      return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: c.surface,
        surfaceTintColor: c.surfaceTint,
        elevation: 2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 32,
                  height: 4,
                  color: c.onSurfaceVariant,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Create Folder',
                  style: t.textTheme.headlineSmall,
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
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        label: const Text("Folder Name"),
                        labelStyle: t.textTheme.bodySmall
                            ?.copyWith(color: c.onBackground),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
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
                        label: const Text("Folder Description"),
                        labelStyle: t.textTheme.bodySmall
                            ?.copyWith(color: c.onBackground),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
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
                          backgroundColor: c.primary,
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
        ),
      );
    });
  }
}
