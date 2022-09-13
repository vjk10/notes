import 'dart:io';

import 'package:about/about.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/licenses_and_info.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/android/widgets/user_details.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/database_service.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/google_sign_in.dart';
import 'package:notes/services/utils.dart';
import 'package:notes/theme/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/providers/android_app_themes.dart';

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

  late AnimationController _bottomSheetController;

  late TextStyle topBarTextStyle;

  bool styleExpanded = true;

  @override
  void initState() {
    _bottomSheetController = AnimationController(vsync: this);
    themesList = themes.toList();
    _initPrefs();
    getTheme();
    getSaveStatus();
    getUserStatus();
    getCacheMemory();
    super.initState();
  }

  _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  getTheme() async {
    try {
      var themeID = DynamicTheme.of(context)!.themeId;
      setState(() {
        selectedThemeId = themeID;
        selectedTheme = AppThemes().getThemeName(themeID);
      });

      if (kDebugMode) {
        print("SELECTED THEME: $selectedTheme");
      }
    } catch (e) {
      var pref = await SharedPreferences.getInstance();
      selectedThemeId = pref.getInt('selectedThemeId')!;
      if (kDebugMode) {
        print("Selected Theme: $selectedThemeId");
      }
      if (selectedTheme.isEmpty) {
        setState(() {
          selectedTheme = AppThemes().getThemeName(selectedThemeId);
        });
      }
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
                  child: NotesLoadingAndroid(),
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
                        "settings",
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
              style: t.textTheme.button,
            ),
            subtitle: Text(
              "Supported devices will pick the theme \ndynamically from your system wallpaper",
              style: t.textTheme.labelSmall,
            ),
            trailing: Switch(
                activeColor: c.primary,
                inactiveThumbColor: c.secondary,
                inactiveTrackColor: c.tertiaryContainer,
                value: notifier.material3,
                onChanged: (value) async {
                  HapticFeedback.heavyImpact();
                  notifier.toggleTheme();
                  selectedThemeId = _pref.getInt('selectedThemeId')!;
                  if (kDebugMode) {
                    print("Selected Theme: $selectedThemeId");
                  }
                  if (selectedTheme.isEmpty) {
                    setState(() {
                      selectedTheme = AppThemes().getThemeName(selectedThemeId);
                    });
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
            style: t.textTheme.button?.copyWith(
              fontSize: 14,
              color: c.onBackground,
            ),
          ),
          subtitle: Text(
            "Disabling auto save will require you to \nmanually save notes",
            style: t.textTheme.labelSmall,
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
            style: t.textTheme.button,
          ),
          subtitle: Text(
            "The currency to be used in Expense Tracker \ncan be selected here",
            style: t.textTheme.labelSmall,
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
            style: t.textTheme.button,
          ),
          subtitle: Text(
            "Import notes from your Google Account to offline storage",
            style: t.textTheme.labelSmall,
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
            style: t.textTheme.button,
          ),
          subtitle: Text(
            "Total storage used by notes app \nas a whole",
            style: t.textTheme.labelSmall,
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
            style: t.textTheme.button,
          ),
          subtitle: Text(
            "On doing this all notes local and imported \nwill be cleared",
            style: t.textTheme.labelSmall,
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
            showAbout();
          },
          leading: Icon(
            Icons.tips_and_updates_outlined,
            color: c.onBackground,
          ),
          title: Text(
            "About and Info",
            style: t.textTheme.button,
          ),
          subtitle: Text(
            "v$version \nbuild: $buildNumber",
            style: t.textTheme.labelSmall,
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
          "Choose Theme",
          style: t.textTheme.button,
        ),
        subtitle: Text(
          "Choose from our list of themes to \nchange the look of notes",
          style: t.textTheme.labelSmall,
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
    );
  }

  void showThemeSheet() {
    Get.bottomSheet(
      SizedBox(
        height: Get.height / 2,
        child: BottomSheet(
          animationController: _bottomSheetController,
          enableDrag: true,
          backgroundColor: c.background,
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
                  height: Get.height / 3,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              : c.onBackground.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            themesList[index]["name"]
                                                .toString(),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_left,
                              color: c.onBackground,
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: c.onBackground,
                            ),
                          ],
                        ),
                      ],
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

  void showAbout() {
    showAboutPage(
      context: context,
      title: const Text('about'),
      applicationName: Utils().getAppName(packageName),
      applicationVersion: 'v $version (build $buildNumber)',
      children: <Widget>[
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.notes_outlined,
          ),
          title: Text('View Readme'),
          filename: 'README.md',
        ),
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.track_changes_outlined,
          ),
          title: Text('Read Changelog'),
          filename: 'CHANGELOG.md',
        ),
        const LicensesPageListTile(
          title: Text("View Licenses"),
          icon: Icon(
            Icons.public,
          ),
        ),
        const MarkdownPageListTile(
          shrinkWrap: true,
          icon: Icon(
            Icons.handshake_outlined,
          ),
          title: Text('View Contributing'),
          filename: 'CONTRIBUTING.md',
        ),
      ],
    );
  }
}
