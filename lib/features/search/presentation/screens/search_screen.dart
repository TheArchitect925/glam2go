import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../widgets/discovery_results_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffoldWrapper(
      title: l10n.searchTitle,
      child: const DiscoveryResultsView(showIntro: true, limitResults: 3),
    );
  }
}
