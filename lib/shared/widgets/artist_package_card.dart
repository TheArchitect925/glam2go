import 'package:flutter/material.dart';

import '../../core/l10n/localization.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/formatters.dart';
import '../../features/search/domain/models/discovery_models.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_tag.dart';

class ArtistPackageCard extends StatelessWidget {
  const ArtistPackageCard({
    super.key,
    required this.artistPackage,
    this.onPressed,
    this.actionLabel,
  });

  final ArtistPackage artistPackage;
  final VoidCallback? onPressed;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(artistPackage.title, style: textTheme.titleLarge),
                    const AppGap.v(AppSpacing.xs),
                    Text(
                      artistPackage.description,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const AppGap.h(AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatCurrency(artistPackage.price),
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const AppGap.v(AppSpacing.xxs),
                  Text(
                    l10n.packageDurationMinutes(artistPackage.durationMinutes),
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
          const AppGap.v(AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: artistPackage.suitableFor
                .map((tag) => AppTag(label: tag))
                .toList(growable: false),
          ),
          const AppGap.v(AppSpacing.md),
          ...artistPackage.includes.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xxs),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const AppGap.h(AppSpacing.xs),
                  Expanded(child: Text(item, style: textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
          if (onPressed != null && actionLabel != null) ...[
            const AppGap.v(AppSpacing.md),
            AppButton(
              label: actionLabel!,
              onPressed: onPressed,
              tone: AppButtonTone.secondary,
            ),
          ],
        ],
      ),
    );
  }
}
