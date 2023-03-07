import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/views/boards/add_items_to_board_view.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/data/data.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';

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
  @override
  void initState() {
    getBoard();
    super.initState();
  }

  getBoard() async {
    try {
      await StaticData.isarDb.boardsLocals.get(widget.boardid).then((value) {
        setState(() {
          boardsLocal = value!;
          isLoading = false;
        });
      }).whenComplete(() {
        final noteslocal = boardsLocal.notesLocal!;
        if (noteslocal.isNotEmpty) {
          getBoardItems();
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getBoardItems() {
    notescount = boardsLocal.notesLocal!.length;
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Get.to(() => const AddItemsToBoard());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "create item",
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: Color(boardsLocal.boardcolor!),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        Icons.add,
                        color: Color(boardsLocal.boardcolor!),
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: datafound
                ? Container()
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
                  ),
          );
  }
}
