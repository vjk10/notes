import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/data/data.dart';

import '../firestore_db/user_model.dart';
import '../isar_db/onboarding_schema.dart';
import '../isar_db/user_schema.dart';

class AuthServices {
  Future<String> authChanges() async {
    late String change = StaticData.warningStatus;
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
        change = StaticData.errorStatus;
        StaticData.cameSignedIn = false;
        await StaticData.isarDb.userLocals.get(1).then((value) {
          StaticData.cameSignedIn = false;
          StaticData.uid = value!.id.toString();
          StaticData.displayname = value.displayname.toString();
          StaticData.email = value.email.toString();
          StaticData.phonenumber = value.phonenumber.toString();
          StaticData.dob = value.dob;
          StaticData.photourl = '';
          if (kDebugMode) {
            print("VALUE FROM LOCAL: $value");
          }
        });
      } else {
        if (kDebugMode) {
          print('User is signed in!');
          print('USERID: ${user.uid}');
        }
        change = StaticData.successStatus;
        StaticData.cameSignedIn = true;
        StaticData.uid = user.uid;
        StaticData.displayname = user.displayName.toString();
        StaticData.email = user.email.toString();
        StaticData.phonenumber = user.email.toString();
        StaticData.photourl = user.photoURL!;
        UserModelCollectionReference().doc(user.uid).get().then((value) {
          StaticData.dob = value.data!.dob.toString();
          StaticData.phonenumber = value.data!.phonenumber;
        });
      }
    });
    return change;
  }

  Future<String> createFirebaseUser(String uid, String displayname, String dob,
      String phonenumber, String email, String username) async {
    late String returnStatus;
    StaticData.cameSignedIn = true;
    UserModel userModel = UserModel(
        id: uid,
        displayname: displayname,
        dob: dob,
        phonenumber: phonenumber,
        email: email,
        username: username);
    if (kDebugMode) {
      print("USER ID: $uid");
    }
    await UserModelCollectionReference()
        .doc(uid)
        .set(userModel)
        .whenComplete(() {
      returnStatus = StaticData.successStatus;
    });
    return returnStatus;
  }

  Future<String> createLocalUser(String displayname, String dob,
      String phonenumber, String email, String username) async {
    late String returnStatus;
    StaticData.cameSignedIn = false;
    Onboarding onboarding = Onboarding();
    onboarding.id = 1;
    onboarding.onboarding = "true";
    UserLocal userLocal = UserLocal(
        displayname: displayname,
        dob: dob,
        phonenumber: phonenumber,
        email: email,
        username: username);
    await StaticData.isarDb.writeTxn(() async {
      await StaticData.isarDb.userLocals.put(userLocal).whenComplete(() async {
        await StaticData.isarDb.onboardings.put(onboarding).whenComplete(() {
          returnStatus = StaticData.successStatus;
        });
      });
    });
    return returnStatus;
  }

  Future<String> signOutLocalUser() async {
    late String returnStatus;
    await StaticData.isarDb.writeTxn(() async {
      await StaticData.isarDb.userLocals.delete(1).whenComplete(() {
        returnStatus = StaticData.successStatus;
      });
    });
    return returnStatus;
  }
}
