import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

//-------------//
// BASE-COLORS //
//-------------//
MaterialColor popBlack600 = MaterialColor(0xFF0D0D0D, color);
MaterialColor popBlack500 = MaterialColor(0xFF0D0D0D, color);
MaterialColor popBlack400 = MaterialColor(0xFF121212, color);
MaterialColor popBlack300 = MaterialColor(0xFF161616, color);
MaterialColor popBlack200 = MaterialColor(0xFF3D3D3D, color);
MaterialColor popBlack100 = MaterialColor(0xFF8A8A8A, color);

MaterialColor popWhite500 = MaterialColor(0xFFFFFFFF, color);
MaterialColor popWhite400 = MaterialColor(0xFFFBFBFB, color);
MaterialColor popWhite300 = MaterialColor(0xFFEFEFEF, color);
MaterialColor popWhite200 = MaterialColor(0xFFE0E0E0, color);
MaterialColor popWhite100 = MaterialColor(0xFFD2D2D2, color);

//-----------------//
// SEMANTIC-COLORS //
//-----------------//
MaterialColor error = MaterialColor(0xFFEE4D37, color);
MaterialColor warning = MaterialColor(0xFFF08D32, color);
MaterialColor info = MaterialColor(0xFF144CC7, color);
MaterialColor success = MaterialColor(0xFF06C270, color);

//-------------//
// MORE-COLORS //
//-------------//
MaterialColor poliPurple800 = MaterialColor(0xFF20104D, color);
MaterialColor poliPurple700 = MaterialColor(0xFF351A80, color);
MaterialColor poliPurple600 = MaterialColor(0xFF4A25B3, color);
MaterialColor poliPurple500 = MaterialColor(0xFF6A35FF, color);
MaterialColor poliPurple400 = MaterialColor(0xFF9772FF, color);
MaterialColor poliPurple300 = MaterialColor(0xFFB49AFF, color);
MaterialColor poliPurple200 = MaterialColor(0xFFD2C2FF, color);
MaterialColor poliPurple100 = MaterialColor(0xFFE8DFFF, color);

MaterialColor rss800 = MaterialColor(0xFF4D2914, color);
MaterialColor rss700 = MaterialColor(0xFF804322, color);
MaterialColor rss600 = MaterialColor(0xFFB35F30, color);
MaterialColor rss500 = MaterialColor(0xFFFF8744, color);
MaterialColor rss400 = MaterialColor(0xFFFFAB7C, color);
MaterialColor rss300 = MaterialColor(0xFFFFC3A2, color);
MaterialColor rss200 = MaterialColor(0xFFFFDBC7, color);
MaterialColor rss100 = MaterialColor(0xFFFFEFE6, color);

MaterialColor pinkPong800 = MaterialColor(0xFF4D1421, color);
MaterialColor pinkPong700 = MaterialColor(0xFF802138, color);
MaterialColor pinkPong600 = MaterialColor(0xFFB32E4E, color);
MaterialColor pinkPong500 = MaterialColor(0xFFFF426F, color);
MaterialColor pinkPong400 = MaterialColor(0xFFFF7B9A, color);
MaterialColor pinkPong300 = MaterialColor(0xFFFFA0B7, color);
MaterialColor pinkPong200 = MaterialColor(0xFFFFC6D4, color);
MaterialColor pinkPong100 = MaterialColor(0xFFFFE1E9, color);

MaterialColor manna800 = MaterialColor(0xFF4D3D15, color);
MaterialColor manna700 = MaterialColor(0xFF806623, color);
MaterialColor manna600 = MaterialColor(0xFFB38E30, color);
MaterialColor manna500 = MaterialColor(0xFFFFCB45, color);
MaterialColor manna400 = MaterialColor(0xFFFFDB7D, color);
MaterialColor manna300 = MaterialColor(0xFFFFE5A2, color);
MaterialColor manna200 = MaterialColor(0xFFFFEFC7, color);
MaterialColor manna100 = MaterialColor(0xFFFFF8E5, color);

