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
  static const artPeach = Color(0xFFF8DED2);
  static const artPowderBlue = Color(0xFFB9DDED);
  static const artAqua = Color(0xFF49D2E8);
  static const artHoney = Color(0xFFFFD491);
  static const artAquaDeep = Color(0xFF20BFD9);
  static const artPetal = Color(0xFFF4AFD0);
  static const artIce = Color(0xFFD7EAF7);
  static const artSkyShade = Color(0xFF91B7DF);
  static const artMint = Color(0xFF85D8EA);
  static const artHoneyLight = Color(0xFFFFE5A3);
  static const error = Color(0xFFB72445);
  static const white = Colors.white;
  static const catalogSurface = Color(0xFFEFF0F1);
  static const warm = Color(0xFFFFECD9);
  static const orange = Color(0xFFF57924);
  static const violet = Color(0xFF6658A6);
  static const rewardHighlight = Color(0xFFFF9ECD);
  static const rewardShadow = Color(0xFFE04491);
  static const rewardInactive = Color(0xFFE5E5E5);
  static const medalSilver = Color(0xFFD1D5DB);
  static const medalGold = Color(0xFFFFDE8B);
  static const medalPlatinum = Color(0xFF9DDFEE);
  static const medalBronze = Color(0xFFE49757);
  static const medalSilverAccent = Color(0xFFA2A8B4);
  static const medalGoldAccent = Color(0xFFD7983A);
  static const memberBadgeFace = Color(0xFFEFDAC5);
  static const memberBadgeStar = Color(0xFFAE9986);
  static const skeleton = Color(0xFFDCE0E3);
  static const socialBlue = Color(0xFF1877F2);
  static const helpGreen = Color(0xFF72A742);
  static const descriptionFadeMask = Color(0xABFFFFFF);
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

abstract final class AppTypography {
  static const _localFamily = String.fromEnvironment(
    'JDONUTS_LOCAL_FONT_FAMILY',
  );
  static const usesLocalFamily = _localFamily != '';
  static const adlamFamily = 'ADLaMDisplay';
  static const abelFamily = 'Abel';
  static const myanmarFamily = 'NotoSansMyanmar';
  static const fontFallback = [myanmarFamily];
  static const headlineFamily = usesLocalFamily ? _localFamily : adlamFamily;
  static const bodyFamily = usesLocalFamily ? _localFamily : abelFamily;
  static const descriptionWeight = FontWeight.w300;
  static const labelWeight = FontWeight.w500;
  static const strongWeight = FontWeight.w700;
  static const _displayWeight = usesLocalFamily
      ? strongWeight
      : FontWeight.w400;

  static const textButton = TextStyle(
    fontFamily: headlineFamily,
    fontFamilyFallback: fontFallback,
    fontSize: 15,
    fontWeight: _displayWeight,
  );

  static final primaryButton = textButton.copyWith(
    fontWeight: usesLocalFamily ? FontWeight.w900 : _displayWeight,
  );

  static TextStyle? headline(TextStyle? style) =>
      style?.copyWith(fontFamily: headlineFamily, fontWeight: _displayWeight);
}

ThemeData appTheme() {
  final theme = ThemeData(
    fontFamily: AppTypography.bodyFamily,
    fontFamilyFallback: AppTypography.fontFallback,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.pink,
      primary: AppColors.pink,
      error: AppColors.error,
      onSurface: AppColors.ink,
      surface: AppColors.canvas,
    ),
    scaffoldBackgroundColor: AppColors.canvas,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 34, height: 1.05, letterSpacing: -0.8),
      bodyMedium: TextStyle(fontSize: 15, height: 1.35),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      labelStyle: const TextStyle(
        color: AppColors.muted,
        fontWeight: AppTypography.labelWeight,
      ),
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
        textStyle: AppTypography.primaryButton,
      ),
    ),
  );

  final text = theme.textTheme;
  return theme.copyWith(
    textTheme: text.copyWith(
      displayLarge: AppTypography.headline(text.displayLarge),
      displayMedium: AppTypography.headline(text.displayMedium),
      displaySmall: AppTypography.headline(text.displaySmall),
      headlineLarge: AppTypography.headline(text.headlineLarge),
      headlineMedium: AppTypography.headline(text.headlineMedium),
      headlineSmall: AppTypography.headline(text.headlineSmall),
      titleLarge: text.titleLarge?.copyWith(
        fontWeight: AppTypography.strongWeight,
      ),
      titleMedium: text.titleMedium?.copyWith(
        fontWeight: AppTypography.strongWeight,
      ),
      bodyLarge: text.bodyLarge?.copyWith(
        fontWeight: AppTypography.labelWeight,
      ),
      bodyMedium: text.bodyMedium?.copyWith(
        fontWeight: AppTypography.labelWeight,
      ),
      bodySmall: text.bodySmall?.copyWith(
        fontWeight: AppTypography.descriptionWeight,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: AppTypography.textButton),
    ),
  );
}
