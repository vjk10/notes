import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/views/misc/pp_html_view.dart';
import 'package:notes/android/views/misc/tc_html_view.dart';

import '../data/data.dart';

class LicensesAndInfo extends StatefulWidget {
  const LicensesAndInfo({Key? key}) : super(key: key);

  @override
  State<LicensesAndInfo> createState() => _LicensesAndInfoState();
}

class _LicensesAndInfoState extends State<LicensesAndInfo> {
  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: Get.width - 50,
        height: Get.height / 2,
        decoration: BoxDecoration(
          color: c.background,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width - 70,
              height: 75,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: c.primary,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                ),
                onPressed: () {
                  Get.to(() => const PPHtmlView());
                },
                icon: Icon(
                  Icons.policy_outlined,
                  color: c.onPrimary,
                ),
                label: Text(
                  "Privacy Policy",
                  style: t.textTheme.button?.copyWith(
                    color: c.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width - 70,
              height: 75,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: c.primary,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                ),
                onPressed: () {
                  Get.to(() => const TCHtmlView());
                },
                icon: Icon(
                  Icons.gavel_outlined,
                  color: c.onPrimary,
                ),
                label: Text(
                  "Terms & Conditions",
                  style: t.textTheme.button?.copyWith(
                    color: c.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width - 70,
              height: 75,
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: c.primary,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(25),
                    // ),
                  ),
                  onPressed: () {
                    navToLicense();
                  },
                  icon: Icon(
                    Icons.lightbulb_outline,
                    color: c.onPrimary,
                  ),
                  label: Text(
                    "Licenses",
                    style: t.textTheme.button?.copyWith(
                      color: c.onPrimary,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void navToLicense() {
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
              children: [
                Text(
                  "notes",
                  style: t.textTheme.headline6?.copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            applicationLegalese: "Simple notes taking app",
            applicationName: " ",
            applicationVersion: "v$version (build v$buildNumber)",
          ),
        ));
  }
}
