import 'package:flutter/material.dart';

import 'app_colors_dark.dart';
import 'app_colors_light.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    colorScheme: const ColorScheme.light(
      primary: AppColorsLight.primary,
      onPrimary: AppColorsLight.onPrimary,
      secondary: AppColorsLight.secondary,
      onSecondary: AppColorsLight.onSecondary,
      error: AppColorsLight.destructive,
      onError: Colors.white,
      surface: AppColorsLight.card,
      onSurface: AppColorsLight.cardForeground
    ),
    cardColor: AppColorsLight.card,
    dividerColor: AppColorsLight.border,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColorsLight.foreground,
      elevation: 0,
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      onPrimary: AppColorsDark.onPrimary,
      secondary: AppColorsDark.secondary,
      onSecondary: AppColorsDark.onSecondary,
      error: AppColorsDark.destructive,
      onError: Colors.white,
      surface: AppColorsDark.card,
      onSurface: AppColorsDark.cardForeground,
    ),
    cardColor: AppColorsDark.card,
    dividerColor: AppColorsDark.border,
  );
}
