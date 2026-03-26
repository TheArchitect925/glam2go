import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.profileEditTitle,
      headline: l10n.profileEditHeadline,
      description: l10n.profileEditDescription,
      statusLabel: l10n.scaffoldIncompleteMessage,
    );
  }
}
