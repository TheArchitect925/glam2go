import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme build() {
    const baseColor = AppColors.textPrimary;
    const secondaryColor = AppColors.textSecondary;

    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: baseColor,
        letterSpacing: -0.8,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: baseColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: baseColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: baseColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: baseColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: baseColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: secondaryColor,
      ),
    );
  }
}
