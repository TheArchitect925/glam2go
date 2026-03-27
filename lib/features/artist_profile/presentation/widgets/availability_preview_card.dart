import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_tag.dart';
import '../../../search/domain/models/discovery_models.dart';

class AvailabilityPreviewCard extends StatelessWidget {
  const AvailabilityPreviewCard({
    super.key,
    required this.preview,
    required this.title,
  });

  final AvailabilityPreview preview;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.xs),
          Text(preview.headline, style: Theme.of(context).textTheme.bodyLarge),
          const AppGap.v(AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: preview.nextDates
                .map((date) => AppTag(label: date, tone: AppTagTone.accent))
                .toList(growable: false),
          ),
          const AppGap.v(AppSpacing.md),
          Text(preview.note, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
