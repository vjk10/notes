import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/widgets/licenses_and_info.dart';
import 'package:scientisst_db/scientisst_db.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: c.surface,
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
          const SizedBox(
            width: 10,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
            child: const Text(
              "Read It Later",
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
            child: const Text(
              "View Documents",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
