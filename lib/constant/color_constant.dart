import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color tcBG = Color(0xFFE8EAF6);
const Color tcViolet = Color(0xFF5C6BC0);
const Color tcLightViolet = Color(0xFFC5CAE9);
const Color tcDarkViolet = Color(0xFF303F9F);
const Color tcWhite = Color(0xFFFFFFFF);
const Color tcDark = Color(0xFF34495E);
const Color tcBlack = Color(0xFF212121);
const Color tcGray = Color(0xFF95A5A6);
const Color tcRed = Color(0xFFF44336);
const Color tcAsh = Color(0xFFECEFF1);
const Color tcGreen = Color(0xFF4CAF50);
const Color tcBlue = Color(0xFF2196F3);
const Color tcOrange = Color(0xFFFF9800);
const Color tcYellow = Color(0xFFF1C40F);

final ThemeData taguigTheme = ThemeData(
  platform: TargetPlatform.android,
  scaffoldBackgroundColor: tcWhite,
  textTheme: TextTheme(
    // Display
    displayLarge: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 32.sp,
      fontWeight: FontWeight.w900,
    ),
    displayMedium: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 30.sp,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
    ),

    // Headline
    headlineLarge: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 36.sp,
      fontWeight: FontWeight.w900,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    ),

    // Title
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 22.sp,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
    ),

    // Body
    bodyLarge: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
    ),

    // Label
    labelLarge: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontFamily: 'PublicSans',
      fontSize: 10.sp,
      fontWeight: FontWeight.w200,
    ),
  ),

  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: tcViolet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: tcViolet,
      textStyle: TextStyle(
        fontSize: 15,
      ),
    ),
  ),
);
