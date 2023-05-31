import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/views/boards/create_board_view.dart';
import 'package:notes/android/views/boards/display_board_view.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/data/data.dart';
import 'package:notes/services/firestore_db/user_model.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';
import 'package:avatar_stack/avatar_stack.dart';

class BoardsView extends StatefulWidget {
  const BoardsView({Key? key}) : super(key: key);

  @override
  State<BoardsView> createState() => _BoardsViewState();
}

class _BoardsViewState extends State<BoardsView> {
  int dataCount = 0;
  late UserModelCollectionReference userModelCollectionReference;
  late UserModelDocumentReference userModelDocumentReference;
  @override
  void initState() {
    getCount();
    super.initState();
  }

  getCount() async {
    if (StaticData.cameSignedIn == false) {
      await StaticData.isarDb.boardsLocals.count().then((value) {
        if (kDebugMode) {
          print("count of boards: $value");
        }
        setState(() {
          dataCount = value;
        });
      });
    } else {
      userModelDocumentReference =
          UserModelCollectionReference().doc(StaticData.uid);
      userModelDocumentReference.boards.get().then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            dataCount = value.docs.length;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataCount > 0
        ? StaticData.cameSignedIn
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder<BoardsModelQuerySnapshot>(
                  stream: userModelDocumentReference.boards.snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        {
                          final boards = snapshot.data;
                          return ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            itemCount: boards?.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: BoardsFbListItem(
                                  boardsModel: BoardsModel(
                                    boardname:
                                        boards!.docs[index].data.boardname,
                                    createdby:
                                        boards.docs[index].data.createdby,
                                    createdon:
                                        boards.docs[index].data.createdon,
                                    boardcolor:
                                        boards.docs[index].data.boardcolor,
                                    boardtextcolor:
                                        boards.docs[index].data.boardtextcolor,
                                  ),
                                  id: boards.docs[index].id,
                                ),
                              );
                            },
                          );
                        }
                      case ConnectionState.waiting:
                        {
                          return const NotesLoadingAndroid(strokeWidth: 2);
                        }
                      default:
                        {
                          return const NotesLoadingAndroid(strokeWidth: 2);
                        }
                    }
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder<List<BoardsLocal>>(
                  stream: StaticData.isarDb.boardsLocals
                      .where()
                      .watch(fireImmediately: true),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        {
                          final boards = snapshot.data;
                          return ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            itemCount: boards?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: BoardsListItem(
                                  boardsLocal: boards![index],
                                ),
                              );
                            },
                          );
                        }
                      case ConnectionState.waiting:
                        {
                          return const NotesLoadingAndroid(strokeWidth: 2);
                        }
                      default:
                        {
                          return const NotesLoadingAndroid(strokeWidth: 2);
                        }
                    }
                  },
                ),
              )
        : const Center(child: NoBoardsCreated());
  }
}

class BoardsListItem extends StatelessWidget {
  final BoardsLocal boardsLocal;
  const BoardsListItem({
    Key? key,
    required this.boardsLocal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 30,
      height: 200,
      decoration: BoxDecoration(
        color: Color(boardsLocal.boardcolor!),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProfileAvatar(
                  StaticData.photourl,
                  backgroundColor: poliPurple500,
                  radius: 20,
                  borderColor: poliPurple500,
                  initialsText: Text(
                    StaticData.displayname[0].toString(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "created by: ${boardsLocal.createdby!}",
                  style: StaticData.t.textTheme.titleLarge?.copyWith(
                    fontFamily: 'Cirka',
                    color: Color(boardsLocal.boardtextcolor!),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  boardsLocal.boardname!,
                  style: StaticData.t.textTheme.displaySmall?.copyWith(
                    color: Color(boardsLocal.boardtextcolor!),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeoPopButton(
                  color: popWhite500,
                  onTapUp: () {
                    Get.to(
                      () => DisplayBoardView(
                        boardid: boardsLocal.id,
                      ),
                    );
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  parentColor: Colors.transparent,
                  buttonPosition: Position.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("open board",
                            style: StaticData.t.textTheme.bodyLarge?.copyWith(
                              color: popBlack500,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BoardsFbListItem extends StatelessWidget {
  final BoardsModel boardsModel;
  final String id;
  const BoardsFbListItem({
    Key? key,
    required this.boardsModel,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 30,
      height: 200,
      decoration: BoxDecoration(
        color: Color(boardsModel.boardcolor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StaticData.photourl.isNotEmpty
                    ? Row(
                        children: [
                          AvatarStack(
                            width: Get.width / 3,
                            height: 42,
                            borderWidth: 1,
                            borderColor: Color(boardsModel.boardtextcolor),
                            avatars: [
                              NetworkImage(StaticData.photourl, scale: 2),
                            ],
                            infoWidgetBuilder: (surplus) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: popWhite500,
                                ),
                                child: Center(
                                  child: Text(
                                    "+${surplus.toString()}",
                                    style: StaticData.t.textTheme.titleMedium
                                        ?.copyWith(
                                      color: poliPurple500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Row(children: [
                        CircularProfileAvatar(
                          StaticData.photourl,
                          backgroundColor: poliPurple500,
                          radius: 20,
                          borderColor: poliPurple500,
                          initialsText: Text(
                            StaticData.displayname[0].toString(),
                          ),
                        ),
                      ]),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "created by: ${boardsModel.createdby}",
                  style: StaticData.t.textTheme.titleLarge?.copyWith(
                    fontFamily: 'Cirka',
                    color: Color(boardsModel.boardtextcolor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: Text(
                    boardsModel.boardname,
                    style: StaticData.t.textTheme.displaySmall?.copyWith(
                      color: Color(boardsModel.boardtextcolor),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeoPopButton(
                  color: popWhite500,
                  onTapUp: () {
                    Get.to(
                      () => DisplayBoardView(
                        boardidFb: id,
                      ),
                    );
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  parentColor: Colors.transparent,
                  buttonPosition: Position.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("open board",
                            style: StaticData.t.textTheme.bodyLarge?.copyWith(
                              color: popBlack500,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NoBoardsCreated extends StatelessWidget {
  const NoBoardsCreated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/system error.svg"),
            const SizedBox(
              height: 40,
            ),
            Text(
              "no boards created!",
              style: StaticData.t.textTheme.titleLarge?.copyWith(
                fontFamily: 'Cirka',
                color: popWhite500,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 350,
              height: 80,
              child: NeoPopTiltedButton(
                isFloating: true,
                onTapUp: () {
                  Get.to(() => const CreateBoardView());
                },
                onTapDown: () {
                  HapticFeedback.heavyImpact();
                },
                decoration: NeoPopTiltedButtonDecoration(
                  color: winYellow500,
                  plunkColor: winYellow600,
                  shadowColor: popWhite100.withOpacity(0.1),
                  showShimmer: true,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70.0,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: popBlack500,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'create your first board!',
                        style: StaticData.t.textTheme.bodyLarge?.copyWith(
                          color: popBlack600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
