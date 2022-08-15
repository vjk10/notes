import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key, required this.userName, this.profileUrl = ""})
      : super(key: key);

  final String userName, profileUrl;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.profileUrl.isEmpty)
            Icon(
              Icons.emoji_emotions_rounded,
              color: c.onBackground,
              size: 35,
            ),
          if (widget.profileUrl.isNotEmpty)
            CircleAvatar(
              radius: 35,
              backgroundColor: c.primary,
              backgroundImage: NetworkImage(widget.profileUrl),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              widget.userName,
              style: t.textTheme.button,
            ),
          ),
        ],
      ),
    );
  }
}
