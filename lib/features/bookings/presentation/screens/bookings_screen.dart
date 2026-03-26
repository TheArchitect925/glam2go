import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingsTitle,
      headline: l10n.bookingsHeadline,
      description: l10n.bookingsDescription,
      statusLabel: l10n.bookingsStatus,
      primaryActionLabel: l10n.actionViewBookingDetail,
      onPrimaryAction: () => context.go('/bookings/sample-booking'),
    );
  }
}
