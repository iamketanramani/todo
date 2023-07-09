import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor appThemeColor = MaterialColor(
    0xFF1da0f2, //Change statusBarColor from here
    <int, Color>{
      50: Color(0xFFe1f1fc),
      100: Color(0xFFb6dcf9),
      200: Color(0xFF87c7f6),
      300: Color(0xFF53b1f3),
      400: Color(0xFF1da0f2),
      500: Color(0xFF0091f0),
      600: Color(0xFF0083e2),
      700: Color(0xFF0071d0),
      800: Color(0xFF0060be),
      900: Color(0xFF00439f),
    },
  );

  static MaterialColor createMaterialColor(Color color) {
    // https://medium.com/@nickysong/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static Color cyan = Colors.cyan;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color green = const Color(0xFF07BA31);
  static Color cursorColor = const Color(0xFF444444);
  static Color backgroundColor = const Color(0xFFFFFFFF);

  static Color primaryColor = const Color(0xFF1DA1F2);
  static Color primaryColorLight = const Color(0xFFEDF8FF);
  static Color hintColor = const Color(0xFF949C9E);
  static Color borderColor = const Color(0xFFE5E5E5);
  static Color dividerColor = const Color(0xFFF2F2F2);
  static Color textColor = const Color(0xFF323238);
  static Color redColor = const Color(0xFFF34642);

  static Color secondaryColor = const Color(0xFFFFCE03);
  static Color tertiaryColor = const Color(0xFFFFCE03);
  static Color grayColor = const Color(0xFFcccccc);
  static Color colorC = const Color(0xFFCCCCCC);
  static Color dropShadow = const Color(0xFF000012);
}
