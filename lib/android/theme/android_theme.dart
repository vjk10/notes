//ANDROID THEME SECTION//
import 'package:flutter/material.dart';
import 'package:notes/theme/colors.dart';

ThemeData productiveTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  primaryColor: popWhite500,
  scaffoldBackgroundColor: popBlack500,
  fontFamily: 'Gilroy',
  dialogBackgroundColor: popWhite500,
  dialogTheme: DialogTheme(
    backgroundColor: popWhite500,
    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(popBlack500),
    fillColor: MaterialStateProperty.all(popWhite500),
    overlayColor: MaterialStateProperty.all(popWhite500),
    side: BorderSide(
      color: popWhite500,
      width: 2,
    ),
    materialTapTargetSize: MaterialTapTargetSize.padded,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontFamily: 'Cirka',
          fontWeight: FontWeight.bold,
          color: popBlack500,
        ),
      ),
      foregroundColor: MaterialStateProperty.all(popBlack500),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: poliPurple500,
    selectionColor: poliPurple500.withOpacity(0.5),
    selectionHandleColor: popWhite500,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Gilroy',
      color: popWhite500,
      fontWeight: FontWeight.normal,
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
      fontSize: 14,
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
    surface: popBlack400,
    onSurface: popBlack500,
    errorContainer: error.shade500,
    tertiary: success,
    onTertiary: popWhite500,
    tertiaryContainer: info,
    onTertiaryContainer: popWhite500,
    primaryContainer: warning,
    onPrimaryContainer: popWhite500,
    secondaryContainer: popBlack400,
    onSecondaryContainer: popWhite500,
    surfaceVariant: popBlack400,
    onSurfaceVariant: popWhite500,
  ).copyWith(background: popBlack500).copyWith(error: error),
);
