import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:notes/android/theme/android_theme.dart';

class AppThemes {
  static const int regular = 0;
  static const int pitchblack = 1;
  static const int kindaRed = 2;
  static const int darkYellow = 3;
  static const int kindaWhite = 4;

  final String regularName = "assets/images/regularTheme.png";
  final String pitchblackName = "assets/images/pitchBlackTheme.png";
  final String kindaRedName = "assets/images/kindaRedTheme.png";
  final String darkYellowName = "assets/images/darkYellowTheme.png";
  final String kindaWhiteName = "assets/images/kindaWhiteTheme.png";

  String getThemeName(int currentId) {
    if (currentId == regular) {
      return regularName;
    }
    if (currentId == pitchblack) {
      return pitchblackName;
    }
    if (currentId == kindaRed) {
      return kindaRedName;
    }
    if (currentId == darkYellow) {
      return darkYellowName;
    }
    if (currentId == kindaWhite) {
      return kindaWhiteName;
    } else {
      return regularName;
    }
  }
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.regular: androidThemeRegular,
    AppThemes.pitchblack: androidThemePitchBlack,
    AppThemes.kindaRed: androidThemeKindaRed,
    AppThemes.darkYellow: androidThemeDarkYellow,
    AppThemes.kindaWhite: androidThemeKindaWhite,
  },
  fallbackTheme: androidThemeRegular,
);
