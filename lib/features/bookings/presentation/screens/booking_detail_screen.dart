import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.bookingDetailTitle,
      headline: l10n.bookingDetailHeadline,
      description: l10n.bookingDetailDescription(bookingId),
      statusLabel: l10n.bookingDetailStatus,
    );
  }
}
