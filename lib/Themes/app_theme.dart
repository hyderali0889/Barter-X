import 'package:barter_x/Themes/main_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData mainTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light()
          .copyWith(background: AppColors().primaryWhite),
      fontFamily: "medium",
      textTheme: TextTheme(
        //White
        bodyLarge: TextStyle(
            color: AppColors().primaryText, fontSize: 25, fontFamily: "bold"),
        bodyMedium: TextStyle(
            color: AppColors().primaryText, fontSize: 20, fontFamily: "medium"),
        bodySmall: TextStyle(
            color: AppColors().primaryText, fontSize: 16, fontFamily: "medium"),
        displayLarge: TextStyle(
            color: AppColors().primaryWhite, fontSize: 25, fontFamily: "bold"),
        displayMedium: TextStyle(
            color: AppColors().primaryWhite,
            fontSize: 20,
            fontFamily: "medium"),
        displaySmall: TextStyle(
            color: AppColors().primaryWhite,
            fontSize: 16,
            fontFamily: "medium"),
      ));
}
