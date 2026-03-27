import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

enum AppCardTone { base, muted }

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.tone = AppCardTone.base,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final AppCardTone tone;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (tone) {
      AppCardTone.base => AppColors.surface,
      AppCardTone.muted => AppColors.surfaceVariant,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.extraLarge),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: AppElevation.card,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
