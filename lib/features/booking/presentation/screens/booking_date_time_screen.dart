import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingDateTimeScreen extends StatelessWidget {
  const BookingDateTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingDateTimeTitle,
      headline: l10n.bookingDateTimeHeadline,
      description: l10n.bookingDateTimeDescription,
      statusLabel: l10n.bookingDateTimeStatus,
      primaryActionLabel: l10n.actionChooseLocation,
      onPrimaryAction: () => context.go(AppRoutePaths.bookingLocation),
    );
  }
}
