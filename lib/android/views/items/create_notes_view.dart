import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:notes/android/widgets/bottom_sheet.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/theme/colors.dart';
import 'package:tuple/tuple.dart';

import '../../../data/data.dart';

class CreateNotesView extends StatefulWidget {
  const CreateNotesView({Key? key}) : super(key: key);

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
              onPressed: () {
                HapticFeedback.heavyImpact();
                if (titleController.text.isEmpty) {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: NotesBottomSheet(),
                      );
                    },
                  );
                }
                if (kDebugMode) {
                  print(
                      "BODY: ${editorController.document.toDelta().toJson()}");
                }
              },
              icon: Icon(
                titleController.text.isEmpty
                    ? Icons.save_as_outlined
                    : Icons.save_outlined,
                color: popWhite500,
              ),
              label: Text(
                titleController.text.isEmpty ? 'save as' : 'save',
                style: StaticData.t.textTheme.bodyLarge,
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
                  customStyles: DefaultStyles(
                    h1: DefaultTextBlockStyle(
                      StaticData.t.textTheme.headlineLarge!,
                      const Tuple2(1, 1.5),
                      const Tuple2(1, 1.5),
                      const BoxDecoration(),
                    ),
                    h2: DefaultTextBlockStyle(
                      StaticData.t.textTheme.headlineMedium!,
                      const Tuple2(1, 1.5),
                      const Tuple2(1, 1.5),
                      const BoxDecoration(),
                    ),
                    h3: DefaultTextBlockStyle(
                      StaticData.t.textTheme.headlineSmall!,
                      const Tuple2(1, 1.5),
                      const Tuple2(1, 1.5),
                      const BoxDecoration(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