MaterialColor neoPacha800 = MaterialColor(0xFF454C13, color);
MaterialColor neoPacha700 = MaterialColor(0xFF727F20, color);
MaterialColor neoPacha600 = MaterialColor(0xFFA0B22D, color);
MaterialColor neoPacha500 = MaterialColor(0xFFE5FE40, color);
MaterialColor neoPacha400 = MaterialColor(0xFFEDFE79, color);
MaterialColor neoPacha300 = MaterialColor(0xFFF7FFC6, color);
MaterialColor neoPacha200 = MaterialColor(0xFFF7FFC6, color);
MaterialColor neoPacha100 = MaterialColor(0xFFFBFFE6, color);

MaterialColor yoyo800 = MaterialColor(0xFF33134D, color);
MaterialColor yoyo700 = MaterialColor(0xFF552080, color);
MaterialColor yoyo600 = MaterialColor(0xFF772CB3, color);
MaterialColor yoyo500 = MaterialColor(0xFFAA3FFF, color);
MaterialColor yoyo400 = MaterialColor(0xFFC379FF, color);
MaterialColor yoyo300 = MaterialColor(0xFFD59FFF, color);
MaterialColor yoyo200 = MaterialColor(0xFFE5C5FF, color);
MaterialColor yoyo100 = MaterialColor(0xFFF4E5FF, color);

MaterialColor pakGreen800 = MaterialColor(0xFF124D34, color);
MaterialColor pakGreen700 = MaterialColor(0xFF1E8057, color);
MaterialColor pakGreen600 = MaterialColor(0xFF29B379, color);
MaterialColor pakGreen500 = MaterialColor(0xFF3BFFAD, color);
MaterialColor pakGreen400 = MaterialColor(0xFF76FFC6, color);
MaterialColor pakGreen300 = MaterialColor(0xFF9DFFD6, color);
MaterialColor pakGreen200 = MaterialColor(0xFFC4FFE6, color);
MaterialColor pakGreen100 = MaterialColor(0xFFDDFFF1, color);

//DISCONTINUED
MaterialColor winYellow600 = MaterialColor(0xFFCDB900, color);
MaterialColor winYellow500 = MaterialColor(0xFFFFEB34, color);
MaterialColor winYellow400 = MaterialColor(0xFFFFF066, color);

//OLD-THEME
MaterialColor black = MaterialColor(0xFF1F1D2C, color);
MaterialColor pitchblack = MaterialColor(0xFF000000, color);
MaterialColor darkGrey = MaterialColor(0xFF474755, color);
MaterialColor grey = MaterialColor(0xFFB4B4B4, color);
MaterialColor lightGrey = MaterialColor(0xFFEEEEEE, color);
MaterialColor white = MaterialColor(0xFFFFFFFF, color);
MaterialColor red = MaterialColor(0xFFB24E4E, color);
MaterialColor purple = MaterialColor(0xFF706FC8, color);
MaterialColor yellow = MaterialColor(0xFFFFC14B, color);
MaterialColor green = MaterialColor(0xFF7CDC4F, color);
MaterialColor pink = MaterialColor(0xFFf08080, color);
MaterialColor paleGreen = MaterialColor(0xFFabc4ab, color);
MaterialColor ash = MaterialColor(0xFF202020, color);
MaterialColor lightBlack = MaterialColor(0xFF272636, color);
MaterialColor kindaRedBackground = MaterialColor(0xFF311717, color);
MaterialColor kindaRedSurface = MaterialColor(0xFF421F1F, color);
MaterialColor darkYellowBackground = MaterialColor(0xFF261C00, color);
MaterialColor darkYellowSurface = MaterialColor(0xFF2D2100, color);
MaterialColor darkYellowTeritiary = MaterialColor(0xFF3F2D00, color);
MaterialColor kindaWhiteSurface = MaterialColor(0xFFF3F3F3, color);
MaterialColor kindaRedCaption = MaterialColor(0xFF874646, color);
MaterialColor darkYellowCaption = MaterialColor(0xFF755600, color);
MaterialColor kindaWhiteCaption = MaterialColor(0xFFB2B2B2, color);
