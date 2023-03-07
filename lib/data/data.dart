import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes/android/views/items/create_notes_view.dart';
import 'package:notes/notes_icon_icons.dart';
import 'package:notes/services/other/local_model.dart';
import 'package:notes/theme/colors.dart';

class StaticData {
  StaticData._();

  static late ThemeData t;
  static late ColorScheme c;

  static const String currency = "₹";
  static const String currencyFlag = "INR";

  static late String appName;
  static late String packageName;
  static late String version;
  static late String buildNumber;

  static const String privacyPolicyUrl =
      'https://vjk10.github.io/notes/privacy_policy.html';
  static const String termsConditionsUrl =
      'https://vjk10.github.io/notes/terms_conditions.html';

  static const String excelFilePath =
      'storage/emulated/0/Documents/notes/expenses';

  static String genericMessage = "Do you wish to continue without saving?";

  static const String noteAction = 'NOTE ADD ACTION';
  static const String expenseAction = 'EXPENSE ADD ACTION';
  static const String listAction = 'LIST ADD ACTION';

  static const String notesTitle = 'Notes';
  static const String foldersTitle = 'Folders';
  static const String alertsTitle = 'Alerts';
  static const String clipboardTitle = 'Clipboard';
  static const String settingsTitle = 'Settings';
  static const String aboutTitle = 'About';

  static const String errorStatus = "404";
  static const String warningStatus = "500";
  static const String successStatus = "200";

  static late Isar isarDb;
  static late String uid;
  static String displayname = "";
  static late String dob;
  static late String phonenumber;
  static late String email;
  static late String username;
  static String photourl = "";

  static const String mainButtonTag = "mainButtonTag";

  static late bool cameSignedIn;

  static List<Map<String, dynamic>> boardcolors = [
    {
      "color": bgRed,
      "text": "red",
      "textcolor": popBlack500,
      "value": 0xFFFED5C4,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgBrown,
      "text": "brown",
      "textcolor": popBlack500,
      "value": 0xFFFFEED5,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgCyan,
      "text": "cyan",
      "textcolor": popBlack500,
      "value": 0xFFC4FEF0,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgPurple,
      "text": "purple",
      "textcolor": popBlack500,
      "value": 0xFFDDDCFF,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgGreen,
      "text": "green",
      "textcolor": popBlack500,
      "value": 0xFFEFFEC4,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgYellow,
      "text": "yellow",
      "textcolor": popBlack500,
      "value": 0xFFFFECA8,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": bgPink,
      "text": "pink",
      "textcolor": popBlack500,
      "value": 0xFFFFCAF3,
      "textvalue": 0xFF0D0D0D,
    },
  ];

  static List<CreateItemOptions> createOptions = [
    CreateItemOptions(
        title: "create note",
        icon: NotesIcon.note,
        description:
            "create notes, attach images, add comments and powerful styling!",
        mainColor: yoyo500,
        subColor: yoyo100,
        onTap: () {
          Get.to(() => const CreateNotesView());
        }),
    CreateItemOptions(
      title: "create list",
      icon: NotesIcon.lists,
      description:
          "create a list with a bunch of tasks or just some things you want to keep in mind!",
      mainColor: orangeSunshine500,
      subColor: orangeSunshine100,
      onTap: () {},
    )
  ];
}
