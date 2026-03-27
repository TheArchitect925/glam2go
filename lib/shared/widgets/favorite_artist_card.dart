import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../features/search/domain/models/discovery_models.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_tag.dart';

class FavoriteArtistCard extends StatelessWidget {
  const FavoriteArtistCard({
    super.key,
    required this.artist,
    required this.viewLabel,
    required this.removeLabel,
    this.onView,
    this.onRemove,
  });

  final ArtistSummary artist;
  final String viewLabel;
  final String removeLabel;
  final VoidCallback? onView;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.large),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [artist.heroStartColor, artist.heroEndColor],
              ),
            ),
          ),
          const AppGap.v(AppSpacing.md),
          Text(artist.name, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.xxs),
          Text(
            '${artist.locationLabel} • ${artist.travelSummary}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const AppGap.v(AppSpacing.sm),
          Text(
            artist.availabilityHint,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.secondary),
          ),
          const AppGap.v(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: artist.specialties
                .take(2)
                .map((item) => AppTag(label: item))
                .toList(growable: false),
          ),
          const AppGap.v(AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(label: viewLabel, onPressed: onView),
              ),
              const AppGap.h(AppSpacing.sm),
              IconButton(
                onPressed: onRemove,
                tooltip: removeLabel,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceVariant,
                ),
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
