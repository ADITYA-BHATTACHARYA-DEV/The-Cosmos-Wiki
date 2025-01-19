import 'package:flutter/material.dart';
import 'package:planet/screens/splash_screen.dart';
import 'package:planet/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmos Wiki',
      theme: AppTheme.darkTheme,
      home: SplashScreen(),  // Show SplashScreen first
    );
  }
}
