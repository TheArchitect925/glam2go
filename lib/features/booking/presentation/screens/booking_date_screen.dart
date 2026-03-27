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
import '../widgets/booking_step_header.dart';

class BookingDateScreen extends ConsumerWidget {
  const BookingDateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(bookingFlowControllerProvider);
    final availableDates = ref.watch(bookingAvailableDatesProvider);

    return AppScaffoldWrapper(
      title: l10n.bookingDateTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingStepHeader(
            currentStep: BookingFlowStep.date,
            title: l10n.bookingDateHeadline,
            subtitle: l10n.bookingDateDescription,
          ),
          const AppGap.v(AppSpacing.xl),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final date = availableDates[index];
                final isSelected = draft.dateSelection?.date == date.date;

                return AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(date.label),
                    subtitle: Text(l10n.bookingDateHint),
                    trailing: Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                    ),
                    onTap: () {
                      ref
                          .read(bookingFlowControllerProvider.notifier)
                          .selectDate(date);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const AppGap.v(AppSpacing.md),
              itemCount: availableDates.length,
            ),
          ),
          const AppGap.v(AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.bookingBackToDetails,
                  onPressed: () => context.go(AppRoutePaths.bookingDetails),
                  tone: AppButtonTone.secondary,
                ),
              ),
              const AppGap.h(AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: l10n.bookingContinueToTime,
                  onPressed: draft.canContinueFromDate
                      ? () {
                          ref
                              .read(bookingFlowControllerProvider.notifier)
                              .setStep(BookingFlowStep.time);
                          context.go(AppRoutePaths.bookingTime);
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
