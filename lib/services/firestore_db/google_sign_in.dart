import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/android/widgets/notes_snackbar.dart';

import '../../data/data.dart';

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
      print("UID: ${user!.uid}");
    }
    NotesSnackBar()
        .successSnackBar("Hey ${user?.displayName!.split(' ')[0].toString()}");
  } catch (e) {
    if (e is FirebaseAuthException) {
      NotesSnackBar().errorSnackBar(e.message.toString());
      return StaticData.errorStatus;
    } else {
      if (kDebugMode) {
        print(e);
      }
      NotesSnackBar()
          .warningSnackBar("Something went wrong. Please try again!");
      return StaticData.warningStatus;
    }
  }

  return StaticData.successStatus;
}

Future<String> signOutGoogle(BuildContext context) async {
  await _auth.signOut();
  await _googleSignIn.signOut();
  NotesSnackBar().infoSnackBar('Successfully signed out of notes!');
  return "";
}
