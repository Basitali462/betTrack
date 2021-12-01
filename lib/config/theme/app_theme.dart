import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static final scaffoldBgColor = Colors.white;
  static final appBarColor = Colors.white;
  static final colorLightGreen = Color(0xFF2ADDA6).withOpacity(0.15);
  static final colorGreen = Color(0xFF00AF79);
  static final colorIconBlue = Color(0xFF60c8ff);
  static final colorButtonBlue = Color(0xFF5DC7FF);
  static final colorButtonRed = Color(0xFFFF6072);
  static final greyColor = Color(0xFF9D9D9D);
  static final colorButtonGreen = Color(0xFF2ADDA6);
  static final colorDisableButtons = Color(0xFF575757).withOpacity(0.05);
  static final colorDisableButtonText = Color(0xFF404040).withOpacity(0.4);
  static final colorActiveButtonText = Colors.white;
  static final colorButtonOrange = Color(0xFFFFA53C);

  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBgColor,
    appBarTheme: AppBarTheme(
      color: appBarColor,
      elevation: 0,
    ),
  );
}