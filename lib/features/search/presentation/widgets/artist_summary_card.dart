import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_tag.dart';
import '../../domain/models/discovery_models.dart';

class ArtistSummaryCard extends StatelessWidget {
  const ArtistSummaryCard({
    super.key,
    required this.artist,
    required this.viewProfileLabel,
    this.onViewProfile,
    this.compact = false,
  });

  final ArtistSummary artist;
  final String viewProfileLabel;
  final VoidCallback? onViewProfile;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final specialties = compact
        ? artist.specialties.take(1).toList(growable: false)
        : artist.specialties;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: compact ? 120 : 164,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.large),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [artist.heroStartColor, artist.heroEndColor],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 14,
                  left: 14,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.84),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      child: Text(
                        artist.heroLabel,
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: 14,
                  child: CircleAvatar(
                    radius: compact ? 22 : 26,
                    backgroundColor: AppColors.white.withValues(alpha: 0.88),
                    child: Text(
                      artist.name.characters.first.toUpperCase(),
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AppGap.v(AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(artist.name, style: textTheme.titleLarge),
                    const AppGap.v(AppSpacing.xxs),
                    Text(
                      artist.locationLabel,
                      style: textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const AppGap.h(AppSpacing.sm),
              _RatingBadge(artist: artist),
            ],
          ),
          const AppGap.v(AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: specialties
                .map((specialty) => AppTag(label: specialty))
                .toList(growable: false),
          ),
          const AppGap.v(AppSpacing.md),
          _MetaLine(
            icon: Icons.wallet_outlined,
            label: l10n.priceStartingFrom(formatCurrency(artist.startingPrice)),
          ),
          if (!compact) ...[
            const AppGap.v(AppSpacing.sm),
            _MetaLine(
              icon: Icons.schedule_outlined,
              label: artist.availabilityHint,
            ),
          ],
          if (!compact) ...[
            const AppGap.v(AppSpacing.sm),
            _MetaLine(
              icon: Icons.near_me_outlined,
              label: artist.travelSummary,
            ),
          ],
          if (onViewProfile != null) ...[
            const AppGap.v(AppSpacing.lg),
            AppButton(label: viewProfileLabel, onPressed: onViewProfile),
          ],
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.artist});

  final ArtistSummary artist;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, size: 16, color: AppColors.primary),
            const AppGap.h(AppSpacing.xxs),
            Text(
              '${formatRating(artist.reviewSummary.rating)} '
              '(${artist.reviewSummary.reviewCount})',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.secondary),
        const AppGap.h(AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
