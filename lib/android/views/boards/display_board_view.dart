import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/views/boards/add_items_to_board_view.dart';
import 'package:notes/android/views/items/display_note_view.dart';
import 'package:notes/android/widgets/bottom_sheet.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/data/data.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';

class DisplayBoardView extends StatefulWidget {
  final int boardid;
  const DisplayBoardView({Key? key, required this.boardid}) : super(key: key);

  @override
  State<DisplayBoardView> createState() => _DisplayBoardViewState();
}

class _DisplayBoardViewState extends State<DisplayBoardView> {
  late BoardsLocal boardsLocal;
  bool isLoading = true;
  int notescount = 0;
  bool datafound = false;
  List<NotesLocal> notes = [];
  bool listSwitch = true;
  int listSwitchValue = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getBoard();
    super.initState();
  }

  listSwitcher(int value) {
    setState(() {
      listSwitch = !listSwitch;
    });
  }

  getBoard() async {
    try {
      await StaticData.isarDb.boardsLocals.get(widget.boardid).then((value) {
        setState(() {
          boardsLocal = value!;
          isLoading = false;
        });
      }).whenComplete(() {
        getBoardItems();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getBoardItems() async {
    notescount = await StaticData.isarDb.notesLocals.count();
    if (notescount > 0) {
      setState(() {
        datafound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: NotesLoadingAndroid(strokeWidth: 2),
          )
        : Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: false,
            backgroundColor: Color(boardsLocal.boardcolor!),
            appBar: AppBar(
              toolbarHeight: 80,
              title: Text(
                "back",
                style: StaticData.t.textTheme.headlineSmall?.copyWith(
                  color: Color(boardsLocal.boardtextcolor!),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  NotesIcon.button_arrow_left,
                  size: 12,
                  color: Color(boardsLocal.boardtextcolor!),
                ),
                color: StaticData.c.primary,
                onPressed: () {
                  Get.back();
                },
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(boardsLocal.boardcolor!),
              surfaceTintColor: Color(boardsLocal.boardcolor!),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        boardsLocal.boardname.toString(),
                        textAlign: TextAlign.start,
                        style: StaticData.t.textTheme.headlineMedium?.copyWith(
                          color: Color(boardsLocal.boardtextcolor!),
                          fontFamily: 'Cirka',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: datafound,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                          width: 70,
                          child: AnimatedToggleSwitch<int>.size(
                            borderRadius: BorderRadius.zero,
                            borderColor: popBlack500,
                            borderWidth: 4,
                            current: listSwitchValue,
                            innerColor: popBlack500,
                            indicatorColor: popWhite500,
                            values: const [0, 1],
                            selectedIconSize: const Size(20, 20),
                            iconSize: const Size(12, 12),
                            animationDuration:
                                const Duration(milliseconds: 250),
                            iconAnimationDuration:
                                const Duration(milliseconds: 250),
                            animationCurve: Curves.bounceInOut,
                            height: 35,
                            onChanged: (i) async {
                              setState(() => listSwitchValue = i);
                              listSwitcher(i);
                              await Future.delayed(const Duration(seconds: 3));
                            },
                            loading: false,
                            iconBuilder: (value, size) {
                              return Icon(
                                value == 0
                                    ? Icons.list_sharp
                                    : Icons.grid_view_sharp,
                                color: size == const Size(20, 20)
                                    ? popBlack500
                                    : popWhite200,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SizedBox(
                width: 250,
                height: 60,
                child: NeoPopTiltedButton(
                  color: Color(boardsLocal.boardtextcolor!),
                  onTapDown: () => HapticFeedback.vibrate(),
                  onTapUp: () {
                    Get.to(() => AddItemsToBoard(
                          boardid: boardsLocal.id,
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "create item",
                        style: StaticData.t.textTheme.bodyLarge?.copyWith(
                          color: Color(boardsLocal.boardcolor!),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        Icons.add,
                        color: Color(boardsLocal.boardcolor!),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: datafound
                ? StreamBuilder<List<NotesLocal>>(
                    stream: StaticData.isarDb.notesLocals
                        .filter()
                        .boardidEqualTo(widget.boardid)
                        .watch(fireImmediately: true),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                          {
                            final notes = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: notes!.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              itemBuilder: (context, index) {
                                return showListItem(notes, index);
                              },
                            );
                          }
                        default:
                          {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/system error.svg"),
                                  Text(
                                    "nothing on the board yet!",
                                    style: StaticData.t.textTheme.bodyLarge
                                        ?.copyWith(
                                      color: Color(boardsLocal.boardtextcolor!),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.width / 2,
                                  ),
                                ],
                              ),
                            );
                          }
                      }
                    },
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/system error.svg"),
                        Text(
                          "nothing on the board yet!",
                          style: StaticData.t.textTheme.bodyLarge?.copyWith(
                            color: Color(boardsLocal.boardtextcolor!),
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 2,
                        ),
                      ],
                    ),
                    //       ),
                  ),
          );
  }

  Padding showListItem(List<NotesLocal> notes, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {
          Get.to(() =>
              DisplayNoteView(boardid: widget.boardid, note: notes[index]));
        },
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return NotesBottomSheet(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "select your action",
                          style:
                              StaticData.t.textTheme.headlineMedium?.copyWith(
                            color: popBlack600,
                            fontFamily: 'Cirka',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: NeoPopButton(
                            depth: 0,
                            onTapUp: () {
                              HapticFeedback.heavyImpact();
                            },
                            color: Colors.black,
                            child: Center(
                              child: Text("delete",
                                  style: StaticData.t.textTheme.bodyLarge),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: NeoPopButton(
                            depth: 0,
                            onTapUp: () {
                              HapticFeedback.heavyImpact();
                            },
                            color: Colors.black,
                            child: Center(
                              child: Text("back up",
                                  style: StaticData.t.textTheme.bodyLarge),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: NeoPopButton(
                            depth: 0,
                            onTapUp: () {
                              HapticFeedback.heavyImpact();
                            },
                            color: Colors.black,
                            child: Center(
                              child: Text("download",
                                  style: StaticData.t.textTheme.bodyLarge),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: NeoPopButton(
                            depth: 0,
                            onTapUp: () {
                              HapticFeedback.heavyImpact();
                            },
                            color: Colors.black,
                            child: Center(
                              child: Text("share",
                                  style: StaticData.t.textTheme.bodyLarge),
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black.withOpacity(0.5),
            elevation: 0,
          );
        },
        tileColor: Color(boardsLocal.boardtextcolor!),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        title: Text(
          notes[index].title.toString(),
          style: StaticData.t.textTheme.bodyLarge?.copyWith(
            color: Color(boardsLocal.boardcolor!),
          ),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width / 4,
                      height: 50,
                      child: Text(
                        notes[index].bodyPlainText.toString(),
                        maxLines: 3,
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: Color(
                            boardsLocal.boardcolor!,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "created by: ${notes[index].createdby.toString()}",
              style: StaticData.t.textTheme.bodySmall?.copyWith(
                fontFamily: 'Cirka',
                color: Color(boardsLocal.boardcolor!).withOpacity(0.8),
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Icon(
            NotesIcon.button_arrow_right,
            size: 10,
            color: Color(boardsLocal.boardcolor!),
          ),
        ),
      ),
    );
  }
}
