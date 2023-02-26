import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

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
}
