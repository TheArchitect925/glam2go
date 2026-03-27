import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class AppHeroCard extends StatelessWidget {
  const AppHeroCard({
    super.key,
    required this.child,
    this.gradient,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
  });

  final Widget child;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.hero),
        gradient: gradient,
        color: gradient == null ? AppColors.surface : null,
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: AppElevation.card,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
