import 'dart:io';

import 'package:notes/services/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotesWebView extends StatefulWidget {
  final String uri, appBarTitle;
  const NotesWebView({Key? key, required this.uri, required this.appBarTitle})
      : super(key: key);

  @override
  State<NotesWebView> createState() => _NotesWebViewState();
}

class _NotesWebViewState extends State<NotesWebView> {
  double progress = 0;
  late String uri, appBarTitle;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    setState(() {
      uri = widget.uri;
      appBarTitle = widget.appBarTitle;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        bottom: PreferredSize(
            child: Visibility(
              visible: progress != 100,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: c.onBackground.withOpacity(
                  0.5,
                ),
                color: c.primary,
              ),
            ),
            preferredSize: Size(Get.width, 0)),
      ),
      body: WebView(
        onProgress: (value) {
          setState(() {
            progress = value.toDouble();
          });
        },
        initialUrl: uri,
      ),
    );
  }
}
