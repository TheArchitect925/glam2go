import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/models/booking_models.dart';
import 'booking_progress_indicator.dart';

class BookingStepHeader extends StatelessWidget {
  const BookingStepHeader({
    super.key,
    required this.currentStep,
    required this.title,
    required this.subtitle,
  });

  final BookingFlowStep currentStep;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingProgressIndicator(currentStep: currentStep),
        const AppGap.v(AppSpacing.lg),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SectionHeader(title: title, subtitle: subtitle),
          ),
        ),
      ],
    );
  }
}
