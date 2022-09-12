import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';
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

  List<NavigationDestination> mainScreenDestination = [
    const NavigationDestination(
        selectedIcon: Icon(
          Icons.description_rounded,
        ),
        icon: Icon(
          Icons.description_outlined,
        ),
        label: 'notes'),
    const NavigationDestination(
        selectedIcon: Icon(
          Icons.folder_rounded,
        ),
        icon: Icon(
          Icons.folder_outlined,
        ),
        label: 'folders'),
    const NavigationDestination(
        selectedIcon: Icon(
          Icons.notifications,
        ),
        icon: Icon(
          Icons.notifications_outlined,
        ),
        label: 'alerts'),
    const NavigationDestination(
        selectedIcon: Icon(
          Icons.assignment,
        ),
        icon: Icon(
          Icons.assignment_outlined,
        ),
        label: 'clipboard'),
  ];

  List<Widget> destinations = [
    const AllNotesView(),
    const AllFoldersView(),
    const AllAlertsView(),
    const ClipBoard(),
  ];

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void initState() {
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
