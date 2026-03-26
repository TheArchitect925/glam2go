import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/section_header.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffoldWrapper(
      title: l10n.onboardingTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.onboardingTitle,
            subtitle: l10n.onboardingSubtitle,
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Text(
              l10n.onboardingStatus,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Spacer(),
          AppButton(
            label: l10n.authSignInTitle,
            onPressed: () => context.go(AppRoutePaths.signIn),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: l10n.authSignUpTitle,
            onPressed: () => context.go(AppRoutePaths.signUp),
            tone: AppButtonTone.secondary,
          ),
        ],
      ),
    );
  }
}
