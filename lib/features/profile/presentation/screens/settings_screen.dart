import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../../shared/widgets/settings_tile.dart';
import '../../application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final preferences = ref.watch(userPreferencesProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.settingsTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestSettingsGateTitle,
          message: session.isGuest
              ? l10n.guestSettingsGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    AppRoutePaths.settings,
                    ProtectedActionRequirement.customerAccount,
                  );
              context.go(AppRoutePaths.signIn);
            } else {
              ref.read(sessionControllerProvider.notifier).switchToCustomer();
            }
          },
          secondaryLabel: session.isGuest ? l10n.authSignUpTitle : null,
          onSecondary: session.isGuest
              ? () {
                  ref
                      .read(sessionControllerProvider.notifier)
                      .setPendingProtectedPath(
                        AppRoutePaths.settings,
                        ProtectedActionRequirement.customerAccount,
                      );
                  context.go(AppRoutePaths.signUp);
                }
              : null,
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.settingsTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.settingsDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.settingsNotificationsTitle,
              subtitle: l10n.settingsNotificationsSubtitle,
              children: [
                SettingsTile(
                  title: l10n.settingsNotificationsTitle,
                  subtitle: l10n.notificationsAccountShortcut,
                  leading: const Icon(Icons.notifications_outlined),
                  onTap: () =>
                      context.go(AppRoutePaths.notificationPreferences),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.settingsAppPreferencesTitle,
              children: [
                SettingsTile(
                  title: l10n.settingsLanguageTitle,
                  subtitle: l10n.settingsLanguageSubtitle,
                  leading: const Icon(Icons.language_outlined),
                ),
                SettingsTile(
                  title: l10n.settingsAreaContextTitle,
                  subtitle: preferences.preferredArea,
                  leading: const Icon(Icons.pin_drop_outlined),
                  onTap: () => context.go(AppRoutePaths.profileAddresses),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.settingsHelpTitle,
              children: [
                SettingsTile(
                  title: l10n.supportTitle,
                  subtitle: l10n.supportEntrySubtitle,
                  leading: const Icon(Icons.help_outline_rounded),
                  onTap: () => context.go(AppRoutePaths.support),
                ),
                SettingsTile(
                  title: l10n.settingsPrivacyTitle,
                  subtitle: l10n.settingsPrivacySubtitle,
                  leading: const Icon(Icons.privacy_tip_outlined),
                  onTap: () => context.go(AppRoutePaths.privacyPolicy),
                ),
                SettingsTile(
                  title: l10n.settingsTermsTitle,
                  subtitle: l10n.settingsTermsSubtitle,
                  leading: const Icon(Icons.gavel_rounded),
                  onTap: () => context.go(AppRoutePaths.termsOfService),
                ),
                SettingsTile(
                  title: l10n.settingsBookingPolicyTitle,
                  subtitle: l10n.settingsBookingPolicySubtitle,
                  leading: const Icon(Icons.assignment_outlined),
                  onTap: () => context.go(AppRoutePaths.bookingPolicy),
                ),
                SettingsTile(
                  title: l10n.settingsAboutTitle,
                  subtitle: l10n.settingsAboutSubtitle,
                  leading: const Icon(Icons.info_outline_rounded),
                ),
                SettingsTile(
                  title: l10n.authSignOutTitle,
                  subtitle: l10n.authSignOutSubtitle,
                  leading: const Icon(Icons.logout_rounded),
                  onTap: () {
                    ref.read(sessionControllerProvider.notifier).signOut();
                    context.go(AppRoutePaths.onboarding);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
