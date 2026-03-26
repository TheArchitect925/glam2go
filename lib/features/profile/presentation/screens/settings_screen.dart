import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.settingsTitle,
      headline: l10n.settingsHeadline,
      description: l10n.settingsDescription,
      statusLabel: l10n.settingsStatus,
    );
  }
}
