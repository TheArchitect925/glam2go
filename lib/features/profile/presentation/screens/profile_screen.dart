import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.profileTitle,
      headline: l10n.profileHeadline,
      description: l10n.profileDescription,
      statusLabel: l10n.profileStatus,
      primaryActionLabel: l10n.actionOpenSettings,
      onPrimaryAction: () => context.go(AppRoutePaths.settings),
    );
  }
}
