import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/booking_status_pill.dart';
import '../../../booking/domain/models/marketplace_booking_models.dart';
import '../../../profile/application/account_providers.dart';
import '../../../profile/domain/models/account_models.dart';

class CustomerBookingCard extends StatelessWidget {
  const CustomerBookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  final CustomerBookingDetails booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = booking.status.palette;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.extraLarge),
      child: AppCard(
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
                      Text(
                        booking.artistName,
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
              icon: Icons.schedule_rounded,
              label: formatBookingSchedule(booking),
            ),
            const AppGap.v(AppSpacing.sm),
            _MetaLine(
              icon: Icons.place_outlined,
              label: booking.location.shortLabel,
            ),
            const AppGap.v(AppSpacing.sm),
            _MetaLine(
              icon: Icons.wallet_outlined,
              label:
                  '${l10n.bookingPriceTotalLabel}: ${formatCurrency(booking.priceSummary.total)}',
            ),
          ],
        ),
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
    BookingLifecycleStatus.pendingArtistResponse => l10n.bookingStatusPending,
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
