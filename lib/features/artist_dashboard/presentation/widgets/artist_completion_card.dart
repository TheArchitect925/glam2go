import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_tag.dart';

class ArtistCompletionCard extends StatelessWidget {
  const ArtistCompletionCard({
    super.key,
    required this.title,
    required this.progressLabel,
    required this.progress,
    required this.missingItems,
  });

  final String title;
  final String progressLabel;
  final double progress;
  final List<String> missingItems;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.xs),
          Text(progressLabel, style: Theme.of(context).textTheme.bodyMedium),
          const AppGap.v(AppSpacing.md),
          LinearProgressIndicator(value: progress, minHeight: 8),
          if (missingItems.isNotEmpty) ...[
            const AppGap.v(AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: missingItems
                  .map((item) => AppTag(label: item))
                  .toList(growable: false),
            ),
          ],
        ],
      ),
    );
  }
}
