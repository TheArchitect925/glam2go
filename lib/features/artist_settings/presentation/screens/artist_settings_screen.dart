import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/settings_tile.dart';
import '../../../session/application/session_providers.dart';

class ArtistSettingsScreen extends ConsumerWidget {
  const ArtistSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return AppScaffoldWrapper(
      title: l10n.artistSettingsTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistSettingsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistSettingsDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.artistSettingsNotificationsTitle,
              children: [
                SettingsTile(
                  title: l10n.settingsNotificationsTitle,
                  subtitle: l10n.notificationsArtistShortcut,
                  leading: const Icon(Icons.notifications_outlined),
                  onTap: () =>
                      context.go(AppRoutePaths.notificationPreferences),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistSettingsBusinessTitle,
              children: [
                SettingsTile(
                  title: l10n.artistProfileManagementTitle,
                  subtitle: l10n.artistSettingsProfileShortcut,
                  leading: const Icon(Icons.person_outline_rounded),
                  onTap: () =>
                      context.go(AppRoutePaths.artistProfileManagement),
                ),
                SettingsTile(
                  title: l10n.artistTravelTitle,
                  subtitle: l10n.artistSettingsTravelShortcut,
                  leading: const Icon(Icons.near_me_outlined),
                  onTap: () => context.go(AppRoutePaths.artistServiceArea),
                ),
                SettingsTile(
                  title: l10n.supportTitle,
                  subtitle: l10n.artistSettingsSupportShortcut,
                  leading: const Icon(Icons.help_outline_rounded),
                  onTap: () => context.go(AppRoutePaths.support),
                ),
                SettingsTile(
                  title: l10n.policyBookingTitle,
                  subtitle: l10n.artistSettingsPolicyShortcut,
                  leading: const Icon(Icons.policy_outlined),
                  onTap: () => context.go(AppRoutePaths.bookingPolicy),
                ),
                SettingsTile(
                  title: l10n.actionSwitchToCustomer,
                  subtitle: l10n.artistSettingsSwitchToCustomerMessage,
                  leading: const Icon(Icons.person_outline_rounded),
                  onTap: () {
                    ref
                        .read(sessionControllerProvider.notifier)
                        .switchToCustomer();
                    context.go(AppRoutePaths.home);
                  },
                ),
                SettingsTile(
                  title: l10n.authSignOutTitle,
                  subtitle: l10n.authArtistSignOutSubtitle,
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
