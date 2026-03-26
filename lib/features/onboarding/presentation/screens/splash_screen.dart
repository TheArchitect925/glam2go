import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/loading_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffoldWrapper(
      title: l10n.appName,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AppCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.appName,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 16),
                    LoadingState(label: l10n.splashLoading),
                  ],
                ),
              ),
            ),
          ),
          AppButton(
            label: l10n.actionContinue,
            onPressed: () => context.go(AppRoutePaths.onboarding),
          ),
        ],
      ),
    );
  }
}
