import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';

class ClipBoard extends StatefulWidget {
  const ClipBoard({Key? key}) : super(key: key);

  @override
  State<ClipBoard> createState() => _ClipBoardState();
}

class _ClipBoardState extends State<ClipBoard> {
  TextEditingController clipboardController = TextEditingController();
  String clipboard = "";
  late User user;
  Map<String, chat_types.PreviewData> datas = {};
  late ScrollController _hideButtonController;
  bool _isVisible = true;

  @override
  void initState() {
    getUserStatus();
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    super.initState();
  }

  getUserStatus() async {
    user = FirebaseAuth.instance.currentUser!;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getClipBoardData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("clipboards")
        .snapshots();
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
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return WillPopScope(
        onWillPop: () async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({"clipboard": clipboardController.text});
          return true;
        },
        child: Scaffold(
          backgroundColor: c.background,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: c.onBackground),
            backgroundColor: notifier.material3
                ? c.secondaryContainer.withAlpha(50)
                : c.secondaryContainer,
            title: Text(
              "clipboard",
              style: t.textTheme.headline5,
            ),
            toolbarHeight: 80,
          ),
          body: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: getClipBoardData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ListView(
                          controller: _hideButtonController,
                          children: snapshot.data!.docs.map(
                            (e) {
                              return GestureDetector(
                                onLongPress: () async {
                                  HapticFeedback.heavyImpact();
                                  if (kDebugMode) {
                                    print("SELECTED ID: " + e.id);
                                  }
                                  // await FirebaseFirestore.instance
                                  //     .collection("users")
                                  //     .doc(user.uid)
                                  //     .collection("clipboards")
                                  //     .doc(e.id)
                                  //     .delete();
                                },
                                onTap: () {
                                  if (kDebugMode) {
                                    print("TAPPED");
                                  }
                                  FlutterClipboard.copy(e.get("text"))
                                      .whenComplete(() {
                                    HapticFeedback.heavyImpact();
                                    Get.showSnackbar(GetSnackBar(
                                      shouldIconPulse: false,
                                      backgroundColor: c.surface,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      borderRadius: 10,
                                      icon: Icon(
                                        Icons.content_paste_rounded,
                                        color: c.primary,
                                      ),
                                      duration: const Duration(seconds: 2),
                                      messageText: Text(
                                        "Copied to clipboard",
                                        style: t.textTheme.caption
                                            ?.copyWith(color: c.onSurface),
                                      ),
                                    ));
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    key: ValueKey(e.get("text").toString()),
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: c.secondaryContainer,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: LinkPreview(
                                          openOnPreviewImageTap: false,
                                          openOnPreviewTitleTap: false,
                                          enableAnimation: true,
                                          onPreviewDataFetched: (data) {
                                            setState(() {
                                              datas = {
                                                ...datas,
                                                e.get("text"): data,
                                              };
                                            });
                                          },
                                          previewData: datas[e.get("text")],
                                          text: e.get("text"),
                                          linkStyle:
                                              t.textTheme.button?.copyWith(
                                            color: c.onSecondaryContainer,
                                          ),
                                          textStyle: t.textTheme.button
                                              ?.copyWith(color: c.onSurface),
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
              Visibility(
                visible: _isVisible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width - 70,
                          child: TextField(
                            style: t.textTheme.bodySmall
                                ?.copyWith(color: c.onSecondaryContainer),
                            controller: clipboardController,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: c.secondaryContainer,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: c.secondaryContainer,
                                  width: 2,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: c.secondaryContainer,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: c.secondaryContainer,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: c.secondaryContainer,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: c.secondaryContainer,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2),
                          child: GestureDetector(
                            onTap: () async {
                              if (clipboardController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.uid)
                                    .collection("clipboards")
                                    .doc()
                                    .set({
                                  "text": clipboardController.text
                                }).whenComplete(() {
                                  setState(() {
                                    clipboardController.text = "";
                                  });
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: c.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.content_paste_rounded,
                                  color: c.background,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
