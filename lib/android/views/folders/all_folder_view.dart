import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes/android/views/folders/add_folders_view.dart';
import 'package:notes/android/views/folders/folder_view.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../data/data.dart';
import '../../screens/settings_screen.dart';

class AllFoldersView extends StatefulWidget {
  const AllFoldersView({Key? key}) : super(key: key);

  @override
  State<AllFoldersView> createState() => _AllFoldersViewState();
}

class _AllFoldersViewState extends State<AllFoldersView> {
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: c.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            heroTag: "folderTag",
            onPressed: () {
              Get.bottomSheet(
                SizedBox(
                  height: Get.height / 2,
                  child: const AddFolderView(),
                ),
                elevation: 10,
                enableDrag: true,
                isScrollControlled: true,
              );
            },
            backgroundColor: c.primaryContainer,
            child: Center(
              child: Icon(
                Icons.create_new_folder_outlined,
                color: c.onPrimaryContainer,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: c.background,
          toolbarHeight: 80,
          title: const Text('folders'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
              icon: Icon(
                Icons.settings_outlined,
                color: c.onSurface,
              ),
            )
          ],
        ),
        body: StreamBuilder<List<DocumentSnapshot>>(
          stream: ScientISSTdb.instance.collection("folders").watchDocuments(),
          builder:
              ((context, AsyncSnapshot<List<DocumentSnapshot>> folderSnapshot) {
            switch (folderSnapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return const Center(
                    child: NotesLoadingAndroid(),
                  );
                }
              case ConnectionState.done:
                {
                  switch (folderSnapshot.data!.length) {
                    case 0:
                      {
                        return const SizedBox();
                      }
                    default:
                      {
                        return foldersGrid(folderSnapshot);
                      }
                  }
                }
              default:
                {
                  switch (folderSnapshot.data!.length) {
                    case 0:
                      {
                        return const SizedBox();
                      }
                    default:
                      {
                        return foldersGrid(folderSnapshot);
                      }
                  }
                }
            }
          }),
        ),
      );
    });
  }

  CustomScrollView foldersGrid(
      AsyncSnapshot<List<DocumentSnapshot>> foldersData) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, folderIndex) {
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
                    FocusedMenuItem(
                      backgroundColor: c.secondaryContainer,
                      title: Text(
                        "Delete",
                        style: t.textTheme.button?.copyWith(
                          color: c.onSecondaryContainer,
                          fontSize: 12,
                        ),
                      ),
                      trailingIcon: Icon(
                        Icons.delete_outlined,
                        color: c.onSecondaryContainer,
                      ),
                      onPressed: () {
                        NotesDatabase()
                            .deleteFolder(foldersData.data![folderIndex].id);
                      },
                    ),
                  ],
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => FolderView(
                          folderName: foldersData
                              .data![folderIndex].data["title"]
                              .toString(),
                        ),
                      );
                    },
                    child: Card(
                      color: c.surfaceVariant,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        leading: Icon(
                          Icons.folder_open_rounded,
                          color: c.onBackground,
                        ),
                        title: Text(
                          foldersData.data![folderIndex].data["title"]
                              .toString(),
                          textAlign: TextAlign.start,
                          style: t.textTheme.headline6,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            foldersData.data![folderIndex].data["description"]
                                .toString(),
                            style: t.textTheme.subtitle1?.copyWith(
                              color: c.onSecondaryContainer,
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.schedule_outlined,
                                color: c.secondary,
                                size: 10,
                              ),
                              Text(
                                foldersData
                                    .data![folderIndex].data["creationTime"]
                                    .toString(),
                                style: t.textTheme.caption?.copyWith(
                                    color: c.secondary, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: foldersData.data!.length,
          ),
        )
      ],
    );
  }
}
