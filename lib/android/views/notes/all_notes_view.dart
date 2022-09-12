import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/screens/settings_screen.dart';
import 'package:notes/android/views/notes/add_notes_view.dart';
import 'package:notes/android/views/expenses/add_expense_tracker.dart';
import 'package:notes/android/views/list/add_list_view.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;

import '../../widgets/notes_grid.dart';

class AllNotesView extends StatefulWidget {
  const AllNotesView({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool userSignedIn = false;

  late fire_store.DocumentSnapshot firebaseUserDetails;
  late User user;

  final QuickActions quickActions = const QuickActions();
  String shortcut = 'no action set';

  late ScrollController _hideButtonController;
  bool _isVisible = true;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    initUser();
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
      if (shortcutType == 'action_one') {
        Get.to(
          () => const AddNoteView(),
        );
      }
      if (shortcutType == 'action_two') {
        Get.to(
          () => const AddListView(),
        );
      }
      if (shortcutType == 'action_three') {
        Get.to(
          () => const AddExpenseTrackerView(),
        );
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Add Note',
        icon: 'ic_add_note',
      ),
      const ShortcutItem(
        type: 'action_two',
        localizedTitle: 'Add List',
        icon: 'ic_add_list',
      ),
      const ShortcutItem(
        type: 'action_three',
        localizedTitle: 'Add Expense',
        icon: 'ic_add_expense',
      ),
    ]).then((value) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
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
        if (firebaseUserDetails.exists) {}
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
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: c.background,
          appBar: AppBar(
            backgroundColor: c.background,
            toolbarHeight: 80,
            title: const Text('notes'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const SettingsScreen());
                },
                icon: Icon(
                  Icons.settings_outlined,
                  color: c.onSurface,
                ),
              )
            ],
          ),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: Visibility(
            visible: _isVisible,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ExpandableFab(
                onOpen: () {
                  HapticFeedback.heavyImpact();
                },
                onClose: () {
                  HapticFeedback.heavyImpact();
                },
                type: ExpandableFabType.up,
                distance: 65,
                closeButtonStyle: ExpandableFabCloseButtonStyle(
                    backgroundColor: c.tertiaryContainer,
                    child: Icon(
                      Icons.close_outlined,
                      color: c.onTertiaryContainer,
                    )),
                key: _key,
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.note_add_outlined),
                    onPressed: () {
                      Get.to(() => const AddNoteView());
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.add_task_outlined),
                    onPressed: () {
                      Get.to(() => const AddListView());
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.request_page_outlined),
                    onPressed: () {
                      Get.to(() => const AddExpenseTrackerView());
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: _hideButtonController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // PINNED NOTES
                StreamBuilder<List<DocumentSnapshot>>(
                  stream: ScientISSTdb.instance
                      .collection("notes")
                      .watchDocuments(),
                  builder: ((context,
                      AsyncSnapshot<List<DocumentSnapshot>> pinnedSnapshot) {
                    pinnedSnapshot.data?.removeWhere(
                        (element) => element.data["pinned"] == false);
                    if (pinnedSnapshot.hasData &&
                        pinnedSnapshot.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Pinned",
                              style: t.textTheme.bodyLarge,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Fix for #39
                          NoteGrid(notesData: pinnedSnapshot),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Others",
                              style: t.textTheme.bodyLarge,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ),

                // OTHER NOTES
                StreamBuilder<List<DocumentSnapshot>>(
                  stream: ScientISSTdb.instance
                      .collection("notes")
                      .watchDocuments(),
                  builder: ((context,
                      AsyncSnapshot<List<DocumentSnapshot>> otherSnapshot) {
                    otherSnapshot.data?.removeWhere(
                        (element) => element.data["pinned"] == true);
                    if (otherSnapshot.hasData) {
                      // Fix for #39
                      return NoteGrid(notesData: otherSnapshot);
                    } else {
                      return const SizedBox();
                    }
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget notesGrid(AsyncSnapshot<List<DocumentSnapshot>> notesData) {
  //   return MasonryGridView.count(
  //       shrinkWrap: true,
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 2,
  //       crossAxisSpacing: 2,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: notesData.data?.length,
  //       itemBuilder: (context, noteIndex) {
  //         if (kDebugMode) {
  //           print("ISLIST${notesData.data![noteIndex].data["isList"]}");
  //           print("ISEXPENSE${notesData.data![noteIndex].data["isExpense"]}");
  //           print("PINNED${notesData.data![noteIndex].data["pinned"]}");
  //         }
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 5.0,
  //             vertical: 5.0,
  //           ),
  //           child: FocusedMenuHolder(
  //             onPressed: () {},
  //             menuWidth: Get.width * 0.50,
  //             blurSize: 5.0,
  //             menuBoxDecoration: const BoxDecoration(
  //               color: Colors.transparent,
  //             ),
  //             duration: const Duration(milliseconds: 400),
  //             animateMenuItems: true,
  //             blurBackgroundColor: c.background.withOpacity(0.2),
  //             openWithTap:
  //                 false, // Open Focused-Menu on Tap rather than Long Press
  //             menuOffset:
  //                 10.0, // Offset value to show menuItem from the selected item
  //             menuItems: <FocusedMenuItem>[
  //               // Add Each FocusedMenuItem  for Menu Options
  //               FocusedMenuItem(
  //                 backgroundColor: c.secondaryContainer,
  //                 title: Text(
  //                   "Add a Reminder",
  //                   style: t.textTheme.button?.copyWith(
  //                     color: c.onSecondaryContainer,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 trailingIcon: Icon(
  //                   Icons.notification_add_outlined,
  //                   color: c.onSecondaryContainer,
  //                 ),
  //                 onPressed: () {
  //                   Utils().reminderDialog(
  //                     notesData.data![noteIndex].data["title"],
  //                     notesData.data![noteIndex].data["body"],
  //                     notesData.data![noteIndex].id,
  //                     context,
  //                     t,
  //                     c,
  //                   );
  //                 },
  //               ),
  //               FocusedMenuItem(
  //                 backgroundColor: c.secondaryContainer,
  //                 title: Text(
  //                   "Add to Folder",
  //                   style: t.textTheme.button?.copyWith(
  //                     color: c.onSecondaryContainer,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 trailingIcon: Icon(
  //                   Icons.create_new_folder_outlined,
  //                   color: c.onSecondaryContainer,
  //                 ),
  //                 onPressed: () {
  //                   Get.to(
  //                     () => PickFolder(
  //                       noteId: notesData.data![noteIndex].id,
  //                       noteTitle: notesData.data![noteIndex].data["title"],
  //                       noteBody: notesData.data![noteIndex].data["body"],
  //                     ),
  //                   );
  //                 },
  //               ),
  //               if (_accountLinked &&
  //                   !notesData.data![noteIndex].data["isList"] &&
  //                   !notesData.data![noteIndex].data["isExpense"])
  //                 FocusedMenuItem(
  //                   backgroundColor: c.secondaryContainer,
  //                   title: Text(
  //                     "Back Up",
  //                     style: t.textTheme.button?.copyWith(
  //                       color: c.onSecondaryContainer,
  //                       fontSize: 12,
  //                     ),
  //                   ),
  //                   trailingIcon: Icon(
  //                     Icons.cloud_upload_outlined,
  //                     color: c.onSecondaryContainer,
  //                   ),
  //                   onPressed: () {
  //                     DatabaseService().backUpSingleNote(
  //                       user.uid,
  //                       notesData.data![noteIndex].id,
  //                       notesData.data![noteIndex].data["title"].toString(),
  //                       notesData.data![noteIndex].data["body"].toString(),
  //                       notesData.data![noteIndex].data["creationTime"]
  //                           .toString(),
  //                       notesData.data![noteIndex].data["pinned"] ?? false,
  //                       notesData.data![noteIndex].data["isList"] ?? false,
  //                       notesData.data![noteIndex].data["isExpense"] ?? false,
  //                       notesData.data![noteIndex].data["totalItem"] ?? 0,
  //                       notesData.data![noteIndex].data["type"],
  //                     );
  //                   },
  //                 ),
  //               FocusedMenuItem(
  //                 backgroundColor: c.secondaryContainer,
  //                 title: Text(
  //                   "Delete",
  //                   style: t.textTheme.button?.copyWith(
  //                     color: c.onSecondaryContainer,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 trailingIcon: Icon(
  //                   Icons.delete_outlined,
  //                   color: c.onSecondaryContainer,
  //                 ),
  //                 onPressed: () {
  //                   NotesDatabase().deleteNote(notesData.data![noteIndex].id);
  //                 },
  //               ),
  //               FocusedMenuItem(
  //                 backgroundColor: c.secondaryContainer,
  //                 title: Text(
  //                   notesData.data![noteIndex].data["pinned"] ?? false
  //                       ? "Unpin"
  //                       : "Pin",
  //                   style: t.textTheme.button?.copyWith(
  //                     color: c.onSecondaryContainer,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 trailingIcon: Icon(
  //                   notesData.data![noteIndex].data["pinned"] ?? false
  //                       ? Icons.push_pin_rounded
  //                       : Icons.push_pin_outlined,
  //                   color: c.onSecondaryContainer,
  //                 ),
  //                 onPressed: () async {
  //                   await pinNote(notesData, noteIndex);
  //                 },
  //               ),
  //             ],
  //             child: GestureDetector(
  //               onTap: () {
  //                 if (notesData.data![noteIndex].data["isList"] ??
  //                     false == true) {
  //                   Get.to(
  //                     () => ListviewView(noteId: notesData.data![noteIndex].id),
  //                   );
  //                 } else if (notesData.data![noteIndex].data["isExpense"] ==
  //                     true) {
  //                   Get.to(() => ExpenseTrackerView(
  //                       noteId: notesData.data![noteIndex].id));
  //                 } else {
  //                   Get.to(
  //                     () => NotePage(noteId: notesData.data![noteIndex].id),
  //                   );
  //                 }
  //               },
  //               child: Card(
  //                 color: c.surfaceVariant,
  //                 elevation: 0,
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(12)),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             notesData.data![noteIndex].data["title"]
  //                                 .toString(),
  //                             style: t.textTheme.button,
  //                           ),
  //                           Visibility(
  //                             visible:
  //                                 notesData.data![noteIndex].data["pinned"],
  //                             child: Icon(
  //                               Icons.push_pin_rounded,
  //                               size: 12,
  //                               color: Colors.grey[500],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       // LIST ITEMS
  //                       if (notesData.data![noteIndex].data["isList"] == true)
  //                         for (var i = 0;
  //                             i <=
  //                                 notesData.data![noteIndex].data["totalItems"];
  //                             i++)
  //                           FutureBuilder<DocumentSnapshot>(
  //                             future: ScientISSTdb.instance
  //                                 .collection("notes")
  //                                 .document(notesData.data![noteIndex].id)
  //                                 .collection(i.toString())
  //                                 .document(i.toString())
  //                                 .get(),
  //                             builder: (context,
  //                                 AsyncSnapshot<DocumentSnapshot> snapshot) {
  //                               if (snapshot.hasData) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.all(5.0),
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         snapshot.data!.data["checked"]
  //                                             ? Icons.check_circle
  //                                             : Icons.circle_outlined,
  //                                         color: c.onSecondaryContainer,
  //                                         size: 12,
  //                                       ),
  //                                       const SizedBox(
  //                                         width: 5,
  //                                       ),
  //                                       SizedBox(
  //                                         width: Get.width / 3.5,
  //                                         child: Text(
  //                                           snapshot.data!.data["text"]
  //                                               .toString(),
  //                                           maxLines: 15,
  //                                           textWidthBasis:
  //                                               TextWidthBasis.longestLine,
  //                                           softWrap: true,
  //                                           overflow: TextOverflow.fade,
  //                                           style: t.textTheme.bodyMedium,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               } else {
  //                                 return const SizedBox();
  //                               }
  //                             },
  //                           ),
  //                       // NOTES BODY
  //                       if (notesData.data![noteIndex].data["isList"] == false)
  //                         Text(
  //                           notesData.data![noteIndex].data["body"].toString(),
  //                           maxLines: 15,
  //                           softWrap: true,
  //                           style: t.textTheme.bodyMedium,
  //                           overflow: TextOverflow.fade,
  //                         ),
  //                       const SizedBox(
  //                         height: 20,
  //                       ),
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Consumer<ThemeNotifier>(
  //                               builder: (context, notifier, child) {
  //                             return Text(
  //                               notesData.data![noteIndex].data["creationTime"]
  //                                   .toString(),
  //                               style: notifier.material3
  //                                   ? t.textTheme.labelSmall?.copyWith(
  //                                       color: c.onSecondaryContainer,
  //                                     )
  //                                   : t.textTheme.labelSmall,
  //                             );
  //                           }),
  //                           Consumer<ThemeNotifier>(
  //                               builder: (context, notifier, child) {
  //                             return NotesTypeIcon(
  //                               type: notesData.data![noteIndex].data["type"]
  //                                   .toString(),
  //                             );
  //                           }),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void shareNote(
  //     AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) {
  //   Share.share(
  //     "*${notesData.data![noteIndex].data["title"]}*\n\n${notesData.data![noteIndex].data["body"]}",
  //   );
  // }

  // Future<void> pinNote(
  //     AsyncSnapshot<List<DocumentSnapshot>> notesData, int noteIndex) async {
  //   var note = Note(
  //       body: notesData.data![noteIndex].data["body"].toString(),
  //       creationTime: DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
  //       title: notesData.data![noteIndex].data["title"].toString(),
  //       pinned: !notesData.data![noteIndex].data["pinned"],
  //       isExpense: notesData.data![noteIndex].data["isExpense"],
  //       isList: notesData.data![noteIndex].data["isList"],
  //       totalItems: notesData.data![noteIndex].data["totalItems"],
  //       type: notesData.data![noteIndex].data["type"].toString());
  //   await NotesDatabase().updateNote(note, notesData.data![noteIndex].id, true);
  // }
}
