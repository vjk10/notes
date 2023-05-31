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
    surface: popBlack300,
    onSurface: popWhite500,
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

ThemeData sketchThemeLight = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  primaryColor: lime,
  scaffoldBackgroundColor: lightWhite,
  fontFamily: 'PassionOne',
  dialogBackgroundColor: popWhite300,
  dialogTheme: DialogTheme(
    backgroundColor: popWhite300,
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
          fontFamily: 'PassionOne',
          fontWeight: FontWeight.bold,
          color: popBlack500,
        ),
      ),
      foregroundColor: MaterialStateProperty.all(popBlack500),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: lightBlack, width: 2),
      backgroundColor: lightWhite,
      foregroundColor: lightBlack,
      surfaceTintColor: lightWhite,
      textStyle: TextStyle(
        fontFamily: 'PassionOne',
        fontWeight: FontWeight.bold,
        color: lightBlack,
        fontSize: 24,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        backgroundColor: lime,
        foregroundColor: lightBlack,
        side: BorderSide(color: lightBlack, width: 2),
        textStyle: const TextStyle(
          fontFamily: 'PassionOne',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        )),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lime,
    selectionColor: lime.withOpacity(0.5),
    selectionHandleColor: lightWhite,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.normal,
    ),
    displayLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: lime,
    onPrimary: lightBlack,
    secondary: lightPink,
    onSecondary: lightBlack,
    error: error,
    onError: popWhite500,
    background: popBlack500,
    onBackground: lightBlack,
    surface: popWhite500,
    onSurface: popBlack500,
    errorContainer: error.shade500,
    tertiary: lightYellow,
    onTertiary: lightBlack,
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

ThemeData sketchThemeDark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  primaryColor: lime,
  scaffoldBackgroundColor: lightBlack,
  fontFamily: 'PassionOne',
  dialogBackgroundColor: popBlack300,
  dialogTheme: DialogTheme(
    backgroundColor: popWhite300,
    shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(popWhite300),
    fillColor: MaterialStateProperty.all(popBlack500),
    overlayColor: MaterialStateProperty.all(popBlack500),
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
          fontFamily: 'PassionOne',
          fontWeight: FontWeight.bold,
          color: popWhite300,
        ),
      ),
      foregroundColor: MaterialStateProperty.all(popWhite300),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: lightWhite, width: 2),
      backgroundColor: lightBlack,
      foregroundColor: lightWhite,
      surfaceTintColor: lightBlack,
      textStyle: TextStyle(
        fontFamily: 'PassionOne',
        fontWeight: FontWeight.bold,
        color: lightWhite,
        fontSize: 24,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        backgroundColor: lime,
        foregroundColor: lightWhite,
        side: BorderSide(color: lightWhite, width: 2),
        textStyle: const TextStyle(
          fontFamily: 'PassionOne',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        )),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lime,
    selectionColor: lime.withOpacity(0.5),
    selectionHandleColor: lightBlack,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.normal,
    ),
    displayLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontFamily: 'PassionOne',
      color: lightWhite,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: lime,
    onPrimary: lightWhite,
    secondary: lightPink,
    onSecondary: lightWhite,
    error: error,
    onError: popWhite500,
    background: lightBlack,
    onBackground: lightWhite,
    surface: Colors.black38,
    onSurface: popWhite500,
    surfaceTint: lightYellow,
    errorContainer: error.shade500,
    tertiary: lightYellow,
    onTertiary: lightWhite,
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
