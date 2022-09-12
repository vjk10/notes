import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';

class TCHtmlView extends StatefulWidget {
  const TCHtmlView({Key? key}) : super(key: key);

  @override
  State<TCHtmlView> createState() => _TCHtmlViewState();
}

class _TCHtmlViewState extends State<TCHtmlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        title: Text(
          "terms and conditions",
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
              child: tchtml,
            ),
          ],
        ),
      ),
    );
  }
}
