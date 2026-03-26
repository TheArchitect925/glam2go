import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.homeTitle,
      headline: l10n.homeHeadline,
      description: l10n.homeDescription,
      statusLabel: l10n.homeStatus,
      primaryActionLabel: l10n.actionBrowseArtists,
      onPrimaryAction: () => context.go(AppRoutePaths.search),
    );
  }
}
