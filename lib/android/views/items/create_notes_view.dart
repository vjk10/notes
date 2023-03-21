import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/views/boards/display_board_view.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';

import '../../../data/data.dart';

class CreateNotesView extends StatefulWidget {
  final int boardid;
  const CreateNotesView({Key? key, required this.boardid}) : super(key: key);

  @override
  State<CreateNotesView> createState() => _CreateNotesViewState();
}

class _CreateNotesViewState extends State<CreateNotesView> {
  TextEditingController titleController = TextEditingController();
  final QuillController editorController = QuillController.basic();
  ScrollController editorScrollController = ScrollController();
  FocusNode editorFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            "back",
            style: StaticData.t.textTheme.headlineSmall?.copyWith(
              color: popWhite500,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              NotesIcon.button_arrow_left,
              size: 12,
              color: popWhite500,
            ),
            color: StaticData.c.primary,
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            TextButton.icon(
              onPressed: titleController.text.isEmpty
                  ? null
                  : () async {
                      HapticFeedback.heavyImpact();
                      if (kDebugMode) {
                        print(
                            "BODY: ${editorController.document.toDelta().toJson()}");
                      }
                      if (titleController.text.isNotEmpty) {
                        NotesLocal note = NotesLocal();
                        note.title = titleController.text;
                        note.createdby = StaticData.displayname;
                        note.boardid = widget.boardid;
                        note.backedup = false;
                        note.createdon =
                            DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                          DateTime.now(),
                        );
                        note.body = jsonEncode(
                          editorController.document.toDelta().toJson(),
                        );
                        note.bodyPlainText =
                            editorController.document.toPlainText();
                        var returnStatus = await BoardsLocalServices()
                            .addNote(widget.boardid, note);

                        if (returnStatus == StaticData.successStatus) {
                          Get.off(
                              () => DisplayBoardView(boardid: widget.boardid));
                        }
                      }
                    },
              icon: Icon(
                titleController.text.isEmpty
                    ? Icons.disabled_by_default_sharp
                    : Icons.save_sharp,
                color: titleController.text.isEmpty ? grey : popWhite500,
              ),
              label: Text(
                'save',
                style: StaticData.t.textTheme.bodyLarge?.copyWith(
                  color: titleController.text.isEmpty ? grey : popWhite500,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(180),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        width: Get.width - 20,
                        height: 50,
                        child: TextFormField(
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: titleController,
                          style: StaticData.t.textTheme.headlineMedium
                              ?.copyWith(fontFamily: 'Cirka'),
                          decoration: InputDecoration(
                            hintText: 'give your note a title',
                            hintStyle: StaticData.t.textTheme.headlineMedium
                                ?.copyWith(fontFamily: 'Cirka'),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width - 30,
                  child: Divider(
                    color: popWhite400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                QuillToolbar.basic(
                  controller: editorController,
                  axis: Axis.horizontal,
                  multiRowsDisplay: false,
                  showFontFamily: false,
                  showFontSize: false,
                  dialogTheme:
                      QuillDialogTheme(dialogBackgroundColor: popBlack400),
                  afterButtonPressed: () {
                    HapticFeedback.heavyImpact();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width - 30,
                  child: Divider(
                    color: popWhite400,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  colorScheme: StaticData.c.copyWith(
                    surface: popWhite400, //Fix for Issue #79
                  ),
                ),
                child: SizedBox(
                  height: double.infinity,
                  width: Get.width,
                  child: QuillEditor(
                    controller: editorController,
                    scrollController: editorScrollController,
                    focusNode: editorFocusNode,
                    scrollable: true,
                    padding: const EdgeInsets.all(20),
                    autoFocus: false,
                    expands: true,
                    readOnly: false,
                    textCapitalization: TextCapitalization.none,
                    enableInteractiveSelection: true,
                    placeholder: 'on a galaxy far far away...',
                    customStyles: StaticData.quillDefaultTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
