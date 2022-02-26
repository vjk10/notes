import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/data.dart';

class NoNotesFound extends StatelessWidget {
  const NoNotesFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/Document.png",
            width: Get.width - 30,
            height: Get.width - 30,
          ),
          Text(
            "No notes found!",
            style: t.textTheme.headline6,
          ),
          SizedBox(
            height: Get.height / 6,
          ),
        ],
      ),
    );
  }
}
