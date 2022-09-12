import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/db/database_notes.dart';
import '../../services/db/database_service.dart';
import '../../services/db/notes_model.dart';
import '../../services/notifier.dart';
import '../../services/utils.dart';
import '../data/data.dart';
import '../views/expenses/expense_tracker_view.dart';
import '../views/folders/pick_folder.dart';
import '../views/list/list_view.dart';
import '../views/notes/note_page.dart';
import 'notes_type_icon.dart';

Widget notesGrid(AsyncSnapshot<List<DocumentSnapshot>> notesData, User user,
    bool accountLinked) {
  return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notesData.data?.length,
      itemBuilder: (context, noteIndex) {
        if (kDebugMode) {
          print("ISLIST${notesData.data![noteIndex].data["isList"]}");
          print("ISEXPENSE${notesData.data![noteIndex].data["isExpense"]}");
          print("PINNED${notesData.data![noteIndex].data["pinned"]}");
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5.0,
          ),
          child: FocusedMenuHolder(
            onPressed: () {},
            menuWidth: Get.width * 0.50,
            blurSize: 5.0,
            menuBoxDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            duration: const Duration(milliseconds: 400),
            animateMenuItems: true,
            blurBackgroundColor: c.background.withOpacity(0.2),
            openWithTap:
                false, // Open Focused-Menu on Tap rather than Long Press
            menuOffset:
                10.0, // Offset value to show menuItem from the selected item
            menuItems: <FocusedMenuItem>[
              // Add Each FocusedMenuItem  for Menu Options
              FocusedMenuItem(
                backgroundColor: c.secondaryContainer,
                title: Text(
                  "Add a Reminder",
                  style: t.textTheme.button?.copyWith(
                    color: c.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
                trailingIcon: Icon(
                  Icons.notification_add_outlined,
                  color: c.onSecondaryContainer,
                ),
                onPressed: () {
                  Utils().reminderDialog(
                    notesData.data![noteIndex].data["title"],
                    notesData.data![noteIndex].data["body"],
                    notesData.data![noteIndex].id,
                    context,
                    t,
                    c,
                  );
                },
              ),
              FocusedMenuItem(
                backgroundColor: c.secondaryContainer,
                title: Text(
                  "Add to Folder",
                  style: t.textTheme.button?.copyWith(
                    color: c.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
                trailingIcon: Icon(
                  Icons.create_new_folder_outlined,
                  color: c.onSecondaryContainer,
                ),
                onPressed: () {
                  Get.to(
                    () => PickFolder(
                      noteId: notesData.data![noteIndex].id,
                      noteTitle: notesData.data![noteIndex].data["title"],
                      noteBody: notesData.data![noteIndex].data["body"],
                    ),
                  );
                },
              ),
              if (accountLinked &&
                  !notesData.data![noteIndex].data["isList"] &&
                  !notesData.data![noteIndex].data["isExpense"])
                FocusedMenuItem(
                  backgroundColor: c.secondaryContainer,
                  title: Text(
                    "Back Up",
                    style: t.textTheme.button?.copyWith(
                      color: c.onSecondaryContainer,
                      fontSize: 12,
                    ),
                  ),
                  trailingIcon: Icon(
                    Icons.cloud_upload_outlined,
                    color: c.onSecondaryContainer,
                  ),
                  onPressed: () {
                    DatabaseService().backUpSingleNote(
                      user.uid,
                      notesData.data![noteIndex].id,
                      notesData.data![noteIndex].data["title"].toString(),
                      notesData.data![noteIndex].data["body"].toString(),
                      notesData.data![noteIndex].data["creationTime"]
                          .toString(),
                      notesData.data![noteIndex].data["pinned"] ?? false,
                      notesData.data![noteIndex].data["isList"] ?? false,
                      notesData.data![noteIndex].data["isExpense"] ?? false,
                      notesData.data![noteIndex].data["totalItem"] ?? 0,
                      notesData.data![noteIndex].data["type"],
                    );
                  },
                ),
              FocusedMenuItem(
                backgroundColor: c.secondaryContainer,
                title: Text(
                  "Delete",
                  style: t.textTheme.button?.copyWith(
                    color: c.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
                trailingIcon: Icon(
                  Icons.delete_outlined,
                  color: c.onSecondaryContainer,
                ),
                onPressed: () {
                  NotesDatabase().deleteNote(notesData.data![noteIndex].id);
                },
              ),
              FocusedMenuItem(
                backgroundColor: c.secondaryContainer,
                title: Text(
                  notesData.data![noteIndex].data["pinned"] ?? false
                      ? "Unpin"
                      : "Pin",
                  style: t.textTheme.button?.copyWith(
                    color: c.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
                trailingIcon: Icon(
                  notesData.data![noteIndex].data["pinned"] ?? false
                      ? Icons.push_pin_rounded
                      : Icons.push_pin_outlined,
                  color: c.onSecondaryContainer,
                ),
                onPressed: () async {
                  await pinNote(notesData, noteIndex);
                },
              ),
            ],
            child: GestureDetector(
              onTap: () {
                if (notesData.data![noteIndex].data["isList"] ??
                    false == true) {
                  Get.to(
                    () => ListviewView(noteId: notesData.data![noteIndex].id),
                  );
                } else if (notesData.data![noteIndex].data["isExpense"] ==
                    true) {
                  Get.to(() => ExpenseTrackerView(
                      noteId: notesData.data![noteIndex].id));
                } else {
                  Get.to(
                    () => NotePage(noteId: notesData.data![noteIndex].id),
                  );
                }
              },
              child: Card(
                color: c.surfaceVariant,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notesData.data![noteIndex].data["title"].toString(),
                            style: t.textTheme.button,
                          ),
                          Visibility(
                            visible: notesData.data![noteIndex].data["pinned"],
                            child: Icon(
                              Icons.push_pin_rounded,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // LIST ITEMS
                      if (notesData.data![noteIndex].data["isList"] == true)
                        for (var i = 0;
                            i <= notesData.data![noteIndex].data["totalItems"];
                            i++)
                          FutureBuilder<DocumentSnapshot>(
                            future: ScientISSTdb.instance
                                .collection("notes")
                                .document(notesData.data![noteIndex].id)
                                .collection(i.toString())
                                .document(i.toString())
                                .get(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        snapshot.data!.data["checked"]
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        color: c.onSecondaryContainer,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: Get.width / 3.5,
                                        child: Text(
                                          snapshot.data!.data["text"]
                                              .toString(),
                                          maxLines: 15,
                                          textWidthBasis:
                                              TextWidthBasis.longestLine,
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: t.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                      // NOTES BODY
                      if (notesData.data![noteIndex].data["isList"] == false)
                        Text(
                          notesData.data![noteIndex].data["body"].toString(),
                          maxLines: 15,
                          softWrap: true,
                          style: t.textTheme.bodyMedium,
                          overflow: TextOverflow.fade,
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<ThemeNotifier>(
                              builder: (context, notifier, child) {
                            return Text(
                              notesData.data![noteIndex].data["creationTime"]
                                  .toString(),
                              style: notifier.material3
                                  ? t.textTheme.labelSmall?.copyWith(
                                      color: c.onSecondaryContainer,
                                    )
                                  : t.textTheme.labelSmall,
                            );
                          }),
                          Consumer<ThemeNotifier>(
                              builder: (context, notifier, child) {
                            return NotesTypeIcon(
                              type: notesData.data![noteIndex].data["type"]
                                  .toString(),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

void shareNote(AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) {
  Share.share(
    "*${notesData.data![noteIndex].data["title"]}*\n\n${notesData.data![noteIndex].data["body"]}",
  );
}

Future<void> pinNote(
    AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) async {
  var note = Note(
      body: notesData.data![noteIndex].data["body"].toString(),
      creationTime: DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      title: notesData.data![noteIndex].data["title"].toString(),
      pinned: !notesData.data![noteIndex].data["pinned"],
      isExpense: notesData.data![noteIndex].data["isExpense"],
      isList: notesData.data![noteIndex].data["isList"],
      totalItems: notesData.data![noteIndex].data["totalItems"],
      type: notesData.data![noteIndex].data["type"].toString());
  await NotesDatabase().updateNote(note, notesData.data![noteIndex].id, true);
}
