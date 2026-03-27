import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';
import '../../application/marketplace_booking_providers.dart';
import '../../application/booking_flow_controller.dart';
import '../../domain/models/booking_models.dart';
import '../widgets/booking_address_card.dart';
import '../widgets/booking_price_card.dart';
import '../widgets/booking_step_header.dart';
import '../widgets/booking_summary_card.dart';

class BookingReviewScreen extends ConsumerStatefulWidget {
  const BookingReviewScreen({super.key});

  @override
  ConsumerState<BookingReviewScreen> createState() =>
      _BookingReviewScreenState();
}

class _BookingReviewScreenState extends ConsumerState<BookingReviewScreen> {
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final draft = ref.watch(bookingFlowControllerProvider);
    final location = draft.location;
    final priceSummary = draft.priceSummary;
    final travelSummary = draft.travelFeeSummary;

    if (!draft.canReview ||
        location == null ||
        priceSummary == null ||
        travelSummary == null) {
      return AppScaffoldWrapper(
        title: l10n.bookingReviewTitle,
        child: Center(child: Text(l10n.bookingReviewIncompleteMessage)),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.bookingReviewTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStepHeader(
              currentStep: BookingFlowStep.review,
              title: l10n.bookingReviewHeadline,
              subtitle: l10n.bookingReviewDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            BookingSummaryCard(
              title: l10n.bookingReviewServiceTitle,
              trailing: TextButton(
                onPressed: () => context.go(AppRoutePaths.bookingStart),
                child: Text(l10n.bookingEditLabel),
              ),
              rows: [
                BookingSummaryRowData(
                  label: l10n.bookingArtistLabel,
                  value: draft.artistName ?? '',
                ),
                BookingSummaryRowData(
                  label: l10n.bookingPackageLabel,
                  value: draft.selectedPackage?.title ?? '',
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            BookingSummaryCard(
              title: l10n.bookingReviewEventTitle,
              trailing: TextButton(
                onPressed: () => context.go(AppRoutePaths.bookingDetails),
                child: Text(l10n.bookingEditLabel),
              ),
              rows: [
                BookingSummaryRowData(
                  label: l10n.bookingOccasionLabel,
                  value: draft.eventDetails?.occasion ?? '',
                ),
                BookingSummaryRowData(
                  label: l10n.bookingPartySizeLabel,
                  value: l10n.bookingPartySizeValue(
                    draft.eventDetails?.partySize ?? 1,
                  ),
                ),
                BookingSummaryRowData(
                  label: l10n.bookingNotesLabel,
                  value: draft.eventDetails?.notes.isNotEmpty == true
                      ? draft.eventDetails!.notes
                      : l10n.bookingNoNotesValue,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            BookingSummaryCard(
              title: l10n.bookingReviewScheduleTitle,
              trailing: TextButton(
                onPressed: () => context.go(AppRoutePaths.bookingDate),
                child: Text(l10n.bookingEditLabel),
              ),
              rows: [
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
            BookingAddressCard(
              title: l10n.bookingReviewLocationTitle,
              location: location,
              travelFeeSummaryTitle: travelSummary.locationKnown
                  ? travelSummary.isIncluded
                        ? l10n.bookingTravelIncludedTitle
                        : l10n.bookingTravelExtraTitle
                  : l10n.bookingTravelPendingTitle,
              travelFeeSummaryNote: travelSummary.locationKnown
                  ? travelSummary.isIncluded
                        ? l10n.bookingTravelIncludedNote(
                            draft.artistTravelPolicy?.includedRadiusKm ?? 0,
                          )
                        : l10n.bookingTravelExtraNote(
                            draft.artistTravelPolicy?.extraFeeFrom ?? 0,
                          )
                  : l10n.bookingTravelPendingNote(
                      draft.artistTravelPolicy?.includedRadiusKm ?? 0,
                      draft.artistTravelPolicy?.extraFeeFrom ?? 0,
                    ),
            ),
            const AppGap.v(AppSpacing.md),
            BookingPriceCard(
              title: l10n.bookingReviewPriceTitle,
              priceSummary: priceSummary,
              subtotalLabel: l10n.bookingPriceSubtotalLabel,
              travelFeeLabel: l10n.bookingPriceTravelLabel,
              totalLabel: l10n.bookingPriceTotalLabel,
            ),
            const AppGap.v(AppSpacing.xl),
            Text(
              l10n.bookingReviewApprovalNote,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const AppGap.v(AppSpacing.lg),
            AppButton(
              label: session.isCustomer
                  ? l10n.actionSubmitBookingRequest
                  : session.isGuest
                  ? l10n.actionSignInToSubmitRequest
                  : l10n.actionSwitchToCustomer,
              isEnabled: !_isSubmitting,
              onPressed: () async {
                if (!session.isCustomer) {
                  if (session.isGuest) {
                    ref
                        .read(sessionControllerProvider.notifier)
                        .setPendingProtectedAction(
                          path: AppRoutePaths.bookingReview,
                          requirement:
                              ProtectedActionRequirement.bookingSubmission,
                          preferredAuthIntent: AuthIntent.signIn,
                        );
                    context.go(AppRoutePaths.signIn);
                  } else {
                    ref
                        .read(sessionControllerProvider.notifier)
                        .switchToCustomer();
                  }
                  return;
                }

                setState(() {
                  _isSubmitting = true;
                  _errorMessage = null;
                });

                final confirmation = await ref
                    .read(marketplaceBookingsControllerProvider.notifier)
                    .submitCurrentDraftAsRequest();
                if (!context.mounted) {
                  return;
                }

                setState(() {
                  _isSubmitting = false;
                  _errorMessage = confirmation.failureOrNull == null
                      ? null
                      : l10n.bookingSubmissionFailedMessage;
                });

                if (confirmation.dataOrNull != null) {
                  context.go(
                    '/booking/confirmation/${confirmation.dataOrNull!.bookingId}',
                  );
                }
              },
            ),
            if (_errorMessage != null) ...[
              const AppGap.v(AppSpacing.md),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
