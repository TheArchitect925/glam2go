import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingConfirmationTitle,
      headline: l10n.bookingConfirmationHeadline,
      description: l10n.bookingConfirmationDescription(bookingId),
      statusLabel: l10n.bookingConfirmationStatus,
    );
  }
}
