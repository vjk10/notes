import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
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
  static late String displayname;
  static late String dob;
  static late String phonenumber;
  static late String email;
  static late String username;
  static late String photourl;

  static const String mainButtonTag = "mainButtonTag";

  static late bool cameSignedIn;

  static List<Map<String, dynamic>> boardcolors = [
    {
      "color": poliPurple500,
      "text": "poli purple",
      "textcolor": popWhite500,
      "value": 0xFF6A35FF,
      "textvalue": 0xFFFFFFFF,
    },
    {
      "color": rss500,
      "text": "red",
      "textcolor": popWhite500,
      "value": 0xFFFF8744,
      "textvalue": 0xFFFFFFFF,
    },
    {
      "color": pinkPong500,
      "text": "pink pong",
      "textcolor": popWhite500,
      "value": 0xFFFF426F,
      "textvalue": 0xFFFFFFFF,
    },
    {
      "color": manna500,
      "text": "manna",
      "textcolor": popBlack500,
      "value": 0xFFFFCB45,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": neoPacha500,
      "text": "neo pacha",
      "textcolor": popBlack500,
      "value": 0xFFE5FE40,
      "textvalue": 0xFF0D0D0D,
    },
    {
      "color": yoyo500,
      "text": "yoyo",
      "textcolor": popWhite500,
      "value": 0xFFAA3FFF,
      "textvalue": 0xFFFFFFFF,
    },
    {
      "color": pakGreen500,
      "text": "pak green",
      "textcolor": popBlack500,
      "value": 0xFF3BFFAD,
      "textvalue": 0xFF0D0D0D,
    },
  ];
}
