import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';
import 'package:unicons/unicons.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.userProfile,
    required this.userName,
  }) : super(key: key);

  final String userProfile;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: c.tertiary,
          child: userProfile.isNotEmpty
              ? Image.network(userProfile)
              : Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: c.tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    UniconsLine.user_circle,
                    color: c.onTertiaryContainer,
                  ),
                ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          userName,
          style: t.textTheme.button,
        ),
      ],
    );
  }
}
