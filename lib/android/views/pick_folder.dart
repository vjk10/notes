import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/theme/colors.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../data/data.dart';

class PickFolder extends StatefulWidget {
  final Future<List<DocumentSnapshot>> foldersFuture;
  final String noteId, noteTitle, noteBody;
  const PickFolder({
    Key? key,
    required this.foldersFuture,
    required this.noteId,
    required this.noteTitle,
    required this.noteBody,
  }) : super(key: key);

  @override
  State<PickFolder> createState() => _PickFolderState();
}

class _PickFolderState extends State<PickFolder> {
  int selectedIndex = -1;
  late String folderName = "";
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: c.secondaryContainer.withAlpha(50),
        automaticallyImplyLeading: false,
        title: Text(
          "select folder",
          style: t.textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: widget.foldersFuture,
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> foldersData) {
          switch (foldersData.connectionState) {
            case ConnectionState.waiting:
              {
                return const NotesLoadingAndroid();
              }
            case ConnectionState.done:
              {
                switch (foldersData.data?.length) {
                  case 0:
                    {
                      return Text(
                        "No folders",
                        textAlign: TextAlign.center,
                        style: t.textTheme.bodyText1?.copyWith(
                          color: c.onSurface,
                        ),
                      );
                    }

                  default:
                    {
                      return foldersGrid(foldersData);
                    }
                }
              }
            default:
              {
                return const NotesLoadingAndroid();
              }
          }
        },
      ),
      bottomNavigationBar: Container(
        color: c.secondaryContainer.withAlpha(50),
        width: Get.width,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: selectedIndex.isNegative ? c.secondary : c.primary,
                onPrimary: c.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: selectedIndex.isNegative
                  ? null
                  : () {
                      NotesDatabase().addToFolder(folderName, widget.noteId,
                          widget.noteTitle, widget.noteBody);
                    },
              child: Text(
                "Add to Folder",
                style: t.textTheme.button?.copyWith(
                  color: selectedIndex.isNegative ? grey : c.onPrimary,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Get.offAllNamed('/mainScreen');
              },
              child: Text(
                "Cancel",
                style: t.textTheme.button?.copyWith(
                  color: c.onBackground,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
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
              child: GestureDetector(
                onTap: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = folderIndex;
                      folderName = foldersData.data![folderIndex].data["title"]
                          .toString();
                    });
                  } else {
                    setState(() {
                      selectedIndex = -1;
                      folderName = "";
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: folderIndex == selectedIndex
                            ? c.primary
                            : c.surface,
                        width: folderIndex == selectedIndex ? 2 : 0,
                      ),
                      color: c.secondaryContainer,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder,
                          color: c.tertiary,
                          size: 80,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          foldersData.data![folderIndex].data["title"]
                              .toString(),
                          textAlign: TextAlign.center,
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
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              color: c.secondary,
                              size: 10,
                            ),
                            Text(
                              foldersData
                                  .data![folderIndex].data["creationTime"]
                                  .toString(),
                              style: t.textTheme.caption
                                  ?.copyWith(color: c.secondary, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
