import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';

class PPHtmlView extends StatefulWidget {
  const PPHtmlView({Key? key}) : super(key: key);

  @override
  State<PPHtmlView> createState() => _PPHtmlViewState();
}

class _PPHtmlViewState extends State<PPHtmlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        title: Text(
          "privacy policy",
          style: t.textTheme.headline5,
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed('/mainScreen');
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: c.onBackground,
            )),
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: pphtml,
            ),
          ],
        ),
      ),
    );
  }
}
