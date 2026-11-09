import 'package:flutter/material.dart';

abstract final class AppColors {
  static const pink = Color(0xFFF44D9C);
  static const sky = Color(0xFF50C9E2);
  static const ink = Color(0xFF242B34);
  static const muted = Color(0xFF626C78);
  static const blush = Color(0xFFFCEAF2);
  static const canvas = Color(0xFFFFFAFC);
  static const landingWhite = Color(0xFFFEFBFC);
  static const landingPink = Color(0xFFFBF1F5);
  static const error = Color(0xFFB72445);
  static const white = Colors.white;
  static const catalogSurface = Color(0xFFEFF0F1);
  static const warm = Color(0xFFFFECD9);
  static const orange = Color(0xFFF57924);
  static const violet = Color(0xFF6658A6);
  static const rewardHighlight = Color(0xFFFF9ECD);
  static const rewardShadow = Color(0xFFE04491);
  static const medalSilver = Color(0xFFD1D5DB);
  static const medalGold = Color(0xFFFFDE8B);
  static const medalPlatinum = Color(0xFF9DDFEE);
  static const skeleton = Color(0xFFDCE0E3);
  static const socialBlue = Color(0xFF1877F2);
  static const googleRed = Color(0xFFEA4335);
  static const googleYellow = Color(0xFFFBBC05);
  static const googleGreen = Color(0xFF34A853);
  static const googleBlue = Color(0xFF4285F4);
}

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const fieldRadius = 10.0;
  static const buttonHeight = 54.0;
}

ThemeData appTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.pink,
    primary: AppColors.pink,
    error: AppColors.error,
    onSurface: AppColors.ink,
    surface: AppColors.canvas,
  ),
  scaffoldBackgroundColor: AppColors.canvas,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w900,
      height: 1.05,
      letterSpacing: -0.8,
    ),
    bodyMedium: TextStyle(fontSize: 15, height: 1.35),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    labelStyle: const TextStyle(color: AppColors.muted),
    contentPadding: const EdgeInsets.all(AppSpacing.md),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
      borderSide: const BorderSide(color: AppColors.sky, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.sky,
      foregroundColor: AppColors.ink,
      minimumSize: const Size(0, AppSpacing.buttonHeight),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
    ),
  ),
);
