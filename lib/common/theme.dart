import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(),
    scaffoldBackgroundColor: Colors.grey.shade50,
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      textTheme: GoogleFonts.nunitoTextTheme(),
      centerTitle: true,
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(),
    scaffoldBackgroundColor: Colors.black87,
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      textTheme: GoogleFonts.nunitoTextTheme(),
      centerTitle: true,
    ),
  );
}
