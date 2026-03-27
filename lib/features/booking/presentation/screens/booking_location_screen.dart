import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../application/booking_flow_controller.dart';
import '../../domain/models/booking_models.dart';
import '../widgets/booking_address_card.dart';
import '../widgets/booking_step_header.dart';

class BookingLocationScreen extends ConsumerStatefulWidget {
  const BookingLocationScreen({super.key});

  @override
  ConsumerState<BookingLocationScreen> createState() =>
      _BookingLocationScreenState();
}

class _BookingLocationScreenState extends ConsumerState<BookingLocationScreen> {
  late final TextEditingController _addressController;
  late final TextEditingController _unitController;
  late final TextEditingController _cityController;
  late final TextEditingController _accessController;

  @override
  void initState() {
    super.initState();
    final location = ref.read(bookingFlowControllerProvider).location;
    _addressController = TextEditingController(
      text: location?.addressLine1 ?? '',
    );
    _unitController = TextEditingController(text: location?.unitDetails ?? '');
    _cityController = TextEditingController(text: location?.cityArea ?? '');
    _accessController = TextEditingController(
      text: location?.accessNotes ?? '',
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _unitController.dispose();
    _cityController.dispose();
    _accessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = ref.watch(bookingFlowControllerProvider);
    final travelSummary = draft.travelFeeSummary;
    final previewLocation = BookingLocation(
      addressLine1: _addressController.text,
      unitDetails: _unitController.text,
      cityArea: _cityController.text,
      accessNotes: _accessController.text,
    );

    return AppScaffoldWrapper(
      title: l10n.bookingLocationTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStepHeader(
              currentStep: BookingFlowStep.location,
              title: l10n.bookingLocationHeadline,
              subtitle: l10n.bookingLocationDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            AppCard(
              child: Column(
                children: [
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: l10n.bookingAddressLine1Field,
                      hintText: l10n.bookingAddressLine1Hint,
                    ),
                  ),
                  const AppGap.v(AppSpacing.md),
                  TextField(
                    controller: _unitController,
                    decoration: InputDecoration(
                      labelText: l10n.bookingUnitField,
                      hintText: l10n.bookingUnitHint,
                    ),
                  ),
                  const AppGap.v(AppSpacing.md),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: l10n.bookingCityField,
                      hintText: l10n.bookingCityHint,
                    ),
                  ),
                  const AppGap.v(AppSpacing.md),
                  TextField(
                    controller: _accessController,
                    minLines: 2,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: l10n.bookingAccessNotesField,
                      hintText: l10n.bookingAccessNotesHint,
                    ),
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.md),
            if (travelSummary != null)
              BookingAddressCard(
                title: l10n.bookingTravelPreviewTitle,
                location: previewLocation,
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
            const AppGap.v(AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.bookingBackToTime,
                    onPressed: () => context.go(AppRoutePaths.bookingTime),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.actionReviewBooking,
                    onPressed: () {
                      ref
                          .read(bookingFlowControllerProvider.notifier)
                          .updateLocation(
                            addressLine1: _addressController.text,
                            unitDetails: _unitController.text,
                            cityArea: _cityController.text,
                            accessNotes: _accessController.text,
                          );

                      if (ref
                          .read(bookingFlowControllerProvider)
                          .canContinueFromLocation) {
                        ref
                            .read(bookingFlowControllerProvider.notifier)
                            .setStep(BookingFlowStep.review);
                        context.go(AppRoutePaths.bookingReview);
                      }
                    },
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
