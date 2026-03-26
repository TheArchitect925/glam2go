import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.searchTitle,
      headline: l10n.searchHeadline,
      description: l10n.searchDescription,
      statusLabel: l10n.searchStatus,
      primaryActionLabel: l10n.actionViewSearchResults,
      onPrimaryAction: () => context.go(AppRoutePaths.searchResults),
    );
  }
}
