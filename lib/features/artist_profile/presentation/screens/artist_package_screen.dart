import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class ArtistPackageScreen extends StatelessWidget {
  const ArtistPackageScreen({
    super.key,
    required this.artistId,
    required this.packageId,
  });

  final String artistId;
  final String packageId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.packageDetailsTitle,
      headline: l10n.packageDetailsHeadline,
      description: l10n.packageDetailsDescription(packageId),
      statusLabel: l10n.packageDetailsStatus,
      primaryActionLabel: l10n.actionContinue,
      onPrimaryAction: () =>
          context.go('/booking/start/artist/$artistId/package/$packageId'),
    );
  }
}
