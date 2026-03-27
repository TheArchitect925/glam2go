import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../application/booking_flow_controller.dart';
import '../../domain/models/booking_models.dart';
import '../widgets/booking_step_header.dart';
import '../widgets/booking_time_slot_picker.dart';

class BookingTimeScreen extends ConsumerWidget {
  const BookingTimeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(bookingFlowControllerProvider);
    final slots = ref.watch(bookingAvailableTimeSlotsProvider);

    return AppScaffoldWrapper(
      title: l10n.bookingTimeTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingStepHeader(
            currentStep: BookingFlowStep.time,
            title: l10n.bookingTimeHeadline,
            subtitle: l10n.bookingTimeDescription,
          ),
          const AppGap.v(AppSpacing.xl),
          BookingTimeSlotPicker(
            slots: slots,
            selectedValue: draft.timeSelection,
            onSelected: (slot) {
              ref.read(bookingFlowControllerProvider.notifier).selectTime(slot);
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.bookingBackToDate,
                  onPressed: () => context.go(AppRoutePaths.bookingDate),
                  tone: AppButtonTone.secondary,
                ),
              ),
              const AppGap.h(AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: l10n.actionChooseLocation,
                  onPressed: draft.canContinueFromTime
                      ? () {
                          ref
                              .read(bookingFlowControllerProvider.notifier)
                              .setStep(BookingFlowStep.location);
                          context.go(AppRoutePaths.bookingLocation);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
