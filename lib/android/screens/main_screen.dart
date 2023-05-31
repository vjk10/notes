import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:get/get.dart';
import 'package:notes/android/screens/onboarding/onboarding_one.dart';
import 'package:notes/android/views/boards/create_board_view.dart';
import 'package:notes/android/views/boards_view.dart';
import 'package:notes/android/views/tasks_view.dart';
import 'package:notes/data/data.dart';
import 'package:notes/services/firestore_db/google_sign_in.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/services/other/auth_services.dart';
import 'package:notes/theme/colors.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  // final MainScreenArgument argument;
  final int selectedIndex;

  const MainScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  String? userName = "Username";
  String cacheMemorySize = "0";
  String appMemorySize = "0";
  String userProfile = "";
  bool appMemoryFound = false;
  bool cacheFound = false;
  late String day;

  String boardscount = "0";
  String taskcount = "0";

  late Directory tempDir;
  late Directory appDir;

  bool isLoading = false;
  bool userSignedIn = false;

  User? user;

  int selectedIndex = 0;
  final FlutterShortcuts flutterShortcuts = FlutterShortcuts();

  late TabController tabController;

  int crossAxisCount = 1;

  @override
  void didChangeDependencies() {
    StaticData.t = Theme.of(context);
    StaticData.c = StaticData.t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // setShortCuts();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    selectedIndex = widget.selectedIndex;
    if (StaticData.uid.isEmpty) {
      checkAuthState();
    }
    selectedIndex = widget.selectedIndex;
    getCounts();
    if (kDebugMode) {
      print("MAIN SCREEN INIT STATE");
      print("SELECTED INDEX: ${widget.selectedIndex}");
    }
    super.initState();
  }

  checkAuthState() async {
    await AuthServices().authChanges(false).whenComplete(() {
      setState(() {});
    });
  }

  getCounts() async {
    setState(() {
      boardscount = StaticData.isarDb.boardsLocals.count().toString();
    });
  }

  setShortCuts() {
    flutterShortcuts.initialize(debug: kDebugMode);
    flutterShortcuts.clearShortcutItems();
    flutterShortcuts.setShortcutItems(
      shortcutItems: <ShortcutItem>[
        const ShortcutItem(
          id: "1",
          action: StaticData.noteAction,
          shortLabel: 'Add Note',
          icon: 'assets/images/note_add_shortcut.png',
        ),
        const ShortcutItem(
          id: "2",
          action: StaticData.expenseAction,
          shortLabel: 'Add Expense',
          icon: 'assets/images/expense_add_shortcut.png',
        ),
        const ShortcutItem(
          id: "3",
          action: StaticData.listAction,
          shortLabel: 'Add List',
          icon: 'assets/images/task_add_shortcut.png',
        ),
      ],
    );
    flutterShortcuts.listenAction((action) {
      switch (action) {
        case StaticData.noteAction:
          {
            if (kDebugMode) {
              print("ACTION: $StaticData.noteAction");
            }
          }
          break;
        case StaticData.expenseAction:
          {
            if (kDebugMode) {
              print("ACTION: $StaticData.expenseAction");
            }
          }
          break;
        case StaticData.listAction:
          {
            if (kDebugMode) {
              print("ACTION: $StaticData.listAction");
              // #56
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: popBlack500,
        appBar: AppBar(
          backgroundColor: popBlack500,
          toolbarHeight: 80,
          title: CircularProfileAvatar(
            StaticData.photourl,
            backgroundColor: poliPurple500,
            radius: 20,
            onTap: () {
              switch (StaticData.cameSignedIn) {
                case true:
                  {
                    signOutGoogle(context);
                    Get.offAll(() => const OnBoarding1());
                  }
                  break;
                default:
                  {
                    AuthServices().signOutLocalUser();
                    Get.offAll(() => const OnBoarding1());
                  }
              }
            },
            borderColor: poliPurple500,
            initialsText: Text(
              StaticData.displayname[0].toString(),
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "hey! ${StaticData.displayname.split(' ')[0]}",
                    style: StaticData.t.textTheme.headlineLarge?.copyWith(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Today's ${DateFormat(DateFormat.WEEKDAY).format(DateTime.now())}",
                    style: StaticData.t.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Cirka',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                      DateTime.now(),
                    ),
                    style: StaticData.t.textTheme.bodySmall?.copyWith(
                      fontFamily: 'Cirka',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TabBar(
                      controller: tabController,
                      indicatorWeight: 1,
                      indicatorColor: popBlack400,
                      dividerColor: popBlack400,
                      enableFeedback: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      onTap: (value) {
                        if (kDebugMode) {
                          print(value);
                        }
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                      tabs: [
                        Tab(
                          child: Text(
                            'Boards',
                            style: StaticData.t.textTheme.headlineSmall,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Tasks',
                            style: StaticData.t.textTheme.headlineSmall,
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: yoyo500.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: yoyo500)),
              child: IconButton(
                color: yoyo500,
                onPressed: () {
                  Get.to(
                    () => const CreateBoardView(),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: yoyo500,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: TabBarView(controller: tabController, children: const [
          BoardsView(),
          TasksView(),
        ]));
  }
}
