import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/providers/repeat_intervals.dart';
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

  List<bool> isSelected = List.generate(4, (index) => false);

  @override
  void initState() {
    super.initState();
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
                  "Add Alert",
                  style: t.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width - 30,
                    child: Center(
                      child: ToggleButtons(
                        isSelected: isSelected,
                        fillColor: c.primary,
                        selectedColor: c.onPrimary,
                        selectedBorderColor: c.onBackground,
                        disabledColor: c.onBackground,
                        disabledBorderColor: c.onBackground,
                        splashColor: c.primary.withOpacity(0.2),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        borderRadius: BorderRadius.circular(30),
                        color: c.onBackground,
                        onPressed: (index) {
                          setState(
                            () {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                              selectedAlertPattern = items[index].toString();
                              if (kDebugMode) {
                                print(
                                    "Selected Pattern: $selectedAlertPattern");
                              }
                            },
                          );
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(21.0),
                            child: Text('every minute'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(21.0),
                            child: Text('hourly'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(21.0),
                            child: Text('daily'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(21.0),
                            child: Text('weekly'),
                          ),
                        ],
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        label: const Text("Alert Title"),
                        labelStyle: t.textTheme.bodySmall
                            ?.copyWith(color: c.onBackground),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
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
                        label: const Text("Alert Description"),
                        labelStyle: t.textTheme.bodySmall
                            ?.copyWith(color: c.onBackground),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        filled: true,
                        fillColor: c.secondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
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
                          backgroundColor: c.primary,
                        ),
                        onPressed: () async {
                          var repeatInterval = RepeatIntervals()
                              .getInterval(selectedAlertPattern!)
                              .toString();
                          if (kDebugMode) {
                            print(repeatInterval.toString());
                          }
                          if (title.isNotEmpty && repeatInterval.isNotEmpty) {
                            Get.back();
                            var repeatInterval = RepeatIntervals()
                                .getInterval(selectedAlertPattern!);
                            NotificationService().showAlert(
                                context,
                                UniqueKey().toString(),
                                title,
                                description,
                                repeatInterval,
                                title,
                                DateTime.now());
                          } else {
                            Get.showSnackbar(
                              GetSnackBar(
                                backgroundColor: c.surface,
                                duration: const Duration(seconds: 2),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                shouldIconPulse: false,
                                icon: Icon(
                                  Icons.error_outline_rounded,
                                  color: c.error,
                                ),
                                borderRadius: 10,
                                messageText: Text(
                                  'Missing Details',
                                  style: t.textTheme.bodyMedium,
                                ),
                              ),
                            );
                          }
                        },
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
