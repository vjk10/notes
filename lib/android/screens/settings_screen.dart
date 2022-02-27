import 'dart:io';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_logo.dart';
import 'package:notes/android/widgets/user_details.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/theme/app_themes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:unicons/unicons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  String userName = "Username";
  String cacheMemorySize = "0";
  String appMemorySize = "0";
  bool appMemoryFound = false;
  bool cacheFound = false;
  late Directory tempDir;
  late Directory appDir;
  bool _autoSave = true;
  final bool _accountLinked = false;
  String selectedTheme = "";
  int selectedThemeId = 0;

  late DocumentSnapshot userSnapshot;

  late AnimationController _bottomSheetController;

  @override
  void initState() {
    _bottomSheetController = AnimationController(vsync: this);
    themesList = themes.toList();
    getTheme();
    getSaveStatus();
    getUserStatus();
    getCacheMemory();
    super.initState();
  }

  getTheme() {
    var themeID = DynamicTheme.of(context)!.themeId;
    setState(() {
      selectedThemeId = themeID;
      selectedTheme = AppThemes().getThemeName(themeID);
    });

    if (kDebugMode) {
      print("SELECTED THEME: " + selectedTheme);
    }
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
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/mainScreen');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "settings",
            style: t.textTheme.headline5,
          ),
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed('/mainScreen');
              },
              icon: Icon(
                UniconsLine.arrow_left,
                color: c.onBackground,
                size: 36,
              )),
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UserDetails(userName: userName, accountLinked: _accountLinked),
                const SizedBox(
                  height: 50,
                ),
                userDataSection(),
                deciveDataSection(),
                Center(
                  child: Visibility(
                    visible: _accountLinked,
                    child: SizedBox(
                      width: Get.width,
                      height: 75,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Logout",
                          style: t.textTheme.button?.copyWith(
                            color: c.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding deciveDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 15.0,
                ),
                child: Text(
                  "Device Data",
                  textAlign: TextAlign.start,
                  style: t.textTheme.button,
                ),
              ),
              Visibility(
                visible: _accountLinked,
                child: cloudBackupTile(),
              ),
              usedStorageTile(),
              clearNotesTile(),
              appDetailsTile(),
            ],
          ),
        ),
      ),
    );
  }

  Padding userDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 15.0,
                ),
                child: Text(
                  "User Data",
                  textAlign: TextAlign.start,
                  style: t.textTheme.button,
                ),
              ),
              Visibility(
                visible: _accountLinked,
                child: cloudBackupTile(),
              ),
              autoSaveTile(),
              themeDataTile(),
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
            trailing: GestureDetector(
              onTap: () {
                HapticFeedback.heavyImpact();
                showThemeSheet();
              },
              child: Image.asset(
                selectedTheme,
                width: 36,
                height: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showThemeSheet() {
    Get.bottomSheet(
      SizedBox(
        height: Get.bottomBarHeight + 350,
        child: BottomSheet(
          animationController: _bottomSheetController,
          enableDrag: true,
          backgroundColor: c.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          onClosing: () {
            HapticFeedback.heavyImpact();
          },
          builder: (context) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "Choose Theme",
                    style: t.textTheme.headline6,
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  height: Get.bottomBarHeight + 250,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: themesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 50.0),
                          child: GestureDetector(
                            onTap: () {
                              changeTheme(index, context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      themesList[index]["url"].toString(),
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: selectedThemeId == index
                                        ? c.primary.withOpacity(0.2)
                                        : c.secondary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      themesList[index]["name"].toString(),
                                      style: t.textTheme.button?.copyWith(
                                        color: selectedThemeId == index
                                            ? c.primary
                                            : c.onSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeTheme(int index, BuildContext context) {
    HapticFeedback.heavyImpact();
    Get.back();
    setState(() {
      selectedTheme = AppThemes().getThemeName(index);
      selectedThemeId = index;
    });
    DynamicTheme.of(context)!.setTheme(index);
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
              UniconsLine.folder,
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
            trailing: GestureDetector(
              onTap: () {
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

  Container appDetailsTile() {
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
              UniconsLine.info_circle,
              color: c.tertiary,
              size: 24,
            ),
            title: Text(
              "Licenses and Info",
              style: t.textTheme.button?.copyWith(
                fontSize: 14,
              ),
            ),
            trailing: TextButton(
              onPressed: () {
                Get.to(() => Theme(
                      data: t.copyWith(
                        colorScheme: c,
                        cardColor: c.background,
                        backgroundColor: c.background,
                        appBarTheme: AppBarTheme(
                          iconTheme: IconThemeData(
                            color: c.onBackground,
                          ),
                          color: c.background,
                          elevation: 0,
                          toolbarHeight: 80,
                          titleTextStyle: t.textTheme.headline5,
                        ),
                      ),
                      child: LicensePage(
                        applicationIcon: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            NotesLogo(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        applicationLegalese: "Simple notes taking app",
                        applicationName: " ",
                        applicationVersion:
                            "v" + version + " (build v" + buildNumber + ")",
                      ),
                    ));
              },
              child: Text(
                "v" + version + " (build v" + buildNumber + ")",
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
