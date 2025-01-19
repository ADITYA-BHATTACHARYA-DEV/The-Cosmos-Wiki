import 'package:flutter/material.dart';

class AppTheme {
  
  static const Color spaceBlack = Color(0xFF0B0D17);
  static const Color spacePurple = Color(0xFF6F3FF5);
  static const Color spaceBlue = Color(0xFF1E90FF);
  static const Color spacePink = Color(0xFFFF69B4);
  static const Color spaceDarkBlue = Color(0xFF0A1128);

  static final ThemeData darkTheme = ThemeData(
    primaryColor: spacePurple,
    scaffoldBackgroundColor: spaceBlack,
    colorScheme: const ColorScheme.dark(
      primary: spacePurple,
      secondary: spaceBlue,
      surface: spaceDarkBlue,
      background: spaceBlack,
      error: spacePink,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      bodyText1: TextStyle(color: Colors.white70),
      bodyText2: TextStyle(color: Colors.white60),
    ),
  );
}

