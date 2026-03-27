import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/booking_status_pill.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../application/booking_flow_controller.dart';
import '../../application/marketplace_booking_providers.dart';
import '../widgets/booking_status_timeline.dart';
import '../widgets/booking_price_card.dart';
import '../widgets/booking_summary_card.dart';

class BookingConfirmationScreen extends ConsumerWidget {
  const BookingConfirmationScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final confirmation = ref.watch(bookingConfirmationProvider(bookingId));
    final recordAsync = ref.watch(marketplaceBookingByIdProvider(bookingId));
    final draft = ref.watch(bookingFlowControllerProvider);

    if (recordAsync.isLoading) {
      return AppScaffoldWrapper(
        title: l10n.bookingConfirmationTitle,
        child: LoadingState(label: l10n.bookingLoadingMessage),
      );
    }

    final record = recordAsync.valueOrNull;
    if (confirmation == null || draft.priceSummary == null || record == null) {
      return AppScaffoldWrapper(
        title: l10n.bookingConfirmationTitle,
        child: ErrorState(
          title: l10n.bookingConfirmationMissingTitle,
          message: l10n.bookingConfirmationMissingMessage,
          actionLabel: l10n.actionBrowseArtists,
          onAction: () => context.go(AppRoutePaths.home),
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.bookingConfirmationTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStatusPill(
              label: l10n.bookingStatusPending,
              backgroundColor: BookingStatusPalette.pendingBackground,
              foregroundColor: BookingStatusPalette.pendingForeground,
            ),
            const AppGap.v(AppSpacing.md),
            Text(
              l10n.bookingConfirmationHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.bookingConfirmationDescription(bookingId),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.md),
            Text(
              l10n.bookingConfirmationNextStep,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const AppGap.v(AppSpacing.xl),
            BookingSummaryCard(
              title: l10n.bookingConfirmationSummaryTitle,
              rows: [
                BookingSummaryRowData(
                  label: l10n.bookingArtistLabel,
                  value: draft.artistName ?? '',
                ),
                BookingSummaryRowData(
                  label: l10n.bookingPackageLabel,
                  value: draft.selectedPackage?.title ?? '',
                ),
                BookingSummaryRowData(
                  label: l10n.bookingDateLabel,
                  value: draft.dateSelection?.label ?? '',
                ),
                BookingSummaryRowData(
                  label: l10n.bookingTimeLabel,
                  value: draft.timeSelection?.label ?? '',
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            BookingPriceCard(
              title: l10n.bookingReviewPriceTitle,
              priceSummary: draft.priceSummary!,
              subtotalLabel: l10n.bookingPriceSubtotalLabel,
              travelFeeLabel: l10n.bookingPriceTravelLabel,
              totalLabel: l10n.bookingPriceTotalLabel,
            ),
            const AppGap.v(AppSpacing.md),
            BookingStatusTimeline(
              title: l10n.bookingTimelineTitle,
              entries: record.timeline,
            ),
            const AppGap.v(AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.bookingConfirmationHomeCta,
                    onPressed: () => context.go(AppRoutePaths.home),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.bookingConfirmationBookingsCta,
                    onPressed: () => context.go(AppRoutePaths.bookings),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
