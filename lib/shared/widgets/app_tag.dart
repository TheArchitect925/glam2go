import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

enum AppTagTone { neutral, accent, soft, success, warning, error }

class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.tone = AppTagTone.neutral,
    this.icon,
  });

  final String label;
  final AppTagTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final palette = switch (tone) {
      AppTagTone.neutral => (AppColors.surfaceVariant, AppColors.textSecondary),
      AppTagTone.accent => (AppColors.primarySoft, AppColors.accent),
      AppTagTone.soft => (AppColors.surfaceTintWarm, AppColors.textPrimary),
      AppTagTone.success => (AppColors.successSoft, AppColors.success),
      AppTagTone.warning => (AppColors.warningSoft, AppColors.warning),
      AppTagTone.error => (AppColors.errorSoft, AppColors.error),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.$1,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: palette.$2.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: palette.$2),
              const AppGap.h(AppSpacing.xxs),
            ],
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: palette.$2),
            ),
          ],
        ),
      ),
    );
  }
}
