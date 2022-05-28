import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/services/notifier.dart';
import 'package:provider/provider.dart';

class AddAlertView extends StatefulWidget {
  const AddAlertView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddAlertViewState createState() => _AddAlertViewState();
}

class _AddAlertViewState extends State<AddAlertView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Note note;
  late String title, description;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                  height: 50,
                ),
                Icon(
                  Icons.add_alert_outlined,
                  color: c.primary,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width - 50,
                  height: 75,
                  decoration: BoxDecoration(
                    color: c.secondaryContainer,
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    border: Border.all(
                      color: c.secondaryContainer,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        alignment: Alignment.center,
                        dropdownColor: c.surface,
                        borderRadius: BorderRadius.circular(15),
                        isDense: true,
                        style: t.textTheme.button,
                        hint: Text(
                          'Select Pattern',
                          style: t.textTheme.button,
                        ),
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item,
                                      textAlign: TextAlign.left,
                                      style: t.textTheme.button,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedAlertPattern,
                        onChanged: (value) {
                          setState(() {
                            selectedAlertPattern = value.toString();
                          });
                          if (kDebugMode) {
                            print("SELECTED VALUE: $selectedAlertPattern");
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width - 50,
                    height: 75,
                    child: TextFormField(
                      controller: titleController,
                      onChanged: (value) {
                        setState(() {
                          title = value.toString();
                        });
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "alert name",
                        hintStyle: t.textTheme.button,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.all(
                          25.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width - 50,
                    height: 75,
                    child: TextFormField(
                      controller: descriptionController,
                      onChanged: (value) {
                        setState(() {
                          description = value.toString();
                        });
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "alert description",
                        hintStyle: t.textTheme.button,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: c.secondaryContainer,
                          ),
                        ),
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.all(
                          25.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width - 50,
                    height: 70,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: c.primary,
                        ),
                        onPressed: () async {},
                        child: Text(
                          "Create Alert",
                          style: t.textTheme.button?.copyWith(
                            color: c.onPrimary,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
