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
                backgroundColor: c.primaryContainer,
                foregroundColor: c.onPrimaryContainer,
                closeButtonStyle: ExpandableFabCloseButtonStyle(
                    backgroundColor: c.tertiaryContainer,
                    child: Icon(
                      Icons.close_outlined,
                      color: c.onTertiaryContainer,
                    )),
                key: _key,
                child: Icon(
                  Icons.add,
                  color: c.onPrimaryContainer,
                ),
                children: [
                  FloatingActionButton(
                    heroTag: 'noteButtonTag',
                    child: const Icon(Icons.note_add_outlined),
                    onPressed: () {
                      Get.to(
                        () => const AddNoteView(),
                        duration: const Duration(milliseconds: 600),
                      );
                    },
                  ),
                  FloatingActionButton(
                    heroTag: 'listButtonTag',
                    child: const Icon(Icons.add_task_outlined),
                    onPressed: () {
                      Get.to(
                        () => const AddListView(),
                        duration: const Duration(milliseconds: 600),
                      );
                    },
                  ),
                  FloatingActionButton(
                    heroTag: 'expenseButtonTag',
                    child: const Icon(Icons.request_page_outlined),
                    onPressed: () {
                      Get.to(
                        () => const AddExpenseTrackerView(),
                        duration: const Duration(milliseconds: 600),
                      );
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
}
