import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/widgets/licenses_and_info.dart';
import 'package:notes/services/notification_services.dart';
import 'package:scientisst_db/scientisst_db.dart';

class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  Future<bool> checkTerms() async {
    DocumentSnapshot termsSnapshot = await ScientISSTdb.instance
        .collection("userPref")
        .document("onboarding")
        .get();
    return termsSnapshot.data["conditions"];
  }

  Future<dynamic> confirmationForSave(
      BuildContext context, ThemeData t, ColorScheme c) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: c.surface,
        title: const Text(
          "Error Saving",
        ),
        content: const Text(
          "Do you wish to continue without saving the note?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed('/mainScreen');
            },
            child: const Text(
              "Leave",
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Continue Editing",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Future<dynamic> licenseDialog(
      BuildContext context, ThemeData t, ColorScheme c, bool onboarding) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: c.surface,
        title: const Text(
          "Policies",
        ),
        content: const Text(
            "By continuing you agree to our privacy policy and terms & conditions."),
        actions: [
          TextButton(
            onPressed: () async {
              await ScientISSTdb.instance
                  .collection("userPref")
                  .document("onboarding")
                  .update(
                {
                  "conditions": true,
                },
              );
              if (onboarding) {
                Get.toNamed('/onboarding2');
              } else {
                Get.offAllNamed('/mainScreen');
              }
            },
            child: const Text(
              "Read It Later",
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await ScientISSTdb.instance
                  .collection("userPref")
                  .document("onboarding")
                  .update(
                {
                  "conditions": true,
                },
              );
              Get.bottomSheet(
                BottomSheet(
                  backgroundColor: Colors.transparent,
                  onClosing: () {},
                  builder: (_) {
                    return const LicensesAndInfo();
                  },
                ),
              );
            },
            child: const Text(
              "View Documents",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Future<dynamic> reminderDialog(
    String title,
    String body,
    String noteID,
    BuildContext context,
    ThemeData t,
    ColorScheme c,
  ) async {
    TimeOfDay initTime = TimeOfDay.now();
    late int intervalDuration;
    return showTimePicker(
      context: context,
      initialTime: initTime,
      cancelText: 'Cancel',
      confirmText: 'Set Reminder',
    ).then((value) {
      try {
        initTime = value!;
        int nowInMinutes =
            TimeOfDay.now().hour * 60 + TimeOfDay.now().minute * 60;
        int selectedTimeMinutes = initTime.hour * 60 + initTime.minute * 60;

        if (nowInMinutes > selectedTimeMinutes) {
          intervalDuration = nowInMinutes - selectedTimeMinutes;
        } else {
          intervalDuration = selectedTimeMinutes - nowInMinutes;
        }
        if (kDebugMode) {
          print("TITLE:" + title);
          print("BODY:" + body);
          print("ID:" + noteID);
          print(
            "CHOOSEN TIME: " + value.toString(),
          );
          print("NOW IN MINUTES: " + nowInMinutes.toString());
          print("SELECTED IN MINUTES: " + selectedTimeMinutes.toString());
          print("INTERVAL DURATION: " + intervalDuration.toString());
        }
        NotificationService()
            .startReminder(title, selectedTimeMinutes, intervalDuration, false);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  Future<dynamic> createAlertDialog(
    BuildContext context,
    ThemeData t,
    ColorScheme c,
  ) async {
    String? selectedValue;
    List<String> items = [
      'Every Day',
      'Every Weekend',
      'Every Monday',
      'Pick a Date',
    ];
    // TimeOfDay initTime = TimeOfDay.now();
    // late int intervalDuration;
    // DateTime firstDate = DateTime.now();
    // DateTime lastDate = DateTime.now().add(const Duration(days: 8000));
    // return showDatePicker(
    //   firstDate: firstDate,
    //   lastDate: lastDate,
    //   initialDate: firstDate,
    //   currentDate: DateTime.now(),
    //   locale: locale,
    //   context: context,
    // ).then((value) {
    //   try {
    //     if (kDebugMode) {
    //       print("Selected Date Range: " + value.toString());
    //     }
    //   } catch (e) {
    //     if (kDebugMode) {
    //       print(e);
    //     }
    //   }
    // });
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: c.background,
        title: Text(
          "Create Alert",
          style: t.textTheme.button,
        ),
        content: SizedBox(
          height: 150,
          width: Get.width - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width - 80,
                height: 75,
                decoration: BoxDecoration(
                  color: c.background,
                  border: Border.all(color: c.primary, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: c.primary,
                      ),
                      dropdownColor: c.background,
                      borderRadius: BorderRadius.circular(15),
                      isDense: true,
                      hint: Text(
                        'Select a Day',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      item == "Pick a Date"
                                          ? Icons.calendar_month_outlined
                                          : Icons.repeat,
                                      color: c.primary,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        selectedValue = value as String;
                        if (kDebugMode) {
                          print("SELECTED VALUE: " + selectedValue.toString());
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
