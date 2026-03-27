import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/booking_status_pill.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/info_policy_card.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../booking/presentation/widgets/booking_address_card.dart';
import '../../../booking/presentation/widgets/booking_price_card.dart';
import '../../../booking/presentation/widgets/booking_status_timeline.dart';
import '../../../booking/presentation/widgets/booking_summary_card.dart';
import '../../../booking/application/marketplace_booking_providers.dart';
import '../../../booking/domain/models/marketplace_booking_models.dart';
import '../../../profile/application/account_providers.dart';
import '../../../search/application/discovery_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final bookingAsync = ref.watch(customerBookingByIdProvider(bookingId));
    final mutatingIds = ref.watch(marketplaceBookingMutationIdsProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.bookingDetailTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestBookingsGateTitle,
          message: session.isGuest
              ? l10n.guestBookingsGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    '/bookings/$bookingId',
                    ProtectedActionRequirement.customerAccount,
                  );
              context.go(AppRoutePaths.signIn);
            } else {
              ref.read(sessionControllerProvider.notifier).switchToCustomer();
            }
          },
        ),
      );
    }

    if (bookingAsync.isLoading) {
      return AppScaffoldWrapper(
        title: l10n.bookingDetailTitle,
        child: LoadingState(label: l10n.bookingLoadingMessage),
      );
    }

    if (bookingAsync.hasError) {
      return AppScaffoldWrapper(
        title: l10n.bookingDetailTitle,
        child: ErrorState(
          title: l10n.bookingLoadErrorTitle,
          message: l10n.bookingLoadErrorMessage,
          actionLabel: l10n.actionRetry,
          onAction: () => ref
              .read(marketplaceBookingsControllerProvider.notifier)
              .refresh(),
        ),
      );
    }

    final booking = bookingAsync.valueOrNull;
    if (booking == null) {
      return AppScaffoldWrapper(
        title: l10n.bookingDetailTitle,
        child: ErrorState(
          title: l10n.bookingDetailMissingTitle,
          message: l10n.bookingDetailMissingMessage,
          actionLabel: l10n.actionBrowseArtists,
          onAction: () => context.go(AppRoutePaths.home),
        ),
      );
    }

    final profile = ref
        .watch(artistProfileProvider(booking.artistId))
        .valueOrNull;
    final palette = booking.status.palette;

    return AppScaffoldWrapper(
      title: l10n.bookingDetailTitle,
      actions: [
        IconButton(
          onPressed: () => context.go(AppRoutePaths.support),
          icon: const Icon(Icons.help_outline_rounded),
          tooltip: l10n.supportTitle,
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeroCard(
              gradient: profile == null
                  ? AppGradients.neutralHero
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        profile.summary.heroStartColor,
                        profile.summary.heroEndColor,
                      ],
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingStatusPill(
                    label: booking.status.label(l10n),
                    backgroundColor: palette.$1,
                    foregroundColor: palette.$2,
                  ),
                  const AppGap.v(AppSpacing.md),
                  Text(
                    booking.artistName,
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(color: AppColors.white),
                  ),
                  const AppGap.v(AppSpacing.xs),
                  Text(
                    booking.packageTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.92),
                    ),
                  ),
                  const AppGap.v(AppSpacing.xs),
                  Text(
                    formatBookingSchedule(booking),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            BookingSummaryCard(
              title: l10n.bookingDetailSummaryTitle,
              rows: [
                BookingSummaryRowData(
                  label: l10n.bookingOccasionLabel,
                  value: booking.eventDetails.occasion,
                ),
                BookingSummaryRowData(
                  label: l10n.bookingPartySizeLabel,
                  value: l10n.bookingPartySizeValue(
                    booking.eventDetails.partySize,
                  ),
                ),
                BookingSummaryRowData(
                  label: l10n.bookingDateLabel,
                  value: formatLongDate(booking.scheduledAt),
                ),
                BookingSummaryRowData(
                  label: l10n.bookingTimeLabel,
                  value: booking.timeLabel,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            BookingAddressCard(
              title: l10n.bookingReviewLocationTitle,
              location: booking.location,
              travelFeeSummaryTitle: booking.travelFeeSummary.isIncluded
                  ? l10n.bookingTravelIncludedTitle
                  : l10n.bookingTravelExtraTitle,
              travelFeeSummaryNote: booking.travelFeeSummary.isIncluded
                  ? l10n.bookingTravelIncludedNote(
                      profile?.travelPolicy.includedRadiusKm ?? 0,
                    )
                  : l10n.bookingTravelExtraNote(booking.travelFeeSummary.fee),
            ),
            const AppGap.v(AppSpacing.md),
            BookingPriceCard(
              title: l10n.bookingReviewPriceTitle,
              priceSummary: booking.priceSummary,
              subtotalLabel: l10n.bookingPriceSubtotalLabel,
              travelFeeLabel: l10n.bookingPriceTravelLabel,
              totalLabel: l10n.bookingPriceTotalLabel,
            ),
            const AppGap.v(AppSpacing.md),
            BookingSummaryCard(
              title: l10n.bookingDetailNotesTitle,
              rows: [
                BookingSummaryRowData(
                  label: l10n.bookingNotesLabel,
                  value: booking.eventDetails.notes.isEmpty
                      ? l10n.bookingNoNotesValue
                      : booking.eventDetails.notes,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            BookingStatusTimeline(
              title: l10n.bookingTimelineTitle,
              entries: booking.timeline,
            ),
            const AppGap.v(AppSpacing.md),
            InfoPolicyCard(
              title: l10n.bookingDetailNextTitle,
              message: booking.nextStepNote,
              icon: Icons.schedule_send_outlined,
            ),
            const AppGap.v(AppSpacing.md),
            InfoPolicyCard(
              title: l10n.bookingDetailPolicyTitle,
              message: booking.policySummary,
              icon: Icons.policy_outlined,
            ),
            const AppGap.v(AppSpacing.lg),
            Row(
              children: [
                if (booking.status ==
                        BookingLifecycleStatus.pendingArtistResponse ||
                    booking.status == BookingLifecycleStatus.accepted) ...[
                  Expanded(
                    child: AppButton(
                      label: l10n.bookingDetailCancelCta,
                      isEnabled: !mutatingIds.contains(booking.id),
                      onPressed: () async {
                        final shouldCancel = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: Text(l10n.bookingDetailCancelTitle),
                              content: Text(l10n.bookingDetailCancelMessage),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(false),
                                  child: Text(l10n.actionKeepBooking),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(true),
                                  child: Text(l10n.bookingDetailCancelCta),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldCancel == true) {
                          await ref
                              .read(
                                marketplaceBookingsControllerProvider.notifier,
                              )
                              .cancelBookingRequest(booking.id);
                        }
                      },
                      tone: AppButtonTone.secondary,
                    ),
                  ),
                  const AppGap.h(AppSpacing.md),
                ],
                Expanded(
                  child: AppButton(
                    label: l10n.bookingDetailSupportCta,
                    onPressed: () => context.go(AppRoutePaths.bookingPolicy),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.actionViewArtistProfile,
                    onPressed: () => context.go('/artists/${booking.artistId}'),
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
