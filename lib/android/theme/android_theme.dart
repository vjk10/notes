//ANDROID THEME SECTION//
import 'package:flutter/material.dart';
import 'package:notes/theme/colors.dart';

ThemeData androidThemeRegular = ThemeData(
  useMaterial3: true,
  backgroundColor: black,
  primaryColor: black,
  scaffoldBackgroundColor: black,
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: purple,
      primaryContainer: purple,
      onPrimary: white,
      onPrimaryContainer: white,
      secondary: darkGrey,
      secondaryContainer: darkGrey,
      onSecondary: lightGrey,
      onSecondaryContainer: lightGrey,
      tertiary: yellow,
      onTertiary: black,
      tertiaryContainer: grey,
      onTertiaryContainer: black,
      errorContainer: red,
      onErrorContainer: white,
      error: red,
      onError: white,
      background: black,
      onBackground: white,
      surface: lightBlack,
      onSurface: white),
  appBarTheme: AppBarTheme(
    backgroundColor: black,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline2: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline3: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline4: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline5: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline6: TextStyle(color: white, fontFamily: 'Theme Font'),
    subtitle1: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    subtitle2: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    bodyText1: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    bodyText2: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    caption: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    button: TextStyle(color: white, fontFamily: 'Theme Font'),
  ),
);

ThemeData androidThemePitchBlack = ThemeData(
  useMaterial3: true,
  backgroundColor: pitchblack,
  primaryColor: black,
  scaffoldBackgroundColor: pitchblack,
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: yellow,
      primaryContainer: yellow,
      onPrimary: black,
      onPrimaryContainer: black,
      secondary: grey,
      secondaryContainer: darkGrey,
      onSecondary: lightGrey,
      onSecondaryContainer: lightGrey,
      tertiary: red,
      onTertiary: black,
      tertiaryContainer: grey,
      onTertiaryContainer: white,
      errorContainer: red,
      onErrorContainer: white,
      error: red,
      onError: white,
      background: black,
      onBackground: white,
      surface: black,
      onSurface: white),
  appBarTheme: AppBarTheme(
    backgroundColor: pitchblack,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline2: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline3: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline4: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline5: TextStyle(color: white, fontFamily: 'Theme Font'),
    headline6: TextStyle(color: white, fontFamily: 'Theme Font'),
    subtitle1: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    subtitle2: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    bodyText1: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    bodyText2: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    caption: TextStyle(color: grey, fontFamily: 'Theme Regular'),
    button: TextStyle(color: white, fontFamily: 'Theme Font'),
  ),
);
