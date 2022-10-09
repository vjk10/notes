import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../data/data.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/onboarding2.png",
              width: (Get.statusBarHeight - 100).isNegative
                  ? Get.width - 50
                  : Get.width.w,
              fit: (Get.statusBarHeight - 100).isNegative
                  ? BoxFit.scaleDown
                  : BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: (Get.height / 9).h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "enter your name",
                        style: t.textTheme.headline4?.copyWith(
                          fontFamily: 'Theme Black',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: Get.width - 30,
                        height: 75,
                        child: Center(
                          child: Text(
                            onBoarding2Message,
                            style: t.textTheme.bodyText1?.copyWith(
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        textField: true,
                        attributedHint: AttributedString("name text field"),
                        child: Form(
                          key: _formKey,
                          child: SizedBox(
                            width: Get.width - 40,
                            child: TextFormField(
                              controller: _nameController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be emtpy";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide(
                                    color: c.surfaceVariant,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide(
                                    color: c.surfaceVariant,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide(
                                    color: c.error,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide(
                                    color: c.primary,
                                    width: 2,
                                  ),
                                ),
                                hintText: 'Your name here...',
                                hintStyle: t.textTheme.bodyText1?.copyWith(
                                  color: c.onSurfaceVariant,
                                ),
                                filled: true,
                                fillColor: c.surfaceVariant,
                                contentPadding: const EdgeInsets.all(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 130.w,
                        height: 60.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: c.primary,
                            elevation: 20,
                            shadowColor: c.background,
                          ),
                          onPressed: () async {
                            _formKey.currentState?.validate();
                            if (_nameController.text.isNotEmpty) {
                              await ScientISSTdb.instance
                                  .collection("userPref")
                                  .document("user")
                                  .set(
                                {
                                  "name": _nameController.text.toString(),
                                },
                              ).whenComplete(() {
                                Get.toNamed('/onboarding3');
                              });
                            } else {
                              HapticFeedback.heavyImpact();
                              Get.showSnackbar(GetSnackBar(
                                shouldIconPulse: false,
                                backgroundColor: Get.theme.colorScheme.surface,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                // borderRadius: 10,
                                icon: Icon(
                                  Icons.account_circle_rounded,
                                  color: c.error,
                                ),
                                duration: const Duration(seconds: 2),
                                messageText: Text(
                                  "We didn't get your name yet!",
                                  style: t.textTheme.caption
                                      ?.copyWith(color: c.onSurface),
                                ),
                              ));
                            }
                          },
                          child: Text(
                            "Next",
                            style: t.textTheme.button?.copyWith(
                              fontSize: 18.sp,
                              color: c.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
