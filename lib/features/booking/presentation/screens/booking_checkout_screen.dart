import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingCheckoutScreen extends StatelessWidget {
  const BookingCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingCheckoutTitle,
      headline: l10n.bookingCheckoutHeadline,
      description: l10n.bookingCheckoutDescription,
      statusLabel: l10n.bookingCheckoutStatus,
      primaryActionLabel: l10n.actionConfirmBooking,
      onPrimaryAction: () => context.go('/booking/confirmation/sample-booking'),
    );
  }
}
