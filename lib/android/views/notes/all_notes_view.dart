import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/notes/add_notes_view.dart';
import 'package:notes/android/views/expenses/add_expense_tracker.dart';
import 'package:notes/android/views/expenses/expense_tracker_view.dart';
import 'package:notes/android/views/list/add_list_view.dart';
import 'package:notes/android/views/list/list_view.dart';
import 'package:notes/android/views/notes/note_page.dart';
import 'package:notes/android/views/folders/pick_folder.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/database_service.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;

import '../../../services/db/notes_model.dart';

class AllNotesView extends StatefulWidget {
  final Future<List<DocumentSnapshot>> notesFuture;
  final Future<List<DocumentSnapshot>> pinnedNotesFuture;
  final Future<List<DocumentSnapshot>> foldersFuture;
  const AllNotesView({
    Key? key,
    required this.notesFuture,
    required this.pinnedNotesFuture,
    required this.foldersFuture,
  }) : super(key: key);

  @override
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  bool isLoading = false;
  bool _accountLinked = false;
  bool userSignedIn = false;

  late fire_store.DocumentSnapshot firebaseUserDetails;
  late User user;

  @override
  void initState() {
    initUser();

    super.initState();
    if (kDebugMode) {
      print("ALL NOTES INIT STATE");
    }
  }

