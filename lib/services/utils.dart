import 'dart:convert';

import 'package:about/about.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/licenses_and_info.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/playstore/playstore_data_model.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:http/http.dart' as http;

import '../android/widgets/app_update_widget.dart';

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
        // backgroundColor: c.background,
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
        ],
      ),
    );
  }

  Future<dynamic> confirmationForAlertsDeletion(
      BuildContext context, ThemeData t, ColorScheme c) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: c.background,
        title: const Text(
          "Confirm",
        ),
        content: const Text(
          "If you proceed with deletion, then all reminders and alerts that were scheduled will be cancelled.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              NotificationService().endAllReminder();
            },
            child: const Text(
              "Proceed",
            ),
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
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
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
            child: Text(
              "Read It Later",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
                color: c.primary,
              ),
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
            child: Text(
              "View Documents",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
                color: c.primary,
              ),
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
    TimeOfDay nowTime = TimeOfDay.now();
    return showTimePicker(
      context: context,
      initialTime: initTime,
      cancelText: 'Cancel',
      confirmText: 'Set Reminder',
    ).then((value) {
      try {
        initTime = value!;
        if (kDebugMode) {
          print("SELECTED HOUR: ${initTime.hour}");
        }
        DateTime now = DateTime.now();
        if (nowTime.period != DayPeriod.am && initTime.period == DayPeriod.am) {
          now = DateTime.now().add(
            const Duration(days: 1),
          );
        }
        DateTime time = DateTime(
            now.year, now.month, now.day, initTime.hour, initTime.minute);
        String messageSnackBar =
            "You will reminded about $title at ${DateFormat.jm().format(time)} on ${DateFormat.yMMMd().format(time)}";
        if (kDebugMode) {
          print("TITLE:$title");
          print("BODY:$body");
          print("ID:$noteID");
          print(
            "CHOOSEN TIME: $value",
          );
          print("MESSAGE: $messageSnackBar");
        }
        NotificationService().showNotification(
          context,
          noteID,
          title,
          '',
          "${DateFormat.jm().format(time)},${DateFormat.yMMMd().format(time)}",
          messageSnackBar,
          time,
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  // #47
  showAbout(BuildContext context, String package, String version,
      String buildNumber, String? icon) async {
    showAboutPage(
      context: context,
      title: const Text(aboutTitle),
      applicationName: getAppName(package),
      applicationVersion: 'v $version (build $buildNumber)',
      applicationIcon: icon!.isNotEmpty
          ? Image.network(
              icon,
              width: Get.width / 4,
              height: Get.width / 4,
              loadingBuilder: (context, child, loadingProgress) {
                return CircularProgressIndicator(
                  value: loadingProgress?.cumulativeBytesLoaded.toDouble(),
                  color: c.primaryContainer,
                  valueColor: AlwaysStoppedAnimation(c.primaryContainer),
                );
              },
            )
          : const SizedBox(),
      children: <Widget>[
        // #48
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.notes_outlined,
          ),
          title: Text('View Readme'),
          filename: 'README.md',
        ),
        // #49
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.track_changes_outlined,
          ),
          title: Text('Read Changelog'),
          filename: 'CHANGELOG.md',
        ),
        // #52
        const LicensesPageListTile(
          title: Text("View Licenses"),
          icon: Icon(
            Icons.public,
          ),
        ),
        // #50
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.handshake_outlined,
          ),
          title: Text('View Contributing'),
          filename: 'CONTRIBUTING.md',
        ),
        // #45
        ListTile(
          onTap: (() {
            Get.to(() => AppUpdate(
                  packageName: package,
                  currentVersion: 'v $version (build $buildNumber)',
                ));
          }),
          leading: const Icon(
            Icons.system_security_update_outlined,
          ),
          title: const Text('Check for Updates'),
        ),
      ],
    );
  }

  getAppName(String packageName) {
    switch (packageName) {
      case 'com.vlabs.notes':
        {
          return 'notes';
        }
      case 'com.vlabs.notes.debug':
        {
          return 'notes (debug)';
        }
      case 'com.vlabs.notes.beta':
        {
          return 'notes (beta)';
        }
      default:
        {
          return 'notes';
        }
    }
  }

  Future<PlaystoreData> fetchPlaystoreData(String packagename) async {
    final response = await http.get(
      kDebugMode
          ? Uri.parse(
              'https://peekanapp.vercel.app/api/playstore?appId=com.vlabs.notes')
          : Uri.parse(
              'https://peekanapp.vercel.app/api/playstore?appId=$packagename'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PlaystoreData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load PlaystoreData');
    }
  }

  getPrimaryColor(int color) {
    switch (color) {
      case 1:
        {
          return Colors.purpleAccent;
        }
      case 2:
        {
          return Colors.yellowAccent;
        }
      case 3:
        {
          return Colors.greenAccent;
        }
      case 4:
        {
          return Colors.redAccent;
        }
      case 5:
        {
          return Colors.pinkAccent;
        }
      case 6:
        {
          return Colors.orangeAccent;
        }
      // case 7:
      //   {
      //     return ash;
      //   }
      default:
        {
          return Colors.blueAccent;
        }
    }
  }
}
