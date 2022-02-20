import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../data/data.dart';

class FoldersView extends StatefulWidget {
  const FoldersView({Key? key}) : super(key: key);

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: FloatingActionButton.large(
          heroTag: "folderTag",
          onPressed: () {},
          backgroundColor: c.primary,
          child: Center(
            child: Icon(
              UniconsLine.folder_plus,
              color: c.onPrimary,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Folders"),
            ],
          ),
        ),
      ),
    );
  }
}
