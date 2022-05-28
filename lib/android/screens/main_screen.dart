import 'dart:io';

import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/notes/all_notes_view.dart';
import 'package:notes/android/views/folders/all_folder_view.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final myTabs = [
    const Tab(text: "all"),
    const Tab(text: "folders"),
  ];
  TabBar get _tabBar => TabBar(
      isScrollable: true,
      enableFeedback: true,
      controller: _tabController,
      labelColor: c.primary,
      unselectedLabelColor: c.secondary,
      labelPadding: EdgeInsets.only(
        left: Get.width / 6,
        right: Get.width / 6,
      ),
      labelStyle: t.textTheme.headline6?.copyWith(
        fontSize: 18,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      indicatorColor: c.primary,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      indicator: ContainerTabIndicator(
          height: 5,
          padding: const EdgeInsets.only(
            top: 15,
          ),
          color: c.primary,
          radius: BorderRadius.circular(
            10,
          )),
      tabs: myTabs);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Scaffold(
          backgroundColor: c.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: notifier.material3
                ? c.secondaryContainer.withAlpha(50)
                : c.secondaryContainer,
            title: Text(
              "notes",
              style: t.textTheme.headline6,
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('/settings');
                },
                icon: Icon(
                  Icons.settings_outlined,
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
                foldersFuture: NotesDatabase().getFolders(),
              ),
              const AllFoldersView(),
            ],
          ));
    });
  }
}
