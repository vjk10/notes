import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/note_list_model.dart';
import 'package:notes/services/db/notes_model.dart';

class AddListView extends StatefulWidget {
  const AddListView({Key? key}) : super(key: key);

  @override
  State<AddListView> createState() => _AddListViewState();
}

class _AddListViewState extends State<AddListView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  int currentIndex = 0;
  late Note note;
  List<int> rows = [];
  List<bool> checked = [];
  List<NoteListItem> noteListItems = [];
  List<ListTile> listItems = [];
  List<TextEditingController> controllers = [];

  late String title, body;
  @override
  void initState() {
    noteListItems.length = currentIndex;
    NoteListItem item =
        NoteListItem(index: currentIndex, text: "List Item", checked: false);
    noteListItems.insert(0, item);
    controllers.add(TextEditingController());
    currentIndex = noteListItems.length;
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
        bool _autosave = await NotesDatabase().checkAutoSave();
        if (_autosave) {
          if (noteListItems.isNotEmpty && titleController.text.isNotEmpty) {
            await NotesDatabase()
                .saveList(titleController, controllers, false, noteListItems);
          }
        }
        Get.offAllNamed('/mainScreen');
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
                bool _autosave = await NotesDatabase().checkAutoSave();
                if (_autosave) {
                  if (noteListItems.isNotEmpty &&
                      titleController.text.isNotEmpty) {
                    await NotesDatabase().saveList(
                        titleController, controllers, false, noteListItems);
                  }
                }
                Get.offAllNamed('/mainScreen');
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
                hintText: "Title",
                hintStyle: t.textTheme.headline4,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                onPressed: () async {
                  await NotesDatabase()
                      .saveList(
                          titleController, controllers, false, noteListItems)
                      .whenComplete(() {
                    Get.offAllNamed('/mainScreen');
                  });
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
                    final _index = newIndex;
                    final _itemInDrag = noteListItems.removeAt(oldIndex);
                    final _controllerDrag = controllers.removeAt(oldIndex);
                    noteListItems.insert(_index, _itemInDrag);
                    controllers.insert(_index, _controllerDrag);
                  });
                },
                shrinkWrap: true,
                itemCount: noteListItems.length,
                itemBuilder: (context, index) {
                  if (kDebugMode) {
                    print("List Length : " + noteListItems.length.toString());
                    print(
                        "List Text : " + noteListItems[index].text.toString());
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
                item.checked = !item.checked;
              });
            },
            child: Icon(
              item.checked
                  ? Icons.check_box
                  : Icons.check_box_outline_blank_outlined,
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
                  item.text = controllers[index].text;
                });
              },
              style: t.textTheme.bodyMedium,
              decoration: InputDecoration(
                  hintText: "List Item",
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
