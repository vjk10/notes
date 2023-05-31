import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/views/boards/display_board_view.dart';
import 'package:notes/android/widgets/bottom_sheet.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/firestore_db/user_model.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';
import 'package:rive/rive.dart';

import '../../../data/data.dart';
import '../../widgets/utils.dart';

// ignore: must_be_immutable
class DisplayNoteView extends StatefulWidget {
  final int boardid;
  final Color boardColor;
  final Color boardTextColor;
  final NotesLocal notesLocal;
  final NotesModel notesModel;
  String? notesID;
  DisplayNoteView({
    Key? key,
    required this.boardid,
    required this.notesLocal,
    required this.boardColor,
    required this.boardTextColor,
    required this.notesModel,
    this.notesID,
  }) : super(key: key);

  @override
  State<DisplayNoteView> createState() => _DisplayNoteViewState();
}

class _DisplayNoteViewState extends State<DisplayNoteView> {
  TextEditingController titleController = TextEditingController();
  late final QuillController editorController;
  ScrollController editorScrollController = ScrollController();
  FocusNode editorFocusNode = FocusNode();
  late dynamic noteBody;

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => cloudSaveController?.isActive ?? false;

  Artboard? cloudSaveArtboard;
  StateMachineController? cloudSaveController;
  SMIInput<bool>? isSaving;
  late int prevChangedIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (StaticData.cameSignedIn == true) {
        try {
          titleController.text = widget.notesModel.title!;
        } catch (e) {
          titleController.clear();
        }
      } else {
        titleController.text = widget.notesLocal.title!;
      }
    });
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
    getNoteBody();
    super.initState();
  }

  getNoteBody() {
    if (StaticData.cameSignedIn == true) {
      noteBody = jsonDecode(widget.notesModel.body!);
    } else {
      noteBody = jsonDecode(widget.notesLocal.body!);
    }
    setState(() {
      editorController = QuillController(
          document: Document.fromJson(noteBody),
          selection: const TextSelection.collapsed(offset: 0));
    });
    addListener();
  }

  addListener() {
    editorController.document.changes.listen((event) {
      if (isSaving?.value == false) {
        isSaving?.value = true;
      }
      widget.notesModel.body = jsonEncode(
        editorController.document.toDelta().toJson(),
      );
      widget.notesModel.bodyPlainText = editorController.document.toPlainText();
      UserModelCollectionReference()
          .doc(StaticData.uid)
          .boards
          .doc(widget.notesModel.boardid)
          .notes
          .doc(widget.notesID)
          .set(widget.notesModel)
          .whenComplete(() {
        Future.delayed(const Duration(seconds: 2), () {
          isSaving?.value = false;
        });
      });
    });
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
                    onPressed: () async {
                      HapticFeedback.heavyImpact();
                      if (kDebugMode) {
                        print(
                            "BODY: ${editorController.document.toDelta().toJson()}");
                      }
                      if (titleController.text.isNotEmpty &&
                          StaticData.cameSignedIn == false) {
                        NotesLocal note = NotesLocal();
                        note.id = widget.notesLocal.id;
                        note.title = titleController.text;
                        note.createdby = StaticData.displayname;
                        note.boardid = widget.boardid;
                        note.backedup = false;
                        note.createdon =
                            DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                          DateTime.now(),
                        );
                        note.body = jsonEncode(
                            editorController.document.toDelta().toJson());
                        note.bodyPlainText =
                            editorController.document.toPlainText();
                        var returnStatus = await BoardsLocalServices()
                            .addNote(widget.boardid, note);

                        if (returnStatus == StaticData.successStatus) {
                          Get.off(
                            () => DisplayBoardView(boardid: widget.boardid),
                          );
                        }
                      } else {}
                    },
                    icon: Icon(
                      Icons.save_sharp,
                      color: popWhite500,
                    ),
                    label: Text(
                      'save',
                      style: StaticData.t.textTheme.bodyLarge?.copyWith(
                        color: popWhite500,
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
                          autofocus: false,
                          onEditingComplete: () {
                            isSaving?.value = true;
                            widget.notesModel.title =
                                titleController.text.toString();
                            UserModelCollectionReference()
                                .doc(StaticData.uid)
                                .boards
                                .doc(widget.notesModel.boardid)
                                .notes
                                .doc(widget.notesID)
                                .set(widget.notesModel)
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
                  dialogTheme: QuillDialogTheme(
                    dialogBackgroundColor: popBlack400,
                    labelTextStyle: StaticData.t.textTheme.bodyMedium?.copyWith(
                      color: popWhite500,
                    ),
                  ),
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
                    surface: popWhite400,
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
                    linkActionPickerDelegate: (context, link, node) async {
                      final linkSheet =
                          await showModalBottomSheet<LinkMenuAction>(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        barrierColor: popWhite500.withOpacity(0.0),
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) => NotesBottomSheet(
                              width: Get.width,
                              height: Get.height / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    node.toPlainText(),
                                    style: StaticData.t.textTheme.bodyLarge
                                        ?.copyWith(
                                      color: popBlack600,
                                      fontFamily: 'Cirka',
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: Get.width - 40,
                                    child: Center(
                                      child: LinkPreviewGenerator(
                                        errorBody: 'oops! no preview available',
                                        bodyTextOverflow: TextOverflow.ellipsis,
                                        placeholderWidget: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'loading preview...',
                                              style: StaticData
                                                  .t.textTheme.bodyLarge
                                                  ?.copyWith(
                                                color: popBlack500,
                                                fontFamily: 'Cirka',
                                              ),
                                            ),
                                          ),
                                        ),
                                        showTitle: true,
                                        showDomain: true,
                                        link: link,
                                        graphicFit: BoxFit.fitHeight,
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                        },
                                        linkPreviewStyle:
                                            LinkPreviewStyle.large,
                                        backgroundColor: popBlack500,
                                        borderRadius: 0,
                                        cacheDuration:
                                            const Duration(seconds: 1),
                                        removeElevation: true,
                                        titleStyle: StaticData
                                            .t.textTheme.bodyLarge
                                            ?.copyWith(
                                          color: popWhite500,
                                        ),
                                        bodyStyle: StaticData
                                            .t.textTheme.bodySmall
                                            ?.copyWith(
                                          color: popWhite500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 50,
                                        child: NeoPopButton(
                                          onTapUp: () {
                                            HapticFeedback.heavyImpact();
                                            Navigator.of(context)
                                                .pop(LinkMenuAction.remove);
                                          },
                                          onTapDown: () {
                                            HapticFeedback.heavyImpact();
                                          },
                                          color: error.withOpacity(0.2),
                                          rightShadowColor: error,
                                          bottomShadowColor: error,
                                          grandparentColor: error,
                                          leftShadowColor: error,
                                          border: Border.all(
                                            width: 2,
                                            color: error,
                                          ),
                                          buttonPosition: Position.fullBottom,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                "remove",
                                                maxFontSize: 18,
                                                minFontSize: 14,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.bold,
                                                  color: error,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                LineIcons.minusCircle,
                                                color: error,
                                                size: 14,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110,
                                        height: 50,
                                        child: NeoPopButton(
                                          onTapUp: () {
                                            HapticFeedback.heavyImpact();
                                            Navigator.of(context)
                                                .pop(LinkMenuAction.copy);
                                          },
                                          onTapDown: () {
                                            HapticFeedback.heavyImpact();
                                          },
                                          color: manna100,
                                          rightShadowColor: manna500,
                                          bottomShadowColor: manna500,
                                          grandparentColor: manna500,
                                          leftShadowColor: manna500,
                                          border: Border.all(
                                            width: 2,
                                            color: manna500,
                                          ),
                                          buttonPosition: Position.fullBottom,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                "copy",
                                                maxFontSize: 18,
                                                minFontSize: 14,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.bold,
                                                  color: manna800,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                LineIcons.copy,
                                                color: manna800,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110,
                                        height: 50,
                                        child: NeoPopButton(
                                          onTapUp: () {
                                            HapticFeedback.heavyImpact();
                                            Navigator.of(context)
                                                .pop(LinkMenuAction.launch);
                                          },
                                          onTapDown: () {
                                            HapticFeedback.heavyImpact();
                                          },
                                          color: pakGreen100,
                                          rightShadowColor: pakGreen500,
                                          bottomShadowColor: pakGreen500,
                                          grandparentColor: pakGreen500,
                                          leftShadowColor: pakGreen500,
                                          border: Border.all(
                                            width: 2,
                                            color: pakGreen500,
                                          ),
                                          buttonPosition: Position.fullBottom,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                Utils().getOpenText(link),
                                                maxFontSize: 18,
                                                minFontSize: 14,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.bold,
                                                  color: pakGreen800,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Utils().getOpenIcon(link),
                                                color: pakGreen800,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      return linkSheet ?? LinkMenuAction.none;
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
