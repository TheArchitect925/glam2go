import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/booking_status_pill.dart';
import '../../../../shared/widgets/request_action_bar.dart';
import '../../../../core/l10n/localization.dart';
import '../../../booking/domain/models/marketplace_booking_models.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';

class ArtistBookingCard extends StatelessWidget {
  const ArtistBookingCard({
    super.key,
    required this.booking,
    this.onAccept,
    this.onDecline,
    this.acceptLabel,
    this.declineLabel,
  });

  final ArtistBookingSummary booking;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String? acceptLabel;
  final String? declineLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = booking.status.palette;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.customerName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const AppGap.v(AppSpacing.xxs),
                    Text(
                      booking.packageTitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              BookingStatusPill(
                label: booking.status.label(l10n),
                backgroundColor: palette.$1,
                foregroundColor: palette.$2,
              ),
            ],
          ),
          const AppGap.v(AppSpacing.md),
          _MetaLine(
            icon: Icons.schedule_outlined,
            label:
                '${formatLongDate(booking.scheduledAt)} • ${booking.timeLabel}',
          ),
          const AppGap.v(AppSpacing.xs),
          _MetaLine(icon: Icons.place_outlined, label: booking.areaLabel),
          const AppGap.v(AppSpacing.xs),
          _MetaLine(
            icon: Icons.auto_awesome_outlined,
            label: booking.eventLabel,
          ),
          const AppGap.v(AppSpacing.xs),
          _MetaLine(
            icon: Icons.near_me_outlined,
            label: booking.travelIncluded
                ? l10n.bookingTravelIncludedTitle
                : l10n.artistTravelFeePreview(booking.travelFee),
          ),
          if (booking.status == BookingLifecycleStatus.pendingArtistResponse &&
              onAccept != null &&
              onDecline != null &&
              acceptLabel != null &&
              declineLabel != null) ...[
            const AppGap.v(AppSpacing.md),
            RequestActionBar(
              acceptLabel: acceptLabel!,
              declineLabel: declineLabel!,
              onAccept: onAccept!,
              onDecline: onDecline!,
            ),
          ],
        ],
      ),
    );
  }
}

extension on BookingLifecycleStatus {
  (Color, Color) get palette => switch (this) {
    BookingLifecycleStatus.pendingArtistResponse => (
      BookingStatusPalette.pendingBackground,
      BookingStatusPalette.pendingForeground,
    ),
    BookingLifecycleStatus.accepted => (
      BookingStatusPalette.confirmedBackground,
      BookingStatusPalette.confirmedForeground,
    ),
    BookingLifecycleStatus.completed => (
      BookingStatusPalette.completedBackground,
      BookingStatusPalette.completedForeground,
    ),
    BookingLifecycleStatus.declined => (
      BookingStatusPalette.declinedBackground,
      BookingStatusPalette.declinedForeground,
    ),
    BookingLifecycleStatus.cancelled => (
      BookingStatusPalette.cancelledBackground,
      BookingStatusPalette.cancelledForeground,
    ),
  };

  String label(AppLocalizations l10n) => switch (this) {
    BookingLifecycleStatus.pendingArtistResponse =>
      l10n.artistBookingStatusPending,
    BookingLifecycleStatus.accepted => l10n.bookingStatusAccepted,
    BookingLifecycleStatus.completed => l10n.bookingStatusCompleted,
    BookingLifecycleStatus.declined => l10n.bookingStatusDeclined,
    BookingLifecycleStatus.cancelled => l10n.bookingStatusCancelled,
  };
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
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
