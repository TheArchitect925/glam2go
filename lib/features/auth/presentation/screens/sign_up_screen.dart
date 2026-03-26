import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.authSignUpTitle,
      headline: l10n.authSignUpTitle,
      description: l10n.authSignUpDescription,
      statusLabel: l10n.scaffoldIncompleteMessage,
    );
  }
}
