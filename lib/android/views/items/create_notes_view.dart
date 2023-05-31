import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/views/boards/display_board_view.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/firestore_db/boards_services.dart';
import 'package:notes/services/firestore_db/user_model.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';
import 'package:rive/rive.dart';

import '../../../data/data.dart';

class CreateNotesView extends StatefulWidget {
  final int boardid;
  final String boardidFb;
  final Color boardColor;
  final Color boardTextColor;
  final String boardname;
  const CreateNotesView(
      {Key? key,
      required this.boardid,
      required this.boardidFb,
      required this.boardColor,
      required this.boardTextColor,
      required this.boardname})
      : super(key: key);

  @override
  State<CreateNotesView> createState() => _CreateNotesViewState();
}

class _CreateNotesViewState extends State<CreateNotesView> {
  TextEditingController titleController = TextEditingController();
  final QuillController editorController = QuillController.basic();
  ScrollController editorScrollController = ScrollController();
  FocusNode editorFocusNode = FocusNode();

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => cloudSaveController?.isActive ?? false;

  Artboard? cloudSaveArtboard;
  StateMachineController? cloudSaveController;
  SMIInput<bool>? isSaving;
  late NotesModel notesModel;
  late String notesID;

  @override
  void initState() {
    if (StaticData.cameSignedIn) {
      addToBoard();
    }
    super.initState();
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/lottie/cloud_save.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          isSaving = controller.findInput('Saving');
        }
        setState(() => cloudSaveArtboard = artboard);
      },
    );
  }

  addToBoard() async {
    notesModel = NotesModel(
      createdby: StaticData.displayname,
      createdon: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
        DateTime.now(),
      ),
      backedup: true,
      boardid: widget.boardidFb,
      boardname: widget.boardname,
      body: jsonEncode(
        editorController.document.toDelta().toJson(),
      ),
      bodyPlainText: editorController.document.toPlainText(),
    );
    isSaving?.value = true;
    await BoardsOnlineService()
        .addNoteToBoard(StaticData.uid, widget.boardidFb, notesModel)
        .then((value) {
      notesID = value.message.toString();
      if (kDebugMode) {
        print("Notes ID: $notesID");
      }
      setState(() {
        isSaving?.value = false;
      });
      addListener();
    });
  }

  addListener() {
    editorController.document.changes.listen((event) {
      if (isSaving?.value == false) {
        isSaving?.value = true;
      }
      notesModel.body = jsonEncode(
        editorController.document.toDelta().toJson(),
      );
      notesModel.bodyPlainText = editorController.document.toPlainText();
      UserModelCollectionReference()
          .doc(StaticData.uid)
          .boards
          .doc(notesModel.boardid)
          .notes
          .doc(notesID)
          .set(notesModel)
          .whenComplete(() {
        Future.delayed(const Duration(seconds: 2), () {
          isSaving?.value = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(
          () => DisplayBoardView(
            boardid: StaticData.cameSignedIn ? 0 : widget.boardid,
            boardidFb: StaticData.cameSignedIn ? widget.boardidFb : "null",
          ),
        );
        return true;
      },
      child: Scaffold(
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
              StaticData.cameSignedIn
                  ? SizedBox(
                      height: 60,
                      width: 60,
                      child: cloudSaveArtboard == null
                          ? const SizedBox(
                              width: 10,
                            )
                          : Rive(
                              artboard: cloudSaveArtboard!,
                            ),
                    )
                  : TextButton.icon(
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
                                    DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                                        .format(
                                  DateTime.now(),
                                );
                                note.body = jsonEncode(
                                  editorController.document.toDelta().toJson(),
                                );
                                note.bodyPlainText =
                                    editorController.document.toPlainText();
                                if (StaticData.cameSignedIn == true) {
                                } else {
                                  var returnStatus = await BoardsLocalServices()
                                      .addNote(widget.boardid, note);

                                  if (returnStatus ==
                                      StaticData.successStatus) {
                                    Get.off(() => DisplayBoardView(
                                        boardid: widget.boardid));
                                  }
                                }
                              }
                            },
                      icon: Icon(
                        titleController.text.isEmpty
                            ? Icons.disabled_by_default_sharp
                            : Icons.save_sharp,
                        color:
                            titleController.text.isEmpty ? grey : popWhite500,
                      ),
                      label: Text(
                        'save',
                        style: StaticData.t.textTheme.bodyLarge?.copyWith(
                          color:
                              titleController.text.isEmpty ? grey : popWhite500,
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
                            onEditingComplete: () {
                              isSaving?.value = true;
                              notesModel.title =
                                  titleController.text.toString();
                              UserModelCollectionReference()
                                  .doc(StaticData.uid)
                                  .boards
                                  .doc(widget.boardidFb)
                                  .notes
                                  .doc(notesID)
                                  .set(notesModel)
                                  .whenComplete(() {
                                isSaving?.value = false;
                              });
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
                    color: popBlack500,
                    iconTheme: QuillIconTheme(
                      iconSelectedColor: widget.boardTextColor,
                      iconSelectedFillColor: widget.boardColor,
                    ),
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
          )),
    );
  }
}
