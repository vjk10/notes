// #45

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:peekanapp/peekanapp.dart';
import '../../services/utils.dart';
import '../data/data.dart';

class AppUpdate extends StatefulWidget {
  final String currentVersion;
  final String packageName;
  const AppUpdate(
      {Key? key, required this.currentVersion, required this.packageName})
      : super(key: key);

  @override
  State<AppUpdate> createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  // #45
  AppUpdateInfo? _updateInfo;
  late Widget releaseNotes;
  String version = "";
  String buildNumber = "";
  bool _isLoading = true;
  PeekanappClient peekanapp = PeekanappClient();

  @override
  void initState() {
    checkForUpdate();
    super.initState();
    if (kDebugMode) {
      print("Update INFO: ${_updateInfo?.updateAvailability}");
    }
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    setState(() {
      _isLoading = true;
    });
// fetch information about an app on the Play Store
    await Utils().fetchPlaystoreData(widget.packageName).then((value) {
      releaseNotes = Html(data: value.recentChanges);
      version = value.version;
    }, onError: (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      InAppUpdate.checkForUpdate().then((info) async {
        setState(() {
          _isLoading = false;
          _updateInfo = info;
        });
      }).catchError(
        (e) async {
          setState(() {
            _isLoading = false;
            _updateInfo = AppUpdateInfo(
              kDebugMode
                  ? UpdateAvailability.updateAvailable
                  : UpdateAvailability.updateNotAvailable,
              false,
              false,
              kDebugMode ? 25 : 0,
              InstallStatus.unknown,
              packageName,
              null,
              0,
            );
          });
        },
      );
    });

    if (kDebugMode) {
      print("UPDATE AVAILABLE: ${_updateInfo?.updateAvailability}");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    t = Theme.of(context);
    c = t.colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Icon(
                        _isLoading
                            ? Icons.system_security_update_outlined
                            : _updateInfo?.updateAvailability ==
                                    UpdateAvailability.updateNotAvailable
                                ? Icons.system_security_update_good_outlined
                                : Icons.system_security_update_outlined,
                        color: c.primary,
                        size: 48,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        _isLoading
                            ? 'Checking for updates'
                            : _updateInfo?.updateAvailability ==
                                    UpdateAvailability.updateNotAvailable
                                ? 'Your app is in the latest version'
                                : 'Update available',
                        style: t.textTheme.headlineSmall,
                      ),
                      Visibility(
                        visible: _updateInfo?.updateAvailability ==
                            UpdateAvailability.updateAvailable,
                        child: const SizedBox(
                          height: 30,
                        ),
                      ),
                      _isLoading
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 150,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 50.0, horizontal: 55),
                                    child: SizedBox(
                                        width: Get.width / 2,
                                        height: Get.width / 2,
                                        child: const NotesLoadingAndroid(
                                          strokeWidth: 10,
                                        )),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: _updateInfo?.updateAvailability ==
                                      UpdateAvailability.updateAvailable,
                                  child: Text(
                                    "What's new",
                                    style: t.textTheme.button?.copyWith(
                                      color: c.primary,
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Visibility(
                                  visible: _updateInfo?.updateAvailability ==
                                      UpdateAvailability.updateAvailable,
                                  child: const SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Visibility(
                                  visible: _updateInfo?.updateAvailability ==
                                      UpdateAvailability.updateAvailable,
                                  child: SizedBox(
                                      width: Get.width / 1.5,
                                      child: releaseNotes),
                                ),
                                Visibility(
                                  visible: _updateInfo?.updateAvailability ==
                                      UpdateAvailability.updateAvailable,
                                  child: const SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Visibility(
                                  visible: _updateInfo?.updateAvailability ==
                                      UpdateAvailability.updateAvailable,
                                  child: Text(
                                    "New Version :  $version",
                                    style: t.textTheme.button
                                        ?.copyWith(color: c.primary),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Current Version :  ${widget.currentVersion}",
                                  style: t.textTheme.button
                                      ?.copyWith(color: c.onBackground),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                right: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Visibility(
                      visible: _updateInfo?.updateAvailability !=
                          UpdateAvailability.updateAvailable,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: c.primaryContainer,
                              elevation: 0,
                              shadowColor: c.shadow,
                              foregroundColor: c.onPrimaryContainer,
                            ),
                            child: Text(
                              'Check for Update',
                              style: t.textTheme.labelLarge?.copyWith(
                                color: c.onPrimaryContainer,
                              ),
                            ),
                            onPressed: () {
                              checkForUpdate();
                            }),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _updateInfo?.updateAvailability ==
                        UpdateAvailability.updateAvailable,
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.primaryContainer,
                          elevation: 0,
                          shadowColor: c.shadow,
                          foregroundColor: c.onPrimaryContainer,
                        ),
                        onPressed: () {
                          InAppUpdate.performImmediateUpdate().catchError((e) {
                            Get.showSnackbar(
                              GetSnackBar(
                                messageText: Text(e.toString()),
                              ),
                            );
                          });
                        },
                        child: Text(
                          'Update Now',
                          style: t.textTheme.labelLarge?.copyWith(
                            color: c.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Visibility(
                  //   visible: _updateInfo?.updateAvailability ==
                  //       UpdateAvailability.updateAvailable,
                  //   child: SizedBox(
                  //     width: 150,
                  //     child: OutlinedButton(
                  //       onPressed: () {
                  //         InAppUpdate.startFlexibleUpdate().then((_) {
                  //           setState(() {
                  //             _flexibleUpdateAvailable = true;
                  //           });
                  //         }).catchError((e) {
                  //           Get.showSnackbar(
                  //             GetSnackBar(
                  //               messageText: Text(e.toString()),
                  //             ),
                  //           );
                  //         });
                  //       },
                  //       child: Text(
                  //         'Start flexible update',
                  //         style: t.textTheme.button?.copyWith(
                  //           color: c.primary,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Visibility(
                  //   visible: !_flexibleUpdateAvailable,
                  //   child: SizedBox(
                  //     width: 150,
                  //     child: OutlinedButton(
                  //       onPressed: () {
                  //         InAppUpdate.completeFlexibleUpdate().then((_) {
                  //           Get.showSnackbar(
                  //             const GetSnackBar(
                  //               messageText: Text('Successfully Updated!'),
                  //             ),
                  //           );
                  //         }).catchError((e) {
                  //           Get.showSnackbar(
                  //             GetSnackBar(
                  //               messageText: Text(e.toString()),
                  //             ),
                  //           );
                  //         });
                  //       },
                  //       child: Text(
                  //         'Complete flexible update',
                  //         style: t.textTheme.button?.copyWith(
                  //           color: c.primary,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
