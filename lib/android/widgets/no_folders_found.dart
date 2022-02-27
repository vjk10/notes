import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';

class NoFoldersFound extends StatelessWidget {
  const NoFoldersFound({
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
            "assets/images/nofolders.png",
            width: Get.width / 2,
            height: Get.width / 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "no folders found!",
            style: t.textTheme.headline6?.copyWith(color: c.secondary),
          ),
          SizedBox(
            height: Get.height / 6,
          ),
        ],
      ),
    );
  }
}
