import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class ArtistProfileScreen extends StatelessWidget {
  const ArtistProfileScreen({super.key, required this.artistId});

  final String artistId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.artistProfileTitle,
      headline: l10n.artistProfileHeadline,
      description: l10n.artistProfileDescription(artistId),
      statusLabel: l10n.artistProfileStatus,
      primaryActionLabel: l10n.actionStartBooking,
      onPrimaryAction: () =>
          context.go('/booking/start/artist/$artistId/package/sample-package'),
    );
  }
}
