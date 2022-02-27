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
            "assets/images/nonotes.png",
            width: Get.width / 2,
            height: Get.width / 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "no notes found!",
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
