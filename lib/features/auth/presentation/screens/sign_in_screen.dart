import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/feature_scaffold_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeatureScaffoldScreen(
      title: l10n.authSignInTitle,
      headline: l10n.authSignInTitle,
      description: l10n.authSignInDescription,
      statusLabel: l10n.scaffoldIncompleteMessage,
    );
  }
}
