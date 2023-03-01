//ANDROID THEME SECTION//
import 'package:flutter/material.dart';
import 'package:notes/theme/colors.dart';

ThemeData productiveTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  primaryColor: popWhite500,
  scaffoldBackgroundColor: popBlack500,
  fontFamily: 'Gilroy',
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Cirka',
      color: popWhite500,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Cirka',
      color: popWhite500,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Cirka',
      color: popWhite500,
      fontWeight: FontWeight.normal,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Cirka',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: popWhite500,
    onPrimary: popBlack500,
    secondary: poliPurple500,
    onSecondary: popBlack600,
    error: error,
    onError: popWhite500,
    background: popBlack500,
    onBackground: popWhite500,
    surface: popWhite500,
    onSurface: popBlack500,
    errorContainer: error.shade500,
    tertiary: success,
    onTertiary: popWhite500,
    tertiaryContainer: info,
    onTertiaryContainer: popWhite500,
    primaryContainer: warning,
    onPrimaryContainer: popWhite500,
  ).copyWith(background: popBlack500).copyWith(error: error),
);
