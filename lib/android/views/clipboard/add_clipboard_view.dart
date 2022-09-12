import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../services/notifier.dart';
import '../../data/data.dart';

class AddClipboardView extends StatefulWidget {
  const AddClipboardView({Key? key}) : super(key: key);

  @override
  State<AddClipboardView> createState() => _AddClipboardViewState();
}

class _AddClipboardViewState extends State<AddClipboardView> {
  TextEditingController clipboardController = TextEditingController();
  late User user;

  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  getUserStatus() async {
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: c.surface,
        surfaceTintColor: c.surfaceTint,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 32,
                  height: 4,
                  color: c.onSurfaceVariant,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Clipboard Data",
                  style: t.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 150,
                  child: TextField(
                    controller: clipboardController,
                    maxLength: 100,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    textCapitalization: TextCapitalization.none,
                    maxLengthEnforcement:
                        MaxLengthEnforcement.truncateAfterCompositionEnds,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      fillColor: c.surfaceVariant,
                      filled: true,
                      label: const Text('clipboard data'),
                      errorMaxLines: 100,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: c.outline,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: c.primary,
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: c.error,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width - 30,
                  height: 65,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: c.primary,
                        foregroundColor: c.onPrimary,
                      ),
                      child: const Text("Add to Clipboard"),
                      onPressed: () async {
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
                            Get.back();
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
