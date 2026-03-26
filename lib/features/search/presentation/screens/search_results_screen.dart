import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.searchResultsTitle,
      headline: l10n.searchResultsHeadline,
      description: l10n.searchResultsDescription,
      statusLabel: l10n.searchResultsStatus,
      primaryActionLabel: l10n.actionViewArtistProfile,
      onPrimaryAction: () => context.go('/artists/sample-artist'),
    );
  }
}
