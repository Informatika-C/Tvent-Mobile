import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: const Color(0XFFE67E22),
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Montserrat',
    colorScheme: const ColorScheme.light(
      background: Color(0XFFE1DCD1),
      primary: Color(0XFF1E2126),
      tertiary: Color(0XFFf2f2f2),
      scrim: Color(0XFFFFA500),
      secondary: Color(0XFF06142E),
      surface: Colors.white,
      inverseSurface: Color.fromARGB(255, 99, 83, 83),
      surfaceVariant: Color(0XFFbd83b8),
    ),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: const Color(0XFF262A32),
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Montserrat',
    colorScheme: const ColorScheme.dark(
      background: Color(0XFF06142E),
      primary: Color(0xfff2f2f2),
      tertiary: Color(0XFF1E2126),
      scrim: Colors.white,
      secondary: Color(0xFFFF8C00),
      surface: Color(0XFF262A32),
      inverseSurface: Color.fromARGB(255, 212, 214, 215),
      surfaceVariant: Color(0XFFf1916d),
    ),
    brightness: Brightness.dark,
  );
}
