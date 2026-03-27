import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/models/booking_models.dart';

class BookingAddressCard extends StatelessWidget {
  const BookingAddressCard({
    super.key,
    required this.title,
    required this.location,
    required this.travelFeeSummaryTitle,
    required this.travelFeeSummaryNote,
  });

  final String title;
  final BookingLocation location;
  final String travelFeeSummaryTitle;
  final String travelFeeSummaryNote;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      tone: AppCardTone.muted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.sm),
          Text(
            location.addressLine1,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (location.unitDetails.isNotEmpty) ...[
            const AppGap.v(AppSpacing.xxs),
            Text(
              location.unitDetails,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const AppGap.v(AppSpacing.xxs),
          Text(
            location.cityArea,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (location.accessNotes.isNotEmpty) ...[
            const AppGap.v(AppSpacing.md),
            Text(
              location.accessNotes,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const AppGap.v(AppSpacing.md),
          Text(
            travelFeeSummaryTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const AppGap.v(AppSpacing.xxs),
          Text(
            travelFeeSummaryNote,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
