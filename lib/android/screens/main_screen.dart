import 'dart:io';

import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/all_notes_view.dart';
import 'package:notes/android/views/all_folder_view.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

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

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    if (kDebugMode) {
      print("MAIN SCREEN INIT STATE");
      print("SELECTED INDEX: " + widget.selectedIndex.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final myTabs = [
    const Tab(text: "All"),
    const Tab(text: "Folders"),
  ];
  TabBar get _tabBar => TabBar(
      isScrollable: true,
      enableFeedback: true,
      controller: _tabController,
      labelColor: c.tertiary,
      unselectedLabelColor: c.tertiaryContainer,
      labelPadding: EdgeInsets.only(
        left: Get.width / 6,
        right: Get.width / 6,
      ),
      labelStyle: t.textTheme.headline6?.copyWith(
        fontSize: 18,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      indicatorColor: c.tertiary,
      indicator: ContainerTabIndicator(
          height: 5,
          padding: const EdgeInsets.only(
            top: 15,
          ),
          color: c.tertiary,
          radius: BorderRadius.circular(
            10,
          )),
      tabs: myTabs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "notes",
          style: t.textTheme.headline6,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/clipboard');
            },
            icon: Icon(
              UniconsLine.clipboard_notes,
              color: c.onBackground,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed('/settings');
            },
            icon: Icon(
              UniconsLine.setting,
              color: c.onBackground,
            ),
          ),
        ],
        bottom: _tabBar,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllNotesView(
            notesFuture: NotesDatabase().getNotes(),
            foldersFuture: NotesDatabase().getFolders(),
          ),
          AllFoldersView(foldersFuture: NotesDatabase().getFolders()),
        ],
      ),
    );
  }
}
