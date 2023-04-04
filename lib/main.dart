import 'package:flutter/material.dart';

import 'Screens/splash_screen.dart';
import 'Themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barter-X',
      theme: AppTheme().mainTheme,
      home: const SplashScreen(),
    );
  }
}