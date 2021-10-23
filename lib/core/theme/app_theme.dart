import 'package:flutter/material.dart';

import '../../meta/Utility/constants.dart';
import 'app_color.dart';

//?https://medium.com/globant/flutter-dynamic-theme-dark-mode-custom-themes-bded572c8cdf

class AppTheme {
  get darkTheme => ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
            brightness: Brightness.dark, color: AppColors.textBlack),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.dark,
        canvasColor: AppColors.lightGreyDarkMode,
        accentColor: primaryColor,
        primaryColor: primaryColor,
        accentIconTheme: IconThemeData(color: Colors.white),
      );

  get lightTheme => ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: AppColors.grey2,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        canvasColor: AppColors.white,
        brightness: Brightness.light,
        accentColor: AppColors.grey2,
        accentIconTheme: IconThemeData(color: Colors.black),
      );
}
