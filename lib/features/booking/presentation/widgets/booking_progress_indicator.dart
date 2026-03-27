import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/models/booking_models.dart';

class BookingProgressIndicator extends StatelessWidget {
  const BookingProgressIndicator({super.key, required this.currentStep});

  final BookingFlowStep currentStep;

  static const _steps = [
    BookingFlowStep.service,
    BookingFlowStep.details,
    BookingFlowStep.date,
    BookingFlowStep.time,
    BookingFlowStep.location,
    BookingFlowStep.review,
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _steps.indexOf(currentStep);

    return Row(
      children: _steps.indexed
          .map((entry) {
            final index = entry.$1;
            final isActive = index <= currentIndex;

            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(
                  right: index == _steps.length - 1 ? 0 : AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            );
          })
          .toList(growable: false),
    );
  }
}
