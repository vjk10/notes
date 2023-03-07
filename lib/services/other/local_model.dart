import 'package:flutter/material.dart';

class CreateItemOptions {
  final String title;
  final IconData icon;
  final String description;
  final Color mainColor;
  final Color subColor;
  final Function()? onTap;

  CreateItemOptions({
    required this.title,
    required this.icon,
    required this.description,
    required this.mainColor,
    required this.subColor,
    required this.onTap,
  });
}
