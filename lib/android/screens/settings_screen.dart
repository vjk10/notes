import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/android/widgets/user_details.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/database_service.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/google_sign_in.dart';
import 'package:notes/services/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  String userName = "Username";
  String profileUrl = "";
  String userEmail = "";
  String cacheMemorySize = "0";
  String appMemorySize = "0";
  bool appMemoryFound = false;
  bool cacheFound = false;
  bool materialYouActive = false;
  late Directory tempDir;
  late Directory appDir;
  bool _autoSave = true;
  bool _accountLinked = false;
  bool _isLoading = false;
  String selectedTheme = "";
  int selectedThemeId = 0;

  late SharedPreferences _pref;
  late DocumentSnapshot userSnapshot;
  late fire_store.DocumentSnapshot firebaseUserDetails;
  late User user;

  // late AnimationController _bottomSheetController;

  late TextStyle topBarTextStyle;

  bool styleExpanded = true;
  late String icon;

  @override
  void initState() {
    // _bottomSheetController = AnimationController(vsync: this);
    themesList = themes.toList();
    _initPrefs();
    getTheme();
    getSaveStatus();
    getUserStatus();
    getCacheMemory();
    getAppIcon();
    super.initState();
  }

  getAppIcon() async {
    await Utils().fetchPlaystoreData(packageName).then((value) {
      setState(() {
        icon = value.icon;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print("ICON ERROR: $error");
      }
      setState(() {
        icon = "";
      });
    });
  }

  _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  getTheme() async {
    _pref = await SharedPreferences.getInstance();
    selectedThemeId = (_pref.getInt(primaryKey) ?? 0) - 1;
    if (kDebugMode) {
      print("Selected Theme: $selectedThemeId");
    }
  }

  getSaveStatus() async {
    bool value = await NotesDatabase().checkAutoSave();
    setState(() {
      _autoSave = value;
    });
  }

  getUserStatus() async {
    userSnapshot = await ScientISSTdb.instance
        .collection("userPref")
        .document("user")
        .get();
    userName = userSnapshot.data["name"];
    try {
      user = FirebaseAuth.instance.currentUser!;

      firebaseUserDetails = await fire_store.FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      setState(() {
        _accountLinked = true;
        profileUrl = user.photoURL.toString();
        userName = user.displayName.toString();
        userEmail = user.email.toString();
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (kDebugMode) {
          print(e.message);
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  getCacheMemory() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("ApplicationDocumentsDirectory: $tempDir");
    }
    cacheDirStatSync(tempDir.path);
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
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed('/mainScreen');
          return true;
        },
        child: Scaffold(
          backgroundColor: c.background,
          body: _isLoading
              ? const Center(
                  child: NotesLoadingAndroid(
                    strokeWidth: 4,
                  ),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar.large(
                      backgroundColor: c.background,
                      surfaceTintColor: c.surfaceTint,
                      primary: true,
                      leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: c.onBackground,
                        ),
                      ),
                      title: const Text(
                        settingsTitle,
                      ),
                      actions: [
                        Visibility(
                          visible: _accountLinked,
                          child: IconButton(
                            onPressed: () async {
                              await signOutGoogle(context).whenComplete(() {
                                setState(() {
                                  profileUrl = "";
                                  _accountLinked = !_accountLinked;
                                });
                              });
                            },
                            icon: Icon(
                              Icons.login_outlined,
                              color: c.outline,
                            ),
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 25.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UserDetails(
                              userName: userName,
                              profileUrl: profileUrl,
                              email: userEmail,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Visibility(
                                visible: !_accountLinked,
                                child: SignInButton(
                                  Buttons.Google,
                                  onPressed: () async {
                                    await signInWithGoogle(context)
                                        .whenComplete(() {
                                      getUserStatus();
                                    });
                                  },
                                  padding: const EdgeInsets.all(8),
                                  text: "  Sign in to backup notes",
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _accountLinked ? 0 : 50,
                            ),
                            userDataSection(),
                            deciveDataSection(),
                            Center(
                              child: Visibility(
                                visible: false,
                                child: SizedBox(
                                  width: Get.width,
                                  height: 75,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: c.primary,
                                    ),
                                    onPressed: () async {
                                      await signOutGoogle(context)
                                          .whenComplete(() {
                                        setState(() {
                                          profileUrl = "";
                                          _accountLinked = !_accountLinked;
                                        });
                                      });
                                    },
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
                  ],
                ),
        ),
      );
    });
  }

  Padding deciveDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Device Data",
              textAlign: TextAlign.center,
              style: t.textTheme.button?.copyWith(
                color: c.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          usedStorageTile(),
          clearNotesTile(),
          appDetailsTile(),
        ],
      ),
    );
  }

  Padding userDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "User Data",
              textAlign: TextAlign.center,
              style: t.textTheme.button?.copyWith(
                color: c.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Visibility(
            visible: _accountLinked,
            child: cloudBackupTile(),
          ),
          if (m3YouAvail) materialYou(),
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => Visibility(
              visible: !notifier.material3,
              child: themeDataTile(),
            ),
          ),
          autoSaveTile(),
          currencyTile(),
        ],
      ),
    );
  }

  Consumer<ThemeNotifier> materialYou() {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: ListTile(
            leading: Icon(
              Icons.colorize_outlined,
              color: c.onBackground,
            ),
            title: Text(
              "Material You",
              style: t.textTheme.button?.copyWith(fontSize: 14),
            ),
            subtitle: Text(
              "Supported devices will pick the theme \ndynamically from your system wallpaper",
              style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
            ),
            trailing: Switch(
                activeColor: c.primary,
                inactiveThumbColor: c.secondary,
                inactiveTrackColor: c.tertiaryContainer,
                value: notifier.material3,
                onChanged: (value) async {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    notifier.toggleTheme();
                  });
                  selectedThemeId = _pref.getInt('primaryColor')!;
                  if (kDebugMode) {
                    print("Selected Theme: $selectedThemeId");
                  }
                }),
          ),
        ),
      );
    });
  }

  Padding autoSaveTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.save_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "Autosave",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "Disabling auto save will require you to \nmanually save notes",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          trailing: Switch(
              activeColor: c.primary,
              inactiveThumbColor: c.secondary,
              inactiveTrackColor: c.tertiaryContainer,
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
    );
  }

  Padding currencyTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.currency_exchange_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "Choose Currency",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "The currency to be used in Expense Tracker \ncan be selected here",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          trailing: OutlinedButton(
            onPressed: () {
              showCurrencyPicker(
                  context: context,
                  theme: CurrencyPickerThemeData(
                      flagSize: 24,
                      backgroundColor: c.background,
                      titleTextStyle: t.textTheme.button,
                      subtitleTextStyle: t.textTheme.subtitle1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  onSelect: (value) {
                    setState(() {
                      currency = value.symbol;
                      currencyFlag = value.flag!;
                    });
                  });
            },
            child: Text(
              "$currency $currencyFlag",
              style: t.textTheme.button?.copyWith(
                fontSize: 12,
                color: c.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding cloudBackupTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.backup_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "Cloud Backup",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "Import notes from your Google Account to offline storage",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          trailing: OutlinedButton(
            onPressed: () async {
              await DatabaseService().importNotes(user.uid);
            },
            child: Text(
              "Import",
              style: t.textTheme.button?.copyWith(
                fontSize: 12,
                color: c.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding usedStorageTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.folder_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "Used Storage",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "Total storage used by notes app \nas a whole",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          trailing: Text(
            cacheMemorySize,
            style: t.textTheme.bodyLarge?.copyWith(color: c.onBackground),
          ),
        ),
      ),
    );
  }

  Padding clearNotesTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.delete_sweep_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "Clear All Notes",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "On doing this all notes local and imported \nwill be cleared",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          trailing: OutlinedButton(
            onPressed: () {
              NotesDatabase().clearAllNotes();
            },
            child: Text(
              "Clear",
              style: t.textTheme.button?.copyWith(
                fontSize: 12,
                color: c.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding appDetailsTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: ListTile(
          onTap: () {
            // #47
            Utils().showAbout(context, packageName, version, buildNumber, icon);
          },
          leading: Icon(
            Icons.tips_and_updates_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "About and Info",
            style: t.textTheme.button?.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            "v$version \nbuild: $buildNumber",
            style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
        ),
      ),
    );
  }

  Center themeDataTile() {
    return Center(
      child: ListTile(
        leading: Icon(
          Icons.palette_outlined,
          color: c.onBackground,
        ),
        title: Text(
          "Choose Primary",
          style: t.textTheme.button?.copyWith(fontSize: 14),
        ),
        subtitle: Text(
          "Choose from our list of colors to \nchange the look of notes",
          style: t.textTheme.labelSmall?.copyWith(fontSize: 10),
        ),
        trailing: GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            showThemeSheet();
          },
          child: CircleAvatar(
            backgroundColor: c.primary,
            radius: 20,
          ),
        ),
      ),
    );
  }

  void showThemeSheet() {
    Get.bottomSheet(
      Consumer<ColorNotifier>(builder: (context, notifier, child) {
        return Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          color: c.surface,
          surfaceTintColor: c.surfaceTint,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                    "Pick a Primary",
                    style: t.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width - 30,
                    height: Get.height / 2,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3),
                        itemCount: primaryList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Get.back();
                              if (kDebugMode) {
                                print(index);
                              }
                              selectedThemeId = index;
                              notifier.toggleColor(index + 1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: c.onBackground,
                                    width: 2,
                                  )),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? primaryList[index]["primary"]
                                    : primaryList[index]["primaryDark"],
                                minRadius: 24,
                                child: Visibility(
                                  visible: selectedThemeId == index,
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: c.onBackground,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      enableDrag: true,
    );
  }
}
