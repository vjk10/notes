import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:notes/android/screens/main_screen.dart';
import 'package:notes/android/widgets/notes_snackbar.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';
import 'package:scrollable/exports.dart';

import '../../../data/data.dart';

class CreateBoardView extends StatefulWidget {
  const CreateBoardView({Key? key}) : super(key: key);

  @override
  State<CreateBoardView> createState() => _CreateBoardViewState();
}

class _CreateBoardViewState extends State<CreateBoardView> {
  Color selectedColor = popWhite500;
  Color selectedTextColor = popBlack500;
  int selectedColorValue = 0;
  int selectedTextColorValue = 0;
  bool buttonEnabled = false;
  TextEditingController boardnamecontroller = TextEditingController();
  TextEditingController createdbycontroller = TextEditingController();

  ScrollController boardscolorScrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    setState(() {
      createdbycontroller.text = StaticData.displayname.split(' ')[0];
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
      boardscolorScrollController.animateTo(
        boardscolorScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
      if (kDebugMode) {
        print("Build Completed");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          title: Text(
            "back",
            style: StaticData.t.textTheme.headlineSmall?.copyWith(
              fontFamily: 'Cirka',
            ),
          ),
          leading: IconButton(
            icon: Icon(
              NotesIcon.button_arrow_left,
              size: 12,
              color: StaticData.c.primary,
            ),
            color: StaticData.c.primary,
            onPressed: () {
              Get.back();
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "create board",
                    textAlign: TextAlign.start,
                    style: StaticData.t.textTheme.headlineMedium?.copyWith(
                      color: popWhite500,
                      fontFamily: 'Cirka',
                    ),
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: popBlack600,
          surfaceTintColor: popBlack600,
        ),
        body: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: boardnamecontroller,
                        onEditingComplete: () {
                          if (boardnamecontroller.text.isNotEmpty) {
                            setState(() {
                              buttonEnabled = true;
                            });
                          } else {
                            setState(() {
                              buttonEnabled = false;
                            });
                          }
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        style: StaticData.t.textTheme.labelLarge?.copyWith(
                          color: popWhite500,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'board name',
                                  style: StaticData.t.textTheme.labelLarge
                                      ?.copyWith(
                                    color: popWhite500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '  *',
                                      style: StaticData.t.textTheme.labelLarge
                                          ?.copyWith(
                                        color: error,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'eg: my tasks',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        style: StaticData.t.textTheme.labelLarge?.copyWith(
                          color: popWhite500,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        controller: createdbycontroller,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'created by',
                                  style: StaticData.t.textTheme.labelLarge
                                      ?.copyWith(
                                    color: popWhite500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '  *',
                                      style: StaticData.t.textTheme.labelLarge
                                          ?.copyWith(
                                        color: error,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'john doe',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'board color',
                              style:
                                  StaticData.t.textTheme.labelLarge?.copyWith(
                                color: popWhite500,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: '  *',
                                  style: StaticData.t.textTheme.labelLarge
                                      ?.copyWith(
                                    color: error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 150,
                      child: ScrollHaptics(
                        hapticEffectAtEdge: HapticType.heavy,
                        hapticEffectDuringScroll: HapticType.selection,
                        child: GridView.builder(
                          controller: boardscolorScrollController,
                          dragStartBehavior: DragStartBehavior.down,
                          shrinkWrap: true,
                          itemCount: StaticData.boardcolors.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, mainAxisExtent: 150),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = StaticData
                                          .boardcolors[index]["color"];
                                      selectedTextColor = StaticData
                                          .boardcolors[index]["textcolor"];
                                      selectedColorValue = StaticData
                                          .boardcolors[index]["value"];
                                      selectedTextColorValue = StaticData
                                          .boardcolors[index]["textvalue"];
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: popWhite500,
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  selectedColor ==
                                                          StaticData
                                                                  .boardcolors[
                                                              index]["color"]
                                                      ? 0
                                                      : 8.0),
                                              child: Container(
                                                width: 90,
                                                height: 90,
                                                color: StaticData
                                                        .boardcolors[index]
                                                    ["color"],
                                              ),
                                            ),
                                          ),
                                          if (selectedColor ==
                                              StaticData.boardcolors[index]
                                                  ["color"])
                                            Icon(
                                              Icons.check_box_sharp,
                                              color:
                                                  StaticData.boardcolors[index]
                                                      ["textcolor"],
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        StaticData.boardcolors[index]["text"],
                                        style: StaticData.t.textTheme.labelLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Hero(
                        tag: StaticData.mainButtonTag,
                        child: SizedBox(
                          width: 189,
                          height: 48,
                          child: NeoPopButton(
                            color: selectedColor,
                            animationDuration:
                                const Duration(milliseconds: 250),
                            onTapDown: () => HapticFeedback.vibrate(),
                            onTapUp: () async {
                              if (boardnamecontroller.text.isEmpty ||
                                  createdbycontroller.text.isEmpty ||
                                  selectedColor == popWhite500) {
                                NotesSnackBar().errorSnackBar(
                                    "Fill all required fields to create the board!");
                              } else {
                                String returnStatus =
                                    await BoardsLocalServices().addBoard(
                                  boardnamecontroller.text,
                                  createdbycontroller.text,
                                  DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                                      .format(
                                    DateTime.now(),
                                  ),
                                  selectedColorValue,
                                  selectedTextColorValue,
                                );
                                if (kDebugMode) {
                                  print("BOARD ADD STATUS: $returnStatus");
                                }
                                if (returnStatus == StaticData.successStatus) {
                                  NotesSnackBar().successSnackBar(
                                      "${boardnamecontroller.text}, successfully created!");
                                  Get.offAll(
                                      () => const MainScreen(selectedIndex: 0));
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "create board",
                                  style: StaticData.t.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: selectedTextColor,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Icon(
                                  NotesIcon.button_arrow_right,
                                  color: selectedTextColor,
                                  size: 6,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
