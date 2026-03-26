import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class BookingStartScreen extends StatelessWidget {
  const BookingStartScreen({super.key, this.artistId, this.packageId});

  final String? artistId;
  final String? packageId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = artistId == null || packageId == null
        ? l10n.bookingStartDescription
        : l10n.bookingSelectedPackageDescription(artistId!, packageId!);

    return FeatureScaffoldScreen(
      title: l10n.bookingStartTitle,
      headline: l10n.bookingStartHeadline,
      description: description,
      statusLabel: l10n.bookingStartStatus,
      primaryActionLabel: l10n.actionChooseDateTime,
      onPrimaryAction: () => context.go(AppRoutePaths.bookingDateTime),
    );
  }
}
