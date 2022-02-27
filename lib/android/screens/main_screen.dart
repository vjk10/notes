import 'dart:io';

import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/all_notes_view.dart';
import 'package:notes/android/views/folder_view.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

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

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    if (kDebugMode) {
      print("MAIN SCREEN INIT STATE");
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
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NotesLogo(
          width: 18,
          height: 18,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/settings');
            },
            icon: Icon(
              UniconsLine.setting,
              color: c.onBackground,
            ),
          )
        ],
        bottom: _tabBar,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllNotesView(notesFuture: NotesDatabase().getNotes()),
          FoldersView(foldersFuture: NotesDatabase().getFolders()),
        ],
      ),
    );
  }
}
