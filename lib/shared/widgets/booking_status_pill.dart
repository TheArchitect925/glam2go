import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_tag.dart';

class BookingStatusPill extends StatelessWidget {
  const BookingStatusPill({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final tone = switch (foregroundColor) {
      AppColors.success => AppTagTone.success,
      AppColors.warning => AppTagTone.warning,
      AppColors.error => AppTagTone.error,
      _ => AppTagTone.soft,
    };

    return AppTag(label: label, tone: tone);
  }
}

class BookingStatusPalette {
  const BookingStatusPalette._();

  static const pendingBackground = AppColors.warningSoft;
  static const pendingForeground = AppColors.warning;
  static const confirmedBackground = AppColors.successSoft;
  static const confirmedForeground = AppColors.success;
  static const completedBackground = AppColors.infoSoft;
  static const completedForeground = AppColors.info;
  static const declinedBackground = AppColors.errorSoft;
  static const declinedForeground = AppColors.error;
  static const cancelledBackground = AppColors.surfaceMuted;
  static const cancelledForeground = AppColors.textSecondary;
}
