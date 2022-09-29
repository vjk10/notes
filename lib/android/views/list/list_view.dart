import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/note_list_model.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../data/data.dart';

class ListviewView extends StatefulWidget {
  final String noteId;
  const ListviewView({Key? key, required this.noteId}) : super(key: key);

  @override
  State<ListviewView> createState() => _ListviewViewState();
}

class _ListviewViewState extends State<ListviewView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  int currentIndex = 0;
  late Note note;
  List<int> rows = [];
  List<bool> checked = [];
  List<TextEditingController> controllers = [];
  List<NoteListItem> noteListItems = [];
  List<ListTile> listItems = [];

  bool pinned = false;
  int totalItems = 0;
  late DocumentSnapshot noteSnapshot;
  List<DocumentSnapshot> listSnapshot = [];
  List<CollectionReference> collectionSnapshot = [];
  bool _saved = false;

  late String title, body;
  @override
  void initState() {
    refreshNote();
    // rows.length = currentIndex;
    super.initState();
  }

  refreshNote() async {
    if (kDebugMode) {
      print("NOTE ID: ${widget.noteId}");
    }
    noteSnapshot = await ScientISSTdb.instance
        .collection("notes")
        .document(widget.noteId)
        .get();
    setState(() {
      titleController.text = noteSnapshot.data["title"].toString();
      bodyController.text = noteSnapshot.data["body"].toString();
      totalItems = noteSnapshot.data["totalItems"];
      pinned = noteSnapshot.data["pinned"] as bool;
    });
    for (var c = 0; c < totalItems; c++) {
      DocumentSnapshot collectionSnapshot = await ScientISSTdb.instance
          .collection("notes")
          .document(widget.noteId)
          .collection(c.toString())
          .document(c.toString())
          .get();
      if (kDebugMode) {
        print(collectionSnapshot.data["text"].toString());
      }
      setState(() {
        NoteListItem item = NoteListItem(
            text: collectionSnapshot.data["text"].toString(),
            index: collectionSnapshot.data["index"],
            checked: collectionSnapshot.data["checked"]);
        controllers.add(TextEditingController(
            text: collectionSnapshot.data["text"].toString()));
        noteListItems.add(item);
        currentIndex = currentIndex + 1;
      });
    }
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
        bool autosave = await NotesDatabase().checkAutoSave();
        if (autosave) {
          if (noteListItems.isNotEmpty) {
            await NotesDatabase().updateList(
              titleController,
              controllers,
              pinned,
              noteListItems,
              widget.noteId,
            );
          }
        }
        Get.back();

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: c.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: c.background,
          toolbarHeight: 80,
          leading: IconButton(
              onPressed: () async {
                bool autosave = await NotesDatabase().checkAutoSave();
                if (autosave) {
                  if (noteListItems.isNotEmpty) {
                    await NotesDatabase().updateList(
                      titleController,
                      controllers,
                      pinned,
                      noteListItems,
                      widget.noteId,
                    );
                  }
                }
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: c.onBackground,
              )),
          title: Text(
            "notes",
            style: t.textTheme.headline6,
          ),
          bottom: PreferredSize(
            preferredSize: Size(Get.width, 70),
            child: TextFormField(
              controller: titleController,
              style: t.textTheme.headline4,
              onChanged: (value) {
                setState(() {
                  _saved = false;
                  title = value.toString();
                });
              },
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "title",
                hintStyle: t.textTheme.headline4,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                onPressed: () async {
                  if (!_saved) {
                    await NotesDatabase()
                        .updateList(
                      titleController,
                      controllers,
                      pinned,
                      noteListItems,
                      widget.noteId,
                    )
                        .whenComplete(() {
                      setState(() {
                        _saved = true;
                      });
                    });
                  }
                },
                icon: Icon(
                  Icons.save_outlined,
                  color: c.onBackground,
                  size: 24,
                ),
                label: Text(
                  "Save",
                  style: t.textTheme.button?.copyWith(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReorderableListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  setState(() {
                    final index = newIndex;
                    final itemInDrag = noteListItems.removeAt(oldIndex);
                    final controllerDrag = controllers.removeAt(oldIndex);
                    noteListItems.insert(index, itemInDrag);
                    controllers.insert(index, controllerDrag);
                  });
                },
                shrinkWrap: true,
                itemCount: noteListItems.length,
                itemBuilder: (context, index) {
                  if (kDebugMode) {
                    print("List Length : ${noteListItems.length}");
                    print("List Text : ${noteListItems[index].text}");
                  }
                  if (noteListItems.isNotEmpty) {
                    final item = noteListItems.elementAt(index);
                    return buildItem(item, index);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 6),
                child: TextButton.icon(
                  onPressed: () {
                    NoteListItem item = NoteListItem(
                        index: currentIndex, text: "", checked: false);
                    noteListItems.add(item);
                    setState(() {
                      controllers.add(TextEditingController());
                      currentIndex = currentIndex + 1;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: c.outline,
                    size: 20,
                  ),
                  label: Text(
                    "Add Item",
                    style: t.textTheme.button?.copyWith(
                      color: c.outline,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(NoteListItem item, int index) {
    return ListTile(
      key: ValueKey(item),
      leading: Icon(Icons.drag_indicator_outlined, color: c.outline),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _saved = false;
                item.checked = !item.checked;
              });
            },
            child: Icon(
              item.checked ? Icons.check_circle : Icons.circle_outlined,
              color: item.checked ? c.primary : c.outline,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              controller: controllers[index],
              onChanged: (value) {
                setState(() {
                  _saved = false;
                  item.text = controllers[index].text;
                });
              },
              style: t.textTheme.bodyMedium,
              decoration: InputDecoration(
                  hintText: "list item",
                  hintStyle: t.textTheme.bodyMedium?.copyWith(
                    color: c.outline,
                  ),
                  fillColor: Colors.transparent,
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none),
            ),
          ),
        ],
      ),
      subtitle: Visibility(
        visible: false,
        child: Text(
          item.text.toString(),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print(item);
          }
          setState(() {
            _saved = false;
            noteListItems.removeAt(index);
            controllers.removeAt(index);
          });
        },
        child: Icon(
          Icons.close,
          color: c.outline,
        ),
      ),
    );
  }
}