  initUser() async {
    try {
      user = FirebaseAuth.instance.currentUser!;
      if (user.uid.isNotEmpty) {
        userSignedIn = true;
        firebaseUserDetails = await fire_store.FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (firebaseUserDetails.exists) {
          setState(() {
            _accountLinked = true;
          });
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (kDebugMode) {
          print(e.message);
        }
      }
    }
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
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        backgroundColor: c.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton.large(
          heroTag: "addNoteTag",
          onPressed: () {
            Get.to(() => const AddNoteView());
          },
          backgroundColor: c.primaryContainer,
          child: Center(
            child: Icon(
              Icons.note_add_outlined,
              color: c.onPrimaryContainer,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              // PINNED NOTES
              StreamBuilder<List<DocumentSnapshot>>(
                stream:
                    ScientISSTdb.instance.collection("notes").watchDocuments(),
                builder: ((context,
                    AsyncSnapshot<List<DocumentSnapshot>> pinnedSnapshot) {
                  pinnedSnapshot.data?.removeWhere(
                      (element) => element.data["pinned"] == false);
                  switch (pinnedSnapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return const Center(
                          child: NotesLoadingAndroid(),
                        );
                      }
                    case ConnectionState.done:
                      {
                        switch (pinnedSnapshot.data!.length) {
                          case 0:
                            {
                              return const SizedBox();
                            }
                          default:
                            {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Pinned",
                                      style: t.textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  notesGrid(pinnedSnapshot),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Others",
                                      style: t.textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              );
                            }
                        }
                      }
                    default:
                      {
                        switch (pinnedSnapshot.data!.length) {
                          case 0:
                            {
                              return const SizedBox();
                            }
                          default:
                            {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Pinned",
                                      style: t.textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  notesGrid(pinnedSnapshot),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      "Others",
                                      style: t.textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              );
                            }
                        }
                      }
                  }
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              // OTHER NOTES
              StreamBuilder<List<DocumentSnapshot>>(
                stream:
                    ScientISSTdb.instance.collection("notes").watchDocuments(),
                builder: ((context,
                    AsyncSnapshot<List<DocumentSnapshot>> otherSnapshot) {
                  otherSnapshot.data?.removeWhere(
                      (element) => element.data["pinned"] == true);
                  switch (otherSnapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return const Center(
                          child: NotesLoadingAndroid(),
                        );
                      }
                    case ConnectionState.done:
                      {
                        switch (otherSnapshot.data!.length) {
                          case 0:
                            {
                              return const SizedBox();
                            }
                          default:
                            {
                              return notesGrid(otherSnapshot);
                            }
                        }
                      }
                    default:
                      {
                        switch (otherSnapshot.data!.length) {
                          case 0:
                            {
                              return const SizedBox();
                            }
                          default:
                            {
                              return notesGrid(otherSnapshot);
                            }
                        }
                      }
                  }
                }),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: true,
          child: SizedBox(
            height: 65,
            child: BottomAppBar(
              elevation: 0,
              color: notifier.material3
                  ? c.secondaryContainer.withAlpha(50)
                  : c.secondaryContainer,
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.none,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AddListView());
                    },
                    child: Icon(
                      Icons.add_task,
                      color: c.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  // Icon(
                  //   Icons.notification_add,
                  //   color: c.onSecondaryContainer,
                  // ),
                  // const SizedBox(
                  //   width: 40,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AddExpenseTrackerView());
                    },
                    child: Icon(
                      Icons.request_page,
                      color: c.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Visibility(
                    visible: userSignedIn,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/clipboard');
                      },
                      child: Icon(
                        Icons.content_paste_rounded,
                        color: c.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget notesGrid(AsyncSnapshot<List<DocumentSnapshot>> notesData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notesData.data?.length,
          itemBuilder: (context, noteIndex) {
            if (kDebugMode) {
              print("ISLIST" +
                  notesData.data![noteIndex].data["isList"].toString());
              print("ISEXPENSE" +
                  notesData.data![noteIndex].data["isExpense"].toString());
              print("PINNED" +
                  notesData.data![noteIndex].data["pinned"].toString());
            }
            // if (notesData.data![noteIndex].data["isList"] == true) {
            // LIST LAYOUT
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: c.secondaryContainer,
                  borderRadius: BorderRadius.circular(15),
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
                    if (_accountLinked &&
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
                            notesData.data![noteIndex].data["isExpense"] ??
                                false,
                            notesData.data![noteIndex].data["totalItem"] ?? 0,
                            notesData.data![noteIndex].data["type"],
                          );
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
                            foldersFuture: widget.foldersFuture,
                          ),
                        );
                      },
                    ),
                    FocusedMenuItem(
                      backgroundColor: c.secondaryContainer,
                      title: Text(
                        "Share",
                        style: t.textTheme.button?.copyWith(
                          color: c.onSecondaryContainer,
                          fontSize: 12,
                        ),
                      ),
                      trailingIcon: Icon(
                        Icons.share_outlined,
                        color: c.onSecondaryContainer,
                      ),
                      onPressed: () {
                        shareNote(notesData, noteIndex);
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
                        NotesDatabase()
                            .deleteNote(notesData.data![noteIndex].id);
                      },
                    ),
                  ],
                  child: GestureDetector(
                    onTap: () {
                      if (notesData.data![noteIndex].data["isList"] ??
                          false == true) {
                        Get.to(
                          () => ListviewView(
                              noteId: notesData.data![noteIndex].id),
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
                    child: Container(
                      decoration: BoxDecoration(
                        // color: c.secondaryContainer,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              notesData.data![noteIndex].data["title"]
                                  .toString(),
                              style: t.textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // LIST ITEMS
                            if (notesData.data![noteIndex].data["isList"] ==
                                true)
                              for (var i = 0;
                                  i <=
                                      notesData
                                          .data![noteIndex].data["totalItems"];
                                  i++)
                                FutureBuilder<DocumentSnapshot>(
                                  future: ScientISSTdb.instance
                                      .collection("notes")
                                      .document(notesData.data![noteIndex].id)
                                      .collection(i.toString())
                                      .document(i.toString())
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
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
                                            Text(
                                              snapshot.data!.data["text"]
                                                  .toString(),
                                              maxLines: 15,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: t.textTheme.bodyText1,
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
                            if (notesData.data![noteIndex].data["isList"] ==
                                false)
                              Text(
                                notesData.data![noteIndex].data["body"]
                                    .toString(),
                                maxLines: 15,
                                softWrap: true,
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
                                    notesData
                                        .data![noteIndex].data["creationTime"]
                                        .toString(),
                                    style: notifier.material3
                                        ? t.textTheme.caption?.copyWith(
                                            color: c.onSecondaryContainer,
                                          )
                                        : t.textTheme.caption,
                                  );
                                }),
                                Consumer<ThemeNotifier>(
                                    builder: (context, notifier, child) {
                                  return Text(
                                    notesData.data![noteIndex].data["type"]
                                        .toString(),
                                    style: notifier.material3
                                        ? t.textTheme.caption?.copyWith(
                                            color: c.onSecondaryContainer,
                                          )
                                        : t.textTheme.caption,
                                  );
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void shareNote(
      AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) {
    Share.share(
      "*" +
          notesData.data![noteIndex].data["title"].toString() +
          "*" +
          "\n\n" +
          notesData.data![noteIndex].data["body"].toString(),
    );
  }

  Future<void> pinNote(
      AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) async {
    var _note = Note(
        body: notesData.data![noteIndex].data["body"].toString(),
        creationTime: DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        title: notesData.data![noteIndex].data["title"].toString(),
        pinned: !notesData.data![noteIndex].data["pinned"],
        isExpense: notesData.data![noteIndex].data["isExpense"],
        isList: notesData.data![noteIndex].data["isList"],
        totalItems: notesData.data![noteIndex].data["totalItems"],
        type: notesData.data![noteIndex].data["type"].toString());
    await NotesDatabase()
        .updateNote(_note, notesData.data![noteIndex].id, true);
  }
}
