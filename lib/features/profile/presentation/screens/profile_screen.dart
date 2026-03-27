import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../../shared/widgets/settings_tile.dart';
import '../../application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final profile = ref.watch(customerProfileProvider);
    final preferences = ref.watch(userPreferencesProvider);
    final defaultAddress = ref.watch(defaultSavedAddressProvider);
    final upcomingBookings =
        ref.watch(upcomingBookingsProvider).valueOrNull ?? const [];
    final favoriteArtists = ref.watch(favoriteArtistsProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.profileTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestProfileGateTitle,
          message: session.isGuest
              ? l10n.guestProfileGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    AppRoutePaths.profile,
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
                        AppRoutePaths.profile,
                        ProtectedActionRequirement.customerAccount,
                      );
                  context.go(AppRoutePaths.signUp);
                }
              : null,
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.profileTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeroCard(
              gradient: AppGradients.accountHero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.white.withValues(alpha: 0.88),
                    child: Text(
                      profile.displayName.characters.first.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const AppGap.v(AppSpacing.md),
                  Text(
                    profile.displayName,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const AppGap.v(AppSpacing.xxs),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const AppGap.v(AppSpacing.xxs),
                  Text(
                    profile.memberSinceLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            if (session.userSummary?.isNewAccount == true) ...[
              AppCard(
                tone: AppCardTone.muted,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileWelcomeTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const AppGap.v(AppSpacing.xs),
                    Text(
                      l10n.profileWelcomeMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const AppGap.v(AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: l10n.savedAddressesTitle,
                            onPressed: () =>
                                context.go(AppRoutePaths.profileAddresses),
                            tone: AppButtonTone.secondary,
                          ),
                        ),
                        const AppGap.h(AppSpacing.md),
                        Expanded(
                          child: AppButton(
                            label: l10n.settingsNotificationsTitle,
                            onPressed: () => context.go(
                              AppRoutePaths.notificationPreferences,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const AppGap.v(AppSpacing.md),
            ],
            ProfileSectionGroup(
              title: l10n.profileHubTitle,
              subtitle: l10n.profileHubSubtitle,
              children: [
                SettingsTile(
                  title: l10n.bookingsTitle,
                  subtitle: l10n.profileBookingsSummary(
                    upcomingBookings.length,
                  ),
                  leading: const Icon(Icons.calendar_month_outlined),
                  onTap: () => context.go(AppRoutePaths.bookings),
                ),
                SettingsTile(
                  title: l10n.favoritesTitle,
                  subtitle: l10n.profileFavoritesSummary(
                    favoriteArtists.length,
                  ),
                  leading: const Icon(Icons.favorite_border_rounded),
                  onTap: () => context.go(AppRoutePaths.favorites),
                ),
                SettingsTile(
                  title: l10n.savedAddressesTitle,
                  subtitle:
                      defaultAddress?.shortLabel ??
                      l10n.profileNoDefaultAddressSummary,
                  leading: const Icon(Icons.home_outlined),
                  onTap: () => context.go(AppRoutePaths.profileAddresses),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.profilePreferencesTitle,
              subtitle: l10n.profilePreferencesSubtitle,
              children: [
                SettingsTile(
                  title: l10n.profilePreferredAreaTitle,
                  subtitle: preferences.preferredArea,
                  leading: const Icon(Icons.near_me_outlined),
                ),
                SettingsTile(
                  title: l10n.profilePreferredOccasionsTitle,
                  subtitle: preferences.preferredOccasions.join(', '),
                  leading: const Icon(Icons.auto_awesome_outlined),
                ),
                SettingsTile(
                  title: l10n.profileCommunicationTitle,
                  subtitle: preferences.communicationPreference,
                  leading: const Icon(Icons.notifications_active_outlined),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.profileAccountTitle,
              children: [
                SettingsTile(
                  title: l10n.profileEditTitle,
                  subtitle: l10n.profileEditDescription,
                  leading: const Icon(Icons.edit_outlined),
                  onTap: () => context.go('/profile/edit'),
                ),
                SettingsTile(
                  title: l10n.settingsTitle,
                  subtitle: l10n.settingsDescription,
                  leading: const Icon(Icons.settings_outlined),
                  onTap: () => context.go(AppRoutePaths.settings),
                ),
                SettingsTile(
                  title: l10n.settingsNotificationsTitle,
                  subtitle: l10n.profileNotificationsShortcut,
                  leading: const Icon(Icons.notifications_outlined),
                  onTap: () =>
                      context.go(AppRoutePaths.notificationPreferences),
                ),
                SettingsTile(
                  title: l10n.supportTitle,
                  subtitle: l10n.supportDescription,
                  leading: const Icon(Icons.help_outline_rounded),
                  onTap: () => context.go(AppRoutePaths.support),
                ),
                SettingsTile(
                  title: l10n.actionSwitchToArtist,
                  subtitle: l10n.profileSwitchToArtistMessage,
                  leading: const Icon(Icons.storefront_outlined),
                  onTap: () {
                    ref
                        .read(sessionControllerProvider.notifier)
                        .switchToArtist();
                    context.go(AppRoutePaths.artistDashboard);
                  },
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
