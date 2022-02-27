import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:notes/android/theme/android_theme.dart';

class AppThemes {
  static const int regular = 0;
  static const int pitchblack = 1;

  final String regularName = "assets/images/regularTheme.png";
  final String pitchblackName = "assets/images/pitchBlackTheme.png";

  String getThemeName(int currentId) {
    if (currentId == regular) {
      return regularName;
    }
    if (currentId == pitchblack) {
      return pitchblackName;
    } else {
      return regularName;
    }
  }
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.regular: androidThemeRegular,
    AppThemes.pitchblack: androidThemePitchBlack,
  },
  fallbackTheme: androidThemeRegular,
);
