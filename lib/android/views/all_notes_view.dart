import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/views/add_notes_view.dart';
import 'package:notes/android/views/note_page.dart';
import 'package:notes/android/widgets/no_notes_found.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';

class AllNotesView extends StatefulWidget {
  final Future<List<DocumentSnapshot>> notesFuture;
  const AllNotesView({
    Key? key,
    required this.notesFuture,
  }) : super(key: key);

  @override
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  bool isLoading = false;
  final bool _accountsLinked = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("ALL NOTES INIT STATE");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: FloatingActionButton.large(
          heroTag: "addNoteTag",
          onPressed: () {
            Get.to(() => const AddNoteView());
          },
          backgroundColor: c.primary,
          child: Center(
            child: Icon(
              UniconsLine.file_plus_alt,
              color: c.onPrimary,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: widget.notesFuture,
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> notesData) {
            switch (notesData.connectionState) {
              case ConnectionState.waiting:
                {
                  return const Center(
                    child: NotesLoadingAndroid(),
                  );
                }
              case ConnectionState.done:
                {
                  switch (notesData.data!.length) {
                    case 0:
                      {
                        return const NoNotesFound();
                      }
                    default:
                      {
                        return notesGrid(notesData);
                      }
                  }
                }
              default:
                {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: c.onBackground.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation(c.onBackground),
                    ),
                  );
                }
            }
          }),
    );
  }

  Padding notesGrid(AsyncSnapshot<List<DocumentSnapshot>> notesData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          itemCount: notesData.data?.length,
          itemBuilder: (context, noteIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              child: FocusedMenuHolder(
                onPressed: () {
                  Get.to(
                    () => NotePage(noteId: notesData.data![noteIndex].id),
                  );
                },
                menuWidth: Get.width * 0.50,
                blurSize: 5.0,
                menuItemExtent: 45,
                menuBoxDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                duration: const Duration(milliseconds: 400),
                animateMenuItems: true,
                blurBackgroundColor: c.background.withOpacity(0.2),
                openWithTap:
                    false, // Open Focused-Menu on Tap rather than Long Press
                menuOffset:
                    10.0, // Offset value to show menuItem from the selected item
                bottomOffsetHeight:
                    80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
                menuItems: <FocusedMenuItem>[
                  // Add Each FocusedMenuItem  for Menu Options
                  if (_accountsLinked)
                    FocusedMenuItem(
                      backgroundColor: c.surface,
                      title: Text(
                        "Back Up",
                        style: t.textTheme.button?.copyWith(
                          color: c.tertiary,
                          fontSize: 12,
                        ),
                      ),
                      trailingIcon: Icon(
                        UniconsLine.cloud_upload,
                        color: c.tertiary,
                      ),
                      onPressed: () {},
                    ),
                  FocusedMenuItem(
                    backgroundColor: c.surface,
                    title: Text(
                      "Share",
                      style: t.textTheme.button?.copyWith(
                        color: c.tertiary,
                        fontSize: 12,
                      ),
                    ),
                    trailingIcon: Icon(
                      UniconsLine.share,
                      color: c.tertiary,
                    ),
                    onPressed: () {
                      Share.share(
                        "*" +
                            notesData.data![noteIndex].data["title"]
                                .toString() +
                            "*" +
                            "\n\n" +
                            notesData.data![noteIndex].data["body"].toString(),
                      );
                    },
                  ),
                  FocusedMenuItem(
                    backgroundColor: c.surface,
                    title: Text(
                      "Delete",
                      style: t.textTheme.button?.copyWith(
                        color: c.tertiary,
                        fontSize: 12,
                      ),
                    ),
                    trailingIcon: Icon(
                      UniconsLine.trash,
                      color: c.tertiary,
                    ),
                    onPressed: () {
                      NotesDatabase().deleteNote(notesData.data![noteIndex].id);
                    },
                  ),
                ],
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => NotePage(noteId: notesData.data![noteIndex].id),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            notesData.data![noteIndex].data["title"].toString(),
                            style: t.textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(notesData.data![noteIndex].data["body"]
                              .toString())
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
