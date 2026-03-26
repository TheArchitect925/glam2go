import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.favoritesTitle,
      headline: l10n.favoritesHeadline,
      description: l10n.favoritesDescription,
      statusLabel: l10n.favoritesStatus,
    );
  }
}
