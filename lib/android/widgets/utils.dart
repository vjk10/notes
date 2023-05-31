import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../data/data.dart';
import '../../notes_icon_icons.dart';
import '../../services/isar_db/boards_local_schema.dart';
import '../../theme/colors.dart';
import '../views/items/display_note_view.dart';
import 'bottom_sheet.dart';

class Utils {
  IconData getOpenIcon(String url) {
    if (StaticData.ytRegEx.hasMatch(url)) {
      return LineIcons.youtube;
    } else if (url.contains('spotify')) {
      return LineIcons.spotify;
    } else if (url.contains('facebook')) {
      return LineIcons.facebook;
    } else if (url.contains('google')) {
      return LineIcons.search;
    } else {
      return Icons.open_in_new_outlined;
    }
  }

  String getOpenText(String url) {
    if (StaticData.ytRegEx.hasMatch(url)) {
      return 'watch';
    } else if (url.contains('spotify')) {
      return 'listen';
    } else if (url.contains('google')) {
      return 'search';
    } else {
      return 'open';
    }
  }

  Column notesOptionSheetTop(List<NotesLocal> notes, int index) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "selected note",
              style: StaticData.t.textTheme.headlineMedium?.copyWith(
                color: popBlack600,
                fontFamily: 'Cirka',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: Get.width / 2,
              child: Center(
                child: Text(
                  notes[index].title.toString(),
                  style: StaticData.t.textTheme.displaySmall?.copyWith(
                    color: popBlack500,
                    fontFamily: 'Cirka',
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Center notesOptionSheetChildBottom(List<NotesLocal> notes, int index) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 25.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    LineIcons.scroll,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: Get.width / 1.8,
                    height: 37,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'rename this note',
                          style: StaticData.t.textTheme.bodyLarge?.copyWith(
                            color: popBlack500,
                            fontFamily: 'Cirka',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'change the title of the note',
                            style: StaticData.t.textTheme.bodyMedium?.copyWith(
                              color: popBlack100,
                              fontFamily: 'Cirka',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 25.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    LineIcons.trash,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: Get.width / 1.8,
                    height: 37,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'delete this note',
                          style: StaticData.t.textTheme.bodyLarge?.copyWith(
                            color: popBlack500,
                            fontFamily: 'Cirka',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'this deletes only the local copy',
                            style: StaticData.t.textTheme.bodyMedium?.copyWith(
                              color: popBlack100,
                              fontFamily: 'Cirka',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 25.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    LineIcons.fileDownload,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: Get.width / 1.8,
                    height: 37,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'download this note',
                          style: StaticData.t.textTheme.bodyLarge?.copyWith(
                            color: popBlack500,
                            fontFamily: 'Cirka',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'download note as plain text',
                            style: StaticData.t.textTheme.bodyMedium?.copyWith(
                              color: popBlack100,
                              fontFamily: 'Cirka',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 25.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    LineIcons.fileUpload,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: Get.width / 1.8,
                    height: 37,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'backup this note',
                          style: StaticData.t.textTheme.bodyLarge?.copyWith(
                            color: popBlack500,
                            fontFamily: 'Cirka',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'back up note to your Google account',
                            style: StaticData.t.textTheme.bodyMedium?.copyWith(
                              color: popBlack100,
                              fontFamily: 'Cirka',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
    );
  }

  Column showSettingsPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: CircularProfileAvatar(
            StaticData.photourl,
            borderColor: poliPurple500,
            initialsText: Text(
              StaticData.displayname[0].toString(),
            ),
            backgroundColor: poliPurple500,
            radius: 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width - 40,
              child: Center(
                child: Text(
                  StaticData.displayname,
                  style: StaticData.t.textTheme.headlineMedium?.copyWith(
                    color: popBlack500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(
              width: Get.width - 40,
              child: Center(
                child: Text(
                  StaticData.email,
                  style: StaticData.t.textTheme.headlineSmall?.copyWith(
                    color: popBlack500,
                    fontFamily: 'Cirka',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 15.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineIcons.userCog,
                color: popBlack500,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: Get.width / 1.8,
                height: 37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'manage devices',
                      style: StaticData.t.textTheme.bodyLarge?.copyWith(
                        color: popBlack500,
                        fontFamily: 'Cirka',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'manage all devices in the account',
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: popBlack100,
                          fontFamily: 'Cirka',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 15.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineIcons.mask,
                color: popBlack500,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: Get.width / 1.8,
                height: 37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'privacy & security',
                      style: StaticData.t.textTheme.bodyLarge?.copyWith(
                        color: popBlack500,
                        fontFamily: 'Cirka',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'data privacy and security',
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: popBlack100,
                          fontFamily: 'Cirka',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 15.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineIcons.alternateCloudUpload,
                color: popBlack500,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: Get.width / 1.8,
                height: 37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'instant backup',
                      style: StaticData.t.textTheme.bodyLarge?.copyWith(
                        color: popBlack500,
                        fontFamily: 'Cirka',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'instantly upload data to account',
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: popBlack100,
                          fontFamily: 'Cirka',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 15.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineIcons.cogs,
                color: popBlack500,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: Get.width / 1.8,
                height: 37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'more settings',
                      style: StaticData.t.textTheme.bodyLarge?.copyWith(
                        color: popBlack500,
                        fontFamily: 'Cirka',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'expand settings page',
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: popBlack100,
                          fontFamily: 'Cirka',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container showListItem(List<NotesLocal> notes, int index,
      BoardsLocal boardsLocal, BuildContext context) {
    return Container(
      width: Get.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //   color: Color(boardsLocal.boardtextcolor!),
        //   width: 2,
        // ),
        color: Color(boardsLocal.boardcolor!).withBlue(255),
      ),
      child: ListTile(
        onTap: () {
          Get.to(() => DisplayNoteView(
                boardid: boardsLocal.id,
                note: notes[index],
                boardColor: Color(boardsLocal.boardcolor!),
                boardTextColor: Color(boardsLocal.boardtextcolor!),
              ));
        },
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return NotesBottomSheet(
                // childTop: Utils().notesOptionSheetTop(notes, index),
                child: Utils().notesOptionSheetChildBottom(notes, index),
              );
            },
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black.withOpacity(0.5),
            elevation: 0,
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        title: Text(
          notes[index].title.toString(),
          style: StaticData.t.textTheme.bodyLarge?.copyWith(
            color: Color(boardsLocal.boardtextcolor!),
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
                      child: Text(
                        notes[index].bodyPlainText.toString(),
                        maxLines: 3,
                        style: StaticData.t.textTheme.bodyMedium?.copyWith(
                          color: Color(
                            boardsLocal.boardtextcolor!,
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
                fontFamily: 'AbrilFatFace',
                color: Color(boardsLocal.boardtextcolor!),
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
