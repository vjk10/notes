import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/android/data/data.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
late String deviceToken;

Future<String> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final User? user = (await _auth.signInWithCredential(authCredential)).user;
    assert(!user!.isAnonymous);
    final User? currentUser = _auth.currentUser;
    assert(user!.uid == currentUser!.uid);
    assert(user!.email != null);
    assert(user!.photoURL != null);
    if (kDebugMode) {
      print("UID: " + user!.uid);
    }

    FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
      "uid": user?.uid,
      "name": user?.displayName,
      "email": user?.email
    }).whenComplete(() {
      Get.showSnackbar(
        GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.person_rounded,
            color: c.primary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Successfully Signed in to notes!",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
        ),
      );
    });
  } catch (e) {
    if (e is FirebaseAuthException) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: c.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: const Text(
                  "Error",
                ),
                content: Text(
                  e.message.toString(),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "OK",
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              ));
    } else {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: c.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: const Text(
                  "Error",
                ),
                content: const Text(
                  "Something went wrong! Please try again!",
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "OK",
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              ));
    }
  }

  return "";
}

Future<String> signOutGoogle(BuildContext context) async {
  await _auth.signOut();
  await _googleSignIn.signOut();
  Get.showSnackbar(
    GetSnackBar(
      shouldIconPulse: false,
      backgroundColor: c.surface,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      borderRadius: 10,
      icon: Icon(
        Icons.logout_rounded,
        color: c.error,
      ),
      duration: const Duration(seconds: 2),
      messageText: Text(
        "Successfully signed out from notes!",
        style: t.textTheme.caption?.copyWith(color: c.onSurface),
      ),
    ),
  );
  return "";
}
