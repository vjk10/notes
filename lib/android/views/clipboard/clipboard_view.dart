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
import 'package:notes/android/views/clipboard/add_clipboard_view.dart';
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
  bool appBarControl = false;
  String selectedText = "";
  String selectedID = "";

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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Visibility(
                visible: _isVisible,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.bottomSheet(
                      SizedBox(
                        height: Get.height / 2,
                        child: const AddClipboardView(),
                      ),
                      elevation: 10,
                    );
                  },
                  child: const Icon(
                    Icons.note_alt_outlined,
                  ),
                ),
              )),
          appBar: appBarControl
              ? AppBar(
                  primary: true,
                  backgroundColor: c.background,
                  title: const Text("clipboard"),
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        HapticFeedback.heavyImpact();
                        selectedText = "";
                        selectedID = "";
                        appBarControl = !appBarControl;
                      });
                    },
                    icon: Icon(
                      Icons.deselect_outlined,
                      color: c.onBackground,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print(selectedText);
                        }
                        FlutterClipboard.copy(selectedText).whenComplete(() {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            HapticFeedback.heavyImpact();
                            selectedText = "";
                            selectedID = "";
                            appBarControl = !appBarControl;
                          });
                          Get.showSnackbar(GetSnackBar(
                            shouldIconPulse: false,
                            backgroundColor: c.surface,
                            margin: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            // borderRadius: 10,
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
                      icon: Icon(
                        Icons.copy_outlined,
                        color: c.onBackground,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print(selectedText);
                          print(selectedID);
                        }
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user.uid)
                            .collection("clipboards")
                            .doc(selectedID)
                            .delete()
                            .whenComplete(() {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            HapticFeedback.heavyImpact();
                            selectedText = "";
                            selectedID = "";
                            appBarControl = !appBarControl;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: c.onBackground,
                      ),
                    ),
                  ],
                )
              : AppBar(
                  backgroundColor: c.background,
                  title: const Text("clipboard"),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/settings');
                      },
                      icon: Icon(
                        Icons.settings_outlined,
                        color: c.onBackground,
                      ),
                    ),
                  ],
                ),
          body: StreamBuilder<QuerySnapshot>(
              stream: getClipBoardData(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    controller: _hideButtonController,
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate.fixed(
                        snapshot.data!.docs.map((e) {
                          return Column(
                            children: [
                              GestureDetector(
                                onLongPress: () async {
                                  if (!appBarControl) {
                                    HapticFeedback.heavyImpact();
                                    setState(() {
                                      appBarControl = !appBarControl;
                                      selectedText = e.get('text');
                                      selectedID = e.id;
                                    });
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    key: ValueKey(e.get("text").toString()),
                                    margin: const EdgeInsets.all(16),
                                    color: c.surfaceVariant,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: e.id == selectedID
                                          ? BorderSide(
                                              color: c.primary,
                                              width: 2,
                                            )
                                          : BorderSide.none,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
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
                                              t.textTheme.bodyMedium?.copyWith(
                                            color: c.onBackground,
                                          ),
                                          textStyle:
                                              t.textTheme.bodyMedium?.copyWith(
                                            color: c.onBackground,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ))
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ),
      );
    });
  }
}
