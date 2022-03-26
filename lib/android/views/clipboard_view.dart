import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';

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
    DocumentSnapshot userCollection = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    if (userCollection.exists) {
      clipboardController.text = userCollection.get("clipboard");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getClipBoardData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("clipboards")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set({"clipboard": clipboardController.text});
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
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
                    return ListView(
                      controller: _hideButtonController,
                      children: snapshot.data!.docs
                          .map((e) => GestureDetector(
                                onLongPress: () async {
                                  HapticFeedback.heavyImpact();
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user.uid)
                                      .collection("clipboards")
                                      .doc(e.id)
                                      .delete();
                                },
                                onTap: () {
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
                                      color: c.surface,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: LinkPreview(
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
                                            color: c.tertiary,
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
                              ))
                          .toList(),
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
                          controller: clipboardController,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: c.surface,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: c.surface,
                                width: 2,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: c.surface,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: c.surface,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: c.surface,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: c.surface,
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
  }
}
