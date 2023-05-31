import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/views/boards/add_items_to_board_view.dart';
import 'package:notes/android/views/items/display_note_view.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/android/widgets/notes_snackbar.dart';
import 'package:notes/data/data.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/firestore_db/boards_services.dart';
import 'package:notes/services/firestore_db/user_model.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/services/other/local_model.dart';
import 'package:notes/theme/colors.dart';

import '../../widgets/bottom_sheet.dart';
import '../../widgets/utils.dart';

// ignore: must_be_immutable
class DisplayBoardView extends StatefulWidget {
  int? boardid;
  String? boardidFb;
  DisplayBoardView({Key? key, this.boardid, this.boardidFb}) : super(key: key);

  @override
  State<DisplayBoardView> createState() => _DisplayBoardViewState();
}

class _DisplayBoardViewState extends State<DisplayBoardView> {
  late BoardsLocal boardsLocal;
  late BoardsModel boardsModel;
  bool isLoading = true;
  int notescount = 0;
  bool datafound = false;
  List<NotesLocal> notes = [];
  bool listSwitch = true;
  int listSwitchValue = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool activateTint = true;

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
      await StaticData.isarDb.boardsLocals.get(widget.boardid!).then((value) {
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
      UserModelCollectionReference()
          .doc(StaticData.uid)
          .boards
          .doc(widget.boardidFb)
          .get()
          .then((value) {
        setState(() {
          boardsModel = value.data!;
          isLoading = false;
          getBoardItems();
        });
      });
    }
  }

  getBoardItems() async {
    if (StaticData.cameSignedIn == true) {
      await UserModelCollectionReference()
          .doc(StaticData.uid)
          .boards
          .doc(widget.boardidFb)
          .notes
          .get()
          .then((value) {
        notescount = value.docs.length;
      });
    } else {
      notescount = await StaticData.isarDb.notesLocals.count();
    }
    if (kDebugMode) {
      print("Notes Count: $notescount");
    }
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
        : StaticData.cameSignedIn
            ? showOnlineItems()
            : showOfflineItems();
  }

