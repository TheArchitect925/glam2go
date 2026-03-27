import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/models/marketplace_booking_models.dart';

class BookingStatusTimeline extends StatelessWidget {
  const BookingStatusTimeline({
    super.key,
    required this.title,
    required this.entries,
  });

  final String title;
  final List<BookingStatusTimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppCard(
      tone: AppCardTone.muted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.md),
          ...entries.indexed.map((entry) {
            final index = entry.$1;
            final item = entry.$2;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == entries.length - 1 ? 0 : AppSpacing.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: _timelineColor(item.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const AppGap.h(AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.status.label(l10n),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const AppGap.v(AppSpacing.xxs),
                        Text(
                          formatLongDate(item.occurredAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const AppGap.v(AppSpacing.xxs),
                        Text(
                          item.note,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _timelineColor(BookingLifecycleStatus status) => switch (status) {
    BookingLifecycleStatus.pendingArtistResponse => AppColors.warning,
    BookingLifecycleStatus.accepted => AppColors.success,
    BookingLifecycleStatus.declined => AppColors.error,
    BookingLifecycleStatus.cancelled => AppColors.accent,
    BookingLifecycleStatus.completed => AppColors.primary,
  };
}

extension on BookingLifecycleStatus {
  String label(AppLocalizations l10n) => switch (this) {
    BookingLifecycleStatus.pendingArtistResponse => l10n.bookingStatusPending,
    BookingLifecycleStatus.accepted => l10n.bookingStatusAccepted,
    BookingLifecycleStatus.completed => l10n.bookingStatusCompleted,
    BookingLifecycleStatus.declined => l10n.bookingStatusDeclined,
    BookingLifecycleStatus.cancelled => l10n.bookingStatusCancelled,
  };
}
