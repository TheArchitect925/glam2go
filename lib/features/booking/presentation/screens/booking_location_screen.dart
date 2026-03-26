import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingLocationScreen extends StatelessWidget {
  const BookingLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingLocationTitle,
      headline: l10n.bookingLocationHeadline,
      description: l10n.bookingLocationDescription,
      statusLabel: l10n.bookingLocationStatus,
      primaryActionLabel: l10n.actionReviewBooking,
      onPrimaryAction: () => context.go(AppRoutePaths.bookingCheckout),
    );
  }
}
