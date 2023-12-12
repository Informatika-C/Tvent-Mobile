import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: const Color(0XFFE67E22),
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: const ColorScheme.light(
      background: Color(0XFFE1DCD1),
      primary: Color(0XFF1E2126),
      tertiary: Color(0XFFf2f2f2),
      scrim: Color(0XFFFFA500),
      secondary: Color(0XFF06142E),
      surface: Colors.white,
      inverseSurface: Color(0XFF262A32),
    ),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: const Color(0XFF262A32),
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: const ColorScheme.dark(
      background: Color(0XFF06142E),
      primary: Color(0xfff2f2f2),
      tertiary: Color(0XFF262A32),
      scrim: Colors.white,
      secondary: Color(0XFF574D45),
      surface: Color(0XFF262A32),
      inverseSurface: Colors.white,
    ),
    brightness: Brightness.dark,
  );
}
