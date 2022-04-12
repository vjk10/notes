import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/views/list/list_view.dart';
import 'package:notes/android/views/notes/note_page.dart';
import 'package:notes/android/widgets/no_notes_found.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:share_plus/share_plus.dart';

class FolderView extends StatefulWidget {
  final String folderName;
  const FolderView({Key? key, required this.folderName}) : super(key: key);

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  final bool _accountsLinked = false;
  late Future<List<DocumentSnapshot>> folderNotesFuture;

  @override
  void initState() {
    folderNotesSnapshot = [];
    folderNotesFuture = NotesDatabase().getFolderNotes(widget.folderName);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const MainScreen(selectedIndex: 1));
        return true;
      },
      child: Scaffold(
        backgroundColor: c.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: c.secondaryContainer.withAlpha(50),
          title: Text(
            "/ " + widget.folderName,
            style: t.textTheme.headline5,
          ),
          leading: IconButton(
            onPressed: () async {
              Get.offAll(() => const MainScreen(selectedIndex: 1));
            },
            icon: Icon(
              Icons.arrow_back,
              color: c.onBackground,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: FutureBuilder(
          future: folderNotesFuture,
          builder:
              (context, AsyncSnapshot<List<DocumentSnapshot>> folderNotesData) {
            switch (folderNotesData.connectionState) {
              case ConnectionState.waiting:
                {
                  return const Center(
                    child: NotesLoadingAndroid(),
                  );
                }
              case ConnectionState.done:
                {
                  if (kDebugMode) {
                    print("LENGTH: " + folderNotesData.data!.length.toString());
                  }
                  switch (folderNotesData.data!.length) {
                    case 0:
                      {
                        return const NoNotesFound();
                      }
                    default:
                      {
                        return notesGrid(folderNotesData);
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
          },
        ),
      ),
    );
  }

  Padding notesGrid(AsyncSnapshot<List<DocumentSnapshot>> folderNotesData) {
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
          itemCount: folderNotesData.data?.length,
          itemBuilder: (context, noteIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              child: FocusedMenuHolder(
                onPressed: () {
                  // Get.to(
                  //   () => NotePage(noteId: folderNotesData.data![noteIndex].id),
                  // );
                  if (kDebugMode) {
                    print(folderNotesData.data![noteIndex].data["isList"] ==
                        true);
                  }
                  if (folderNotesData.data![noteIndex].data["isList"] == true) {
                    Get.to(
                      () => ListviewView(
                          noteId: folderNotesData.data![noteIndex].id),
                    );
                  } else {
                    Get.to(
                      () =>
                          NotePage(noteId: folderNotesData.data![noteIndex].id),
                    );
                  }
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
                        Icons.cloud_upload,
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
                      Icons.share,
                      color: c.tertiary,
                    ),
                    onPressed: () {
                      Share.share(
                        "*" +
                            folderNotesData.data![noteIndex].data["title"]
                                .toString() +
                            "*" +
                            "\n\n" +
                            folderNotesData.data![noteIndex].data["body"]
                                .toString(),
                      );
                    },
                  ),
                  FocusedMenuItem(
                    backgroundColor: c.surface,
                    title: Text(
                      "Delete from Folder",
                      style: t.textTheme.button?.copyWith(
                        color: c.tertiary,
                        fontSize: 12,
                      ),
                    ),
                    trailingIcon: Icon(
                      Icons.delete,
                      color: c.tertiary,
                    ),
                    onPressed: () {
                      NotesDatabase().deleteFromFolder(widget.folderName,
                          folderNotesData.data![noteIndex].id);
                    },
                  ),
                ],
                child: GestureDetector(
                  onTap: () {
                    // Get.to(
                    //   () =>
                    //       NotePage(noteId: folderNotesData.data![noteIndex].id),
                    // );
                    if (kDebugMode) {
                      print(folderNotesData.data![noteIndex].data["isList"] ==
                          true);
                    }
                    if (folderNotesData.data![noteIndex].data["isList"] ==
                        true) {
                      Get.to(
                        () => ListviewView(
                            noteId: folderNotesData.data![noteIndex].id),
                      );
                    } else {
                      Get.to(
                        () => NotePage(
                            noteId: folderNotesData.data![noteIndex].id),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: c.secondaryContainer,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            folderNotesData.data![noteIndex].data["title"]
                                .toString(),
                            style: t.textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(folderNotesData.data![noteIndex].data["body"]
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
