import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/loading_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _didNavigate = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final readiness = ref.watch(artistReadinessProvider);

    if (session.hasHydrated && !_didNavigate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _didNavigate) {
          return;
        }

        _didNavigate = true;
        final destination = switch (session.authStatus) {
          AuthStatus.authenticated
              when session.pendingProtectedAction != null =>
            session.pendingProtectedAction!.path,
          AuthStatus.authenticated when session.isArtist =>
            readiness.progress >= 1
                ? AppRoutePaths.artistDashboard
                : AppRoutePaths.artistOnboarding,
          AuthStatus.authenticated when session.isCustomer =>
            AppRoutePaths.home,
          _ => AppRoutePaths.onboarding,
        };
        context.go(destination);
      });
    }

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
            onPressed: () => context.go(
              session.hasHydrated
                  ? AppRoutePaths.onboarding
                  : AppRoutePaths.splash,
            ),
          ),
        ],
      ),
    );
  }
}
