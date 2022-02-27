import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes/android/views/add_folders_view.dart';
import 'package:notes/android/widgets/no_folders_found.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

import '../data/data.dart';

class FoldersView extends StatefulWidget {
  final Future<List<DocumentSnapshot>> foldersFuture;
  const FoldersView({Key? key, required this.foldersFuture}) : super(key: key);

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: FloatingActionButton.large(
          heroTag: "folderTag",
          onPressed: () {
            Get.to(() => const AddFolderView());
          },
          backgroundColor: c.primary,
          child: Center(
            child: Icon(
              UniconsLine.folder_plus,
              color: c.onPrimary,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: widget.foldersFuture,
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> foldersData) {
          switch (foldersData.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(
                  child: NotesLoadingAndroid(),
                );
              }
            case ConnectionState.done:
              {
                switch (foldersData.data!.length) {
                  case 0:
                    {
                      return const NoFoldersFound();
                    }
                  default:
                    {
                      return foldersGrid(foldersData);
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
    );
  }

  Padding foldersGrid(AsyncSnapshot<List<DocumentSnapshot>> foldersData) {
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
          itemCount: foldersData.data?.length,
          itemBuilder: (context, folderIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              child: FocusedMenuHolder(
                onPressed: () {},
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
                    onPressed: () {},
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
                      NotesDatabase()
                          .deleteFolder(foldersData.data![folderIndex].id);
                    },
                  ),
                ],
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            UniconsLine.folder,
                            color: c.tertiary,
                            size: 80,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            foldersData.data![folderIndex].data["title"]
                                .toString(),
                            style: t.textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (foldersData.data![folderIndex].data["description"]
                              .toString()
                              .isNotEmpty)
                            Text(foldersData
                                .data![folderIndex].data["description"]
                                .toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Created on: " +
                                foldersData
                                    .data![folderIndex].data["creationTime"]
                                    .toString(),
                            style: t.textTheme.caption,
                          ),
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