  Scaffold showOfflineItems() {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: activateTint
          ? Color(boardsLocal.boardcolor!)
          : Color(boardsLocal.boardtextcolor!),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "back",
          style: StaticData.t.textTheme.headlineSmall?.copyWith(
            color: activateTint
                ? Color(boardsLocal.boardtextcolor!)
                : Color(boardsLocal.boardcolor!),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            NotesIcon.button_arrow_left,
            size: 12,
            color: activateTint
                ? Color(boardsLocal.boardtextcolor!)
                : Color(boardsLocal.boardcolor!),
          ),
          color: StaticData.c.primary,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              setState(() {
                activateTint = !activateTint;
              });
            },
            icon: Icon(
              activateTint ? LineIcons.tint : LineIcons.tintSlash,
              color: activateTint
                  ? Color(boardsLocal.boardtextcolor!)
                  : Color(boardsLocal.boardcolor!),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: activateTint
            ? Color(boardsLocal.boardcolor!)
            : Color(boardsLocal.boardtextcolor!),
        surfaceTintColor: activateTint
            ? Color(boardsLocal.boardcolor!)
            : Color(boardsLocal.boardtextcolor!),
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
                    color: activateTint
                        ? Color(boardsLocal.boardtextcolor!)
                        : Color(boardsLocal.boardcolor!),
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
                      animationDuration: const Duration(milliseconds: 250),
                      iconAnimationDuration: const Duration(milliseconds: 250),
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
                          value == 0 ? Icons.list_sharp : Icons.grid_view_sharp,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: NeoPopButton(
            color: activateTint
                ? Color(boardsLocal.boardtextcolor!)
                : Color(boardsLocal.boardcolor!),
            onTapDown: () => HapticFeedback.vibrate(),
            onTapUp: () {
              Get.to(() => AddItemsToBoard(
                    boardid: boardsLocal.id,
                    boardColor: Color(boardsLocal.boardcolor!),
                    boardTextColor: Color(boardsLocal.boardtextcolor!),
                    boardname: boardsLocal.boardname!,
                  ));
            },
            child: Icon(
              Icons.add,
              color: activateTint
                  ? Color(boardsLocal.boardcolor!)
                  : Color(boardsLocal.boardtextcolor!),
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

  Scaffold showOnlineItems() {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: activateTint
          ? Color(boardsModel.boardcolor)
          : Color(boardsModel.boardtextcolor),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "back",
          style: StaticData.t.textTheme.headlineSmall?.copyWith(
            color: activateTint
                ? Color(boardsModel.boardtextcolor)
                : Color(boardsModel.boardcolor),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            NotesIcon.button_arrow_left,
            size: 12,
            color: activateTint
                ? Color(boardsModel.boardtextcolor)
                : Color(boardsModel.boardcolor),
          ),
          color: StaticData.c.primary,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (StaticData.cameSignedIn == true) {
                ReturnValue returnValue = await BoardsOnlineService()
                    .deleteBoard(StaticData.uid, widget.boardidFb!);
                if (returnValue.status == HttpStatus.accepted) {
                  NotesSnackBar()
                      .successSnackBar("Board deleted successfully!");
                  Get.off(() => const MainScreen(selectedIndex: 0));
                } else {
                  NotesSnackBar().errorSnackBar("Error deleting board");
                }
              } else {}
            },
            icon: Icon(
              LineIcons.trash,
              color: error,
            ),
          ),
          IconButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              setState(() {
                activateTint = !activateTint;
              });
            },
            icon: Icon(
              activateTint ? LineIcons.tint : LineIcons.tintSlash,
              color: activateTint
                  ? Color(boardsModel.boardtextcolor)
                  : Color(boardsModel.boardcolor),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: activateTint
            ? Color(boardsModel.boardcolor)
            : Color(boardsModel.boardtextcolor),
        surfaceTintColor: activateTint
            ? Color(boardsModel.boardcolor)
            : Color(boardsModel.boardtextcolor),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  boardsModel.boardname.toString(),
                  textAlign: TextAlign.start,
                  style: StaticData.t.textTheme.headlineMedium?.copyWith(
                    color: activateTint
                        ? Color(boardsModel.boardtextcolor)
                        : Color(boardsModel.boardcolor),
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
                      animationDuration: const Duration(milliseconds: 250),
                      iconAnimationDuration: const Duration(milliseconds: 250),
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
                          value == 0 ? Icons.list_sharp : Icons.grid_view_sharp,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: NeoPopButton(
            color: activateTint
                ? Color(boardsModel.boardtextcolor)
                : Color(boardsModel.boardcolor),
            onTapDown: () => HapticFeedback.vibrate(),
            onTapUp: () {
              Get.to(() => AddItemsToBoard(
                    boardidFb: widget.boardidFb,
                    boardColor: Color(boardsModel.boardcolor),
                    boardTextColor: Color(boardsModel.boardtextcolor),
                    boardname: boardsModel.boardname,
                  ));
            },
            child: Icon(
              Icons.add,
              color: activateTint
                  ? Color(boardsModel.boardcolor)
                  : Color(boardsModel.boardtextcolor),
            ),
          ),
        ),
      ),
      body: datafound
          ? StreamBuilder<NotesModelQuerySnapshot>(
              stream: UserModelCollectionReference()
                  .doc(StaticData.uid)
                  .boards
                  .doc(widget.boardidFb)
                  .notes
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    {
                      final notes = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: notes!.docs.length,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        itemBuilder: (context, index) {
                          return showFbListItem(notes.docs, index);
                        },
                      );
                    }
                  default:
                    {
                      // final notesOnline = snapshot.data;
                      // return ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: notesOnline!.docs.length,
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 10,
                      //     horizontal: 10,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     return showFbListItem(notesOnline.docs, index);
                      //   },
                      // );
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/system error.svg"),
                            Text(
                              "nothing on the board yet!",
                              style: StaticData.t.textTheme.bodyLarge?.copyWith(
                                color: Color(boardsModel.boardtextcolor),
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
                      color: Color(boardsModel.boardtextcolor),
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
          Get.to(() => DisplayNoteView(
                boardid: StaticData.cameSignedIn ? 0 : widget.boardid!,
                notesLocal: notes[index],
                notesModel: NotesModel(
                    createdby: "null",
                    createdon: "null",
                    backedup: false,
                    boardid: "null",
                    boardname: "null"),
                boardColor: Color(boardsLocal.boardcolor!),
                boardTextColor: Color(boardsLocal.boardtextcolor!),
              ));
        },
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return NotesBottomSheet(
                child: Utils().notesOptionSheetChildBottom(notes, index),
              );
            },
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black.withOpacity(0.5),
            elevation: 0,
          );
        },
        tileColor: activateTint
            ? Color(boardsLocal.boardtextcolor!)
            : Color(boardsLocal.boardcolor!),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        title: Text(
          notes[index].title.toString(),
          style: StaticData.t.textTheme.bodyLarge?.copyWith(
            color: activateTint
                ? Color(boardsLocal.boardcolor!)
                : Color(boardsLocal.boardtextcolor!),
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
                          color: activateTint
                              ? Color(boardsLocal.boardcolor!)
                              : Color(boardsLocal.boardtextcolor!),
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
                color: activateTint
                    ? Color(boardsLocal.boardcolor!)
                    : Color(boardsLocal.boardtextcolor!),
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Icon(
            NotesIcon.button_arrow_right,
            size: 10,
            color: activateTint
                ? Color(boardsLocal.boardcolor!)
                : Color(boardsLocal.boardtextcolor!),
          ),
        ),
      ),
    );
  }

  Padding showFbListItem(
      List<NotesModelQueryDocumentSnapshot> notes, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {
          Get.to(() => DisplayNoteView(
                boardid: StaticData.cameSignedIn ? 0 : widget.boardid!,
                notesModel: notes[index].data,
                notesLocal: NotesLocal(),
                notesID: notes[index].id,
                boardColor: StaticData.cameSignedIn
                    ? Color(boardsModel.boardcolor)
                    : Color(boardsLocal.boardcolor!),
                boardTextColor: StaticData.cameSignedIn
                    ? Color(boardsModel.boardtextcolor)
                    : Color(boardsLocal.boardtextcolor!),
              ));
        },
        tileColor: activateTint
            ? Color(boardsModel.boardtextcolor)
            : Color(boardsModel.boardcolor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        title: Text(
          notes[index].data.title.toString() == "null"
              ? ""
              : notes[index].data.title.toString(),
          style: StaticData.t.textTheme.bodyLarge?.copyWith(
            color: activateTint
                ? Color(boardsModel.boardcolor)
                : Color(boardsModel.boardtextcolor),
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
                        notes[index].data.bodyPlainText.toString() == "null"
                            ? " "
                            : notes[index].data.bodyPlainText.toString(),
                        maxLines: 3,
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: activateTint
                              ? Color(boardsModel.boardcolor)
                              : Color(boardsModel.boardtextcolor),
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
              "created by: ${notes[index].data.createdby.toString()}",
              style: StaticData.t.textTheme.bodySmall?.copyWith(
                fontFamily: 'Cirka',
                color: activateTint
                    ? Color(boardsModel.boardcolor)
                    : Color(boardsModel.boardtextcolor),
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Icon(
            NotesIcon.button_arrow_right,
            size: 10,
            color: activateTint
                ? Color(boardsModel.boardcolor)
                : Color(boardsModel.boardtextcolor),
          ),
        ),
      ),
    );
  }
}
