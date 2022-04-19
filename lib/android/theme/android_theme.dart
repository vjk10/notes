//ANDROID THEME SECTION//
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/services/imports.dart';
import 'package:notes/theme/colors.dart';

ThemeData androidThemeDark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  backgroundColor: black,
  primaryColor: black,
  scaffoldBackgroundColor: black,
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: purple,
      primaryContainer: purple,
      onPrimary: white,
      onPrimaryContainer: black,
      secondary: darkGrey,
      secondaryContainer: lightBlack,
      onSecondary: white,
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
    headline1:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: darkGrey,
    ),
    button: GoogleFonts.sourceSansPro(
        color: black, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);

ThemeData androidThemeRegular = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
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
    secondaryContainer: lightBlack,
    onSecondary: lightGrey,
    onSecondaryContainer: lightGrey,
    tertiary: yellow,
    onTertiary: black,
    tertiaryContainer: yellow,
    onTertiaryContainer: black,
    errorContainer: red,
    onErrorContainer: white,
    error: red,
    onError: white,
    background: black,
    onBackground: white,
    surface: lightBlack,
    onSurface: white,
    inversePrimary: purple,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: black,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: darkGrey,
    ),
    button: GoogleFonts.sourceSansPro(
        color: white, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);

ThemeData androidThemePitchBlack = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
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
    secondaryContainer: lightBlack,
    onSecondary: lightGrey,
    onSecondaryContainer: lightGrey,
    tertiary: red,
    onTertiary: black,
    tertiaryContainer: black,
    onTertiaryContainer: white,
    errorContainer: red,
    onErrorContainer: white,
    error: red,
    onError: white,
    background: pitchblack,
    onBackground: white,
    surface: lightBlack,
    onSurface: white,
    inversePrimary: yellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: pitchblack,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: darkGrey,
    ),
    button: GoogleFonts.sourceSansPro(
        color: white, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);

ThemeData androidThemeKindaRed = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  backgroundColor: kindaRedBackground,
  primaryColor: black,
  scaffoldBackgroundColor: kindaRedBackground,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: yellow,
    primaryContainer: yellow,
    onPrimary: black,
    onPrimaryContainer: black,
    secondary: grey,
    secondaryContainer: kindaRedSurface,
    onSecondary: lightGrey,
    onSecondaryContainer: lightGrey,
    tertiary: red,
    onTertiary: black,
    tertiaryContainer: darkYellowSurface,
    onTertiaryContainer: white,
    errorContainer: red,
    onErrorContainer: white,
    error: red,
    onError: white,
    background: kindaRedBackground,
    onBackground: white,
    surface: kindaRedSurface,
    onSurface: white,
    inversePrimary: yellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kindaRedBackground,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: kindaRedCaption,
    ),
    button: GoogleFonts.sourceSansPro(
        color: white, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);

ThemeData androidThemeDarkYellow = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  backgroundColor: darkYellowBackground,
  primaryColor: black,
  scaffoldBackgroundColor: darkYellowBackground,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: white,
    primaryContainer: yellow,
    onPrimary: black,
    onPrimaryContainer: black,
    secondary: red,
    secondaryContainer: darkYellowSurface,
    onSecondary: lightGrey,
    onSecondaryContainer: lightGrey,
    tertiary: lightGrey,
    onTertiary: black,
    tertiaryContainer: darkYellowTeritiary,
    onTertiaryContainer: white,
    errorContainer: red,
    onErrorContainer: white,
    error: red,
    onError: white,
    background: darkYellowBackground,
    onBackground: white,
    surface: darkYellowSurface,
    onSurface: white,
    inversePrimary: yellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkYellowBackground,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: white, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: grey,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: darkYellowCaption,
    ),
    button: GoogleFonts.sourceSansPro(
        color: white, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);

ThemeData androidThemeKindaWhite = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  backgroundColor: lightGrey,
  primaryColor: purple,
  scaffoldBackgroundColor: lightGrey,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: purple,
    primaryContainer: purple,
    onPrimary: black,
    onPrimaryContainer: black,
    secondary: grey,
    secondaryContainer: kindaWhiteSurface,
    onSecondary: black,
    onSecondaryContainer: pitchblack,
    tertiary: black,
    onTertiary: white,
    tertiaryContainer: lightGrey,
    onTertiaryContainer: black,
    errorContainer: red,
    onErrorContainer: white,
    error: red,
    onError: white,
    background: lightGrey,
    onBackground: black,
    surface: kindaWhiteSurface,
    onSurface: black,
    inversePrimary: purple,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightGrey,
    toolbarHeight: 80,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline2:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline3:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline4:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline5:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    headline6:
        GoogleFonts.sourceSansPro(color: black, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    subtitle2: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    bodyText1: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    bodyText2: GoogleFonts.sourceSansPro(
      color: lightBlack,
    ),
    caption: GoogleFonts.sourceSansPro(
      color: kindaWhiteCaption,
    ),
    button: GoogleFonts.sourceSansPro(
        color: black, fontWeight: FontWeight.w600, fontSize: 18),
  ),
);
