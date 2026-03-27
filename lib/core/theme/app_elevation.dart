import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppElevation {
  const AppElevation._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.shadowSoft,
      blurRadius: 18,
      offset: Offset(0, 8),
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> floating = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 28,
      offset: Offset(0, 14),
      spreadRadius: -12,
    ),
  ];
}
