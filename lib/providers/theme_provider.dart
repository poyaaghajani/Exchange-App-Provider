import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.grey.shade300, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
      bodyMedium: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 15),
      bodyLarge: GoogleFonts.ubuntu(
          color: Colors.white70, fontSize: 19, fontWeight: FontWeight.bold),
    ),
    unselectedWidgetColor: Colors.white70,
    cardColor: Colors.grey.shade400,
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: const Color(0xff0005ce),
    secondaryHeaderColor: const Color(0xff383838),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.grey.shade800, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
      bodyMedium: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 15),
      bodyLarge: GoogleFonts.ubuntu(
          color: Colors.grey[900], fontSize: 19, fontWeight: FontWeight.bold),
    ),
    unselectedWidgetColor: Colors.black,
    cardColor: Colors.grey.shade800,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: const Color(0xffEEEEEE),
    primaryColor: const Color(0xff4a64fe),
    secondaryHeaderColor: Colors.grey[400],
    iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
  );
}
