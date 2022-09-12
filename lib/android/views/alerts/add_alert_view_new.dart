import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/services/db/notes_model.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/providers/repeat_intervals.dart';
import 'package:provider/provider.dart';

class AddAlertViewNew extends StatefulWidget {
  const AddAlertViewNew({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddAlertViewNewState createState() => _AddAlertViewNewState();
}

class _AddAlertViewNewState extends State<AddAlertViewNew> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Note note;
  late String title, description;
  late String fromDate, toDate;

  List<bool> isSelected = List.generate(4, (index) => false);

  @override
  void initState() {
    String formatDate(DateTime date) => DateFormat("d MMMM").format(date);
    var now = DateTime.now();
    fromDate = formatDate(now);
    toDate = formatDate(DateTime(now.year, now.month + 1, now.day));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    t = Theme.of(context);
    c = t.colorScheme;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: c.background,
          appBar: AppBar(
            backgroundColor: c.secondaryContainer,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: c.onBackground,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Create an Alert",
              style: t.textTheme.button,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  var repeatInterval =
                      RepeatIntervals().getInterval(selectedAlertPattern!);
                  NotificationService().showAlert(
                      context,
                      UniqueKey().toString(),
                      title,
                      description,
                      repeatInterval,
                      title,
                      DateTime.now());
                },
                child: Text(
                  "Save",
                  style: t.textTheme.button?.copyWith(
                    color: c.onSecondaryContainer,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Choose Intervals",
                    style: t.textTheme.labelLarge,
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
                    height: 30,
                  ),
                  Text(
                    "Enter Details",
                    style: t.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                label: const Text("title"),
                                labelStyle: t.textTheme.bodySmall
                                    ?.copyWith(color: c.onBackground),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                filled: true,
                                fillColor: c.surfaceVariant,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
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
                                label: const Text("description"),
                                labelStyle: t.textTheme.bodySmall
                                    ?.copyWith(color: c.onBackground),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                filled: true,
                                fillColor: c.surfaceVariant,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Choose Duration",
                          style: t.textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: SizedBox(
                                width: Get.width / 2.4,
                                height: 75,
                                child: TextFormField(
                                  controller: descriptionController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: fromDate,
                                    hintStyle: t.textTheme.bodySmall
                                        ?.copyWith(color: c.onBackground),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    filled: true,
                                    fillColor: c.surfaceVariant,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: Get.width / 2.4,
                                height: 75,
                                child: TextFormField(
                                  controller: descriptionController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: toDate,
                                    hintStyle: t.textTheme.bodySmall
                                        ?.copyWith(color: c.onBackground),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    filled: true,
                                    fillColor: c.surfaceVariant,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
