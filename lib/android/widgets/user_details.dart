import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:notes/android/data/data.dart';
import 'package:unicons/unicons.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.userName,
    required bool accountLinked,
  })  : _accountLinked = accountLinked,
        super(key: key);

  final String userName;
  final bool _accountLinked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            UniconsLine.smile,
            color: c.onBackground,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              userName,
              style: t.textTheme.headline5,
            ),
          ),
          if (!_accountLinked)
            const SizedBox(
              height: 30,
            ),
          Visibility(
            visible: !_accountLinked,
            child: SignInButton(
              Buttons.Google,
              onPressed: () {},
              padding: const EdgeInsets.all(8),
              text: "  Sign in to backup notes",
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
