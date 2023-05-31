import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/theme/colors.dart';
import 'package:scrollable/exports.dart';

import '../../../data/data.dart';
import '../../../services/other/local_model.dart';
import '../items/create_notes_view.dart';

class AddItemsToBoard extends StatefulWidget {
  int? boardid;
  String? boardidFb;
  final Color boardColor;
  final Color boardTextColor;

  AddItemsToBoard(
      {Key? key,
      this.boardid,
      this.boardidFb,
      required this.boardColor,
      required this.boardTextColor})
      : super(key: key);

  @override
  State<AddItemsToBoard> createState() => _AddItemsToBoardState();
}

class _AddItemsToBoardState extends State<AddItemsToBoard> {
  ScrollController createOptionController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
      createOptionController.animateTo(
        createOptionController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CreateItemOptions> createOptions = [
      CreateItemOptions(
          title: "create note",
          icon: NotesIcon.note,
          description:
              "create notes, attach images, add comments and powerful styling!",
          mainColor: yoyo500,
          subColor: yoyo100,
          onTap: () {
            Get.to(() => CreateNotesView(
                  boardid: widget.boardid,
                  boardColor: widget.boardColor,
                  boardTextColor: widget.boardTextColor,
                ));
          }),
      // CreateItemOptions(
      //   title: "create list",
      //   icon: NotesIcon.lists,
      //   description:
      //       "create a list with a bunch of tasks or just some things you want to keep in mind!",
      //   mainColor: orangeSunshine500,
      //   subColor: orangeSunshine100,
      //   onTap: () {},
      // )
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: popBlack500,
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "create item",
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
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SvgPicture.asset("assets/images/waves.svg"),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 50,
                      ),
                      child: Text(
                        "choose the type of item to add to the board",
                        style: StaticData.t.textTheme.titleMedium?.copyWith(
                          color: popWhite500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height / 2,
                          child: ScrollHaptics(
                            hapticEffectAtEdge: HapticType.heavy,
                            hapticEffectDuringScroll: HapticType.selection,
                            child: ListView.builder(
                              controller: createOptionController,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: createOptions.length,
                              itemExtent: 300,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CreateItemOptionsWidget(
                                        createItemOption: createOptions[index]),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CreateItemOptionsWidget extends StatelessWidget {
  final CreateItemOptions createItemOption;
  const CreateItemOptionsWidget({
    Key? key,
    required this.createItemOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: createItemOption.mainColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: createItemOption.subColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  createItemOption.icon,
                  color: createItemOption.mainColor,
                  size: 35,
                ),
              ),
            ),
            Text(
              createItemOption.title,
              style: StaticData.t.textTheme.titleLarge?.copyWith(
                color: createItemOption.subColor,
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                createItemOption.description,
                style: StaticData.t.textTheme.bodyLarge?.copyWith(
                  color: createItemOption.subColor,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: NeoPopButton(
                animationDuration: const Duration(milliseconds: 250),
                color: createItemOption.subColor,
                onTapDown: () => HapticFeedback.vibrate(),
                onTapUp: createItemOption.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "choose & proceed",
                      style: StaticData.t.textTheme.bodySmall?.copyWith(
                        color: createItemOption.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(
                      NotesIcon.button_arrow_right,
                      color: createItemOption.mainColor,
                      size: 6,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
