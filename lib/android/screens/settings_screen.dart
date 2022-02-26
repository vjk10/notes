import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userName = "Username";
  String cacheMemorySize = "0";
  String appMemorySize = "0";
  bool appMemoryFound = false;
  bool cacheFound = false;
  late Directory tempDir;
  late Directory appDir;
  bool _autoSave = true;
  final bool _accountLinked = false;

  late DocumentSnapshot userSnapshot;

  @override
  void initState() {
    getSaveStatus();
    getUserStatus();
    getCacheMemory();
    super.initState();
  }

  getSaveStatus() async {
    bool _value = await NotesDatabase().checkAutoSave();
    setState(() {
      _autoSave = _value;
    });
  }

  getUserStatus() async {
    userSnapshot = await ScientISSTdb.instance
        .collection("userPref")
        .document("user")
        .get();
    userName = userSnapshot.data["name"];
  }

  getCacheMemory() async {
    Directory _tempDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("ApplicationDocumentsDirectory: " + _tempDir.toString());
    }
    cacheDirStatSync(_tempDir.path);
  }

  Map<String, int> cacheDirStatSync(String dirPath) {
    int fileNum = 0;
    int totalSize = 0;
    var dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            fileNum++;
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    setState(() {
      cacheMemorySize = filesize(totalSize);
      if (totalSize > 0) {
        cacheFound = true;
      }
      if (totalSize <= 0) {
        cacheFound = false;
      }
    });
    return {'fileNum': fileNum, 'size': totalSize};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings",
          style: t.textTheme.headline5,
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NotesLogo(),
                    if (!_accountLinked)
                      const SizedBox(
                        height: 30,
                      ),
                    Visibility(
                      visible: false,
                      // visible: !_accountLinked,
                      child: SignInButton(
                        Buttons.Google,
                        onPressed: () {},
                        padding: const EdgeInsets.all(8),
                        text: "  Sign in to backup notes",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "User Data",
                  style: t.textTheme.button?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: userNameTile(),
              ),
              Visibility(
                visible: _accountLinked,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: cloudBackupTile(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: autoSaveTile(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "Device Data",
                  style: t.textTheme.button?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: usedStorageTile(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: clearNotesTile(),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container autoSaveTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              UniconsLine.save,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Autosave",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
            trailing: Switch.adaptive(
                activeColor: c.primary,
                inactiveThumbColor: c.secondary,
                value: _autoSave,
                onChanged: (value) async {
                  HapticFeedback.heavyImpact();
                  await NotesDatabase().setAutoSave(value);
                  setState(() {
                    _autoSave = value;
                  });
                }),
          ),
        ),
      ),
    );
  }

  Container themeDataTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            onTap: () {},
            leading: Icon(
              UniconsLine.palette,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Choose Theme",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container cloudBackupTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              UniconsLine.cloud,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Cloud Backup",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                "Back Up",
                style: t.textTheme.button?.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container userNameTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              UniconsLine.user_circle,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              userName,
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container usedStorageTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              UniconsLine.database,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Used Storage",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
            trailing: Text(
              cacheMemorySize,
              style: t.textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }

  Container clearNotesTile() {
    return Container(
      width: Get.width - 20,
      height: 80,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              UniconsLine.trash_alt,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Clear All Notes",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
            trailing: TextButton(
              onPressed: () {
                NotesDatabase().clearAllNotes();
              },
              child: Text(
                "Clear",
                style: t.textTheme.button?.copyWith(
                  fontSize: 14,
                  color: c.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
