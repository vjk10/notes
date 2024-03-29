import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/expenses/add_expense_tracker.dart';
import 'package:notes/android/views/list/add_list_view.dart';
import 'package:notes/android/views/notes/add_notes_view.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;

import '../views/alerts/list_alerts_view.dart';
import '../views/folders/all_folder_view.dart';
import '../views/clipboard/clipboard_view.dart';
import '../views/notes/all_notes_view.dart';

class MainScreen extends StatefulWidget {
  // final MainScreenArgument argument;
  final int selectedIndex;

  const MainScreen({
    Key? key,
    // required this.argument,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  String userName = "Username";
  String cacheMemorySize = "0";
  String appMemorySize = "0";
  String userProfile = "";
  bool appMemoryFound = false;
  bool cacheFound = false;

  late Directory tempDir;
  late Directory appDir;
  late DocumentSnapshot userSnapshot;
  late TabController _tabController;

  bool isLoading = false;
  bool userSignedIn = false;

  late fire_store.DocumentSnapshot firebaseUserDetails;
  late User user;

  int selectedIndex = 0;
  final FlutterShortcuts flutterShortcuts = FlutterShortcuts();

  NavigationDestination clipBoardDest = NavigationDestination(
      key: clipboardPageKey,
      selectedIcon: const Icon(
        Icons.assignment,
      ),
      icon: const Icon(
        Icons.assignment_outlined,
      ),
      label: 'clipboard');

  Widget clipBoardBody = const ClipBoard();

  List<NavigationDestination> mainScreenDestination = [
    NavigationDestination(
        key: notesPageKey,
        selectedIcon: const Icon(
          Icons.description_rounded,
        ),
        icon: const Icon(
          Icons.description_outlined,
        ),
        label: 'notes'),
    NavigationDestination(
        key: foldersPageKey,
        selectedIcon: const Icon(
          Icons.folder_rounded,
        ),
        icon: const Icon(
          Icons.folder_outlined,
        ),
        label: 'folders'),
    NavigationDestination(
        key: alertsPageKey,
        selectedIcon: const Icon(
          Icons.notifications,
        ),
        icon: const Icon(
          Icons.notifications_outlined,
        ),
        label: 'alerts'),
  ];

  List<Widget> destinations = [
    const AllNotesView(),
    const AllFoldersView(),
    const AllAlertsView(),
  ];

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    setShortCuts();

    initUser();
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    selectedIndex = widget.selectedIndex;
    NotificationService().initialize();
    checkTerms();
    if (kDebugMode) {
      print("MAIN SCREEN INIT STATE");
      print("SELECTED INDEX: ${widget.selectedIndex}");
    }
    super.initState();
  }

  setShortCuts() {
    flutterShortcuts.initialize(debug: kDebugMode);
    flutterShortcuts.clearShortcutItems();
    flutterShortcuts.setShortcutItems(
      shortcutItems: <ShortcutItem>[
        const ShortcutItem(
          id: "1",
          action: noteAction,
          shortLabel: 'Add Note',
          icon: 'assets/images/note_add_shortcut.png',
        ),
        const ShortcutItem(
          id: "2",
          action: expenseAction,
          shortLabel: 'Add Expense',
          icon: 'assets/images/expense_add_shortcut.png',
        ),
        const ShortcutItem(
          id: "3",
          action: listAction,
          shortLabel: 'Add List',
          icon: 'assets/images/task_add_shortcut.png',
        ),
      ],
    );
    flutterShortcuts.listenAction((action) {
      switch (action) {
        case noteAction:
          {
            if (kDebugMode) {
              print("ACTION: $noteAction");
            }
            Get.to(() => const AddNoteView());
          }
          break;
        case expenseAction:
          {
            if (kDebugMode) {
              print("ACTION: $expenseAction");
            }
            Get.to(() => const AddExpenseTrackerView());
          }
          break;
        case listAction:
          {
            if (kDebugMode) {
              print("ACTION: $listAction");
              // #56
              Get.to(() => const AddListView());
            }
          }
          break;
        default:
          {
            if (kDebugMode) {
              print("ACTION: DEFAULT");
            }
          }
      }
    });
  }

  checkTerms() async {
    bool conditions = await Utils().checkTerms();
    if (conditions == false) {
      // ignore: use_build_context_synchronously
      Utils().licenseDialog(context, t, c, false);
    }
  }

  initUser() async {
    try {
      user = FirebaseAuth.instance.currentUser!;
      if (user.uid.isNotEmpty) {
        userSignedIn = true;
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (kDebugMode) {
          print(e.message);
        }
      }
    }
    // Fix for #39
    addClipBoardView();
  }

// Fix for #39
  addClipBoardView() {
    if (userSignedIn) {
      if (mainScreenDestination.length <= 3) {
        mainScreenDestination.add(clipBoardDest);
        destinations.add(clipBoardBody);
      }
    } else {
      if (mainScreenDestination.length >= 4) {
        mainScreenDestination.removeWhere(
          (element) {
            return element.key == clipboardPageKey;
          },
        );
        destinations.removeAt(3);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final myTabs = [
    const Tab(text: "all"),
    const Tab(text: "folders"),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        backgroundColor: c.background,
        body: destinations[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          animationDuration: const Duration(milliseconds: 250),
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          destinations: mainScreenDestination,
        ),
      );
    });
  }
}
