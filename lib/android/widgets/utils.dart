import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:notes/notes_icon_icons.dart';

import '../../data/data.dart';
import '../../services/isar_db/boards_local_schema.dart';
import '../../theme/colors.dart';

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

  Center notesOptionSheetChild(List<NotesLocal> notes, int index) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "choose what to do for: ",
                  style: StaticData.t.textTheme.headlineSmall?.copyWith(
                    color: popBlack600,
                    fontFamily: 'Cirka',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: Center(
                    child: Text(
                      notes[index].title.toString(),
                      style: StaticData.t.textTheme.displaySmall?.copyWith(
                        color: popBlack500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete_outline_sharp,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    height: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'delete this note',
                          style: StaticData.t.textTheme.bodyMedium?.copyWith(
                            color: popBlack500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'this deletes only the local copy!',
                            style: StaticData.t.textTheme.bodySmall?.copyWith(
                              color: popBlack100,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      NotesIcon.button_arrow_right,
                      size: 8,
                      color: popBlack500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.share_outlined,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    height: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'share this note',
                          style: StaticData.t.textTheme.bodyMedium?.copyWith(
                            color: popBlack500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'share the text unformatted',
                            style: StaticData.t.textTheme.bodySmall?.copyWith(
                              color: popBlack100,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      NotesIcon.button_arrow_right,
                      size: 8,
                      color: popBlack500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    height: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'back-up this note',
                          style: StaticData.t.textTheme.bodyMedium?.copyWith(
                            color: popBlack500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'back up to cloud account',
                            style: StaticData.t.textTheme.bodySmall?.copyWith(
                              color: popBlack100,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      NotesIcon.button_arrow_right,
                      size: 8,
                      color: popBlack500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.save_as_outlined,
                    color: popBlack500,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    height: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'download this note',
                          style: StaticData.t.textTheme.bodyMedium?.copyWith(
                            color: popBlack500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'download the text content',
                            style: StaticData.t.textTheme.bodySmall?.copyWith(
                              color: popBlack100,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 8,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      NotesIcon.button_arrow_right,
                      size: 8,
                      color: popBlack500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 0,
            ),
          ]),
    );
  }
}
