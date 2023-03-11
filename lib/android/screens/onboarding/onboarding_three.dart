import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:notes/android/widgets/notes_snackbar.dart';
import 'package:notes/data/data.dart';
import 'package:notes/services/firestore_db/google_sign_in.dart';
import 'package:notes/services/other/auth_services.dart';
import 'package:pattern_formatter/date_formatter.dart';

import '../../../notes_icon_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/colors.dart';
import '../main_screen.dart';

class Onboarding3 extends StatefulWidget {
  final bool cameSignedIn;
  const Onboarding3({Key? key, required this.cameSignedIn}) : super(key: key);

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  late String returnValue;

  @override
  void initState() {
    if (widget.cameSignedIn) {
      initUser();
      setState(() {
        StaticData.cameSignedIn = widget.cameSignedIn;
      });
    }
    super.initState();
  }

  initUser() async {
    user = FirebaseAuth.instance.currentUser;
    nameController.text = user!.displayName.toString();
    phoneNumController.text = user!.phoneNumber.toString();
    emailController.text = user!.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            NotesIcon.button_arrow_left,
            size: 12,
            color: StaticData.c.primary,
          ),
          color: StaticData.c.primary,
          onPressed: () {
            signOutGoogle(context);
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (widget.cameSignedIn) {
            if (user!.uid.isNotEmpty) {
              await signOutGoogle(context);
              return true;
            } else {
              return true;
            }
          } else {
            return true;
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.hardEdge,
            children: [
              SvgPicture.asset("assets/images/waves_orange.svg"),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'setup your profile',
                            style: StaticData.t.textTheme.headlineMedium
                                ?.copyWith(fontFamily: 'Cirka'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            "assets/images/system error.svg",
                            width: 52,
                            height: 52,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'John Doe',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixText: 'Hey! ',
                                prefixStyle: StaticData.t.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: dobController,
                              keyboardType: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                DateInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                hintText: 'DD/MM/YYYY',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixText: 'DOB: ',
                                prefixStyle: StaticData.t.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: phoneNumController,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: '987456321',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixText: '+91   ',
                                prefixStyle: StaticData.t.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'johndoe@email.com',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixText: 'to:    ',
                                prefixStyle: StaticData.t.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: useridController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              maxLength: 20,
                              decoration: InputDecoration(
                                hintText: '@johndoe',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                prefixText: '@      ',
                                prefixStyle: StaticData.t.textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Hero(
                              tag: StaticData.mainButtonTag,
                              child: SizedBox(
                                width: 189,
                                height: 48,
                                child: NeoPopButton(
                                  animationDuration:
                                      const Duration(milliseconds: 250),
                                  color: popWhite500,
                                  onTapDown: () => HapticFeedback.vibrate(),
                                  onTapUp: () async {
                                    if (widget.cameSignedIn) {
                                      returnValue = await AuthServices()
                                          .createFirebaseUser(
                                        StaticData.uid,
                                        nameController.text,
                                        dobController.text,
                                        phoneNumController.text,
                                        emailController.text,
                                        useridController.text,
                                      );
                                    } else {
                                      returnValue =
                                          await AuthServices().createLocalUser(
                                        nameController.text,
                                        dobController.text,
                                        phoneNumController.text,
                                        emailController.text,
                                        useridController.text,
                                      );
                                    }
                                    if (kDebugMode) {
                                      print("Return Status: $returnValue");
                                    }
                                    if (returnValue ==
                                        StaticData.successStatus) {
                                      NotesSnackBar().successSnackBar(
                                          'Successfully signed into notes!');
                                      Get.offAll(() =>
                                          const MainScreen(selectedIndex: 0));
                                    } else {
                                      NotesSnackBar().errorSnackBar(
                                          'Something went wrong. Please try again!');
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "create user",
                                        style: StaticData.t.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: popBlack600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Icon(
                                        NotesIcon.button_arrow_right,
                                        color: popBlack500,
                                        size: 6,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
