import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/notification_preference_tile.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';
import '../../application/account_providers.dart';

final _notificationDeliveryStateProvider =
    FutureProvider<DeviceRegistrationState>((ref) async {
      ref.watch(notificationDeliveryRefreshProvider);
      final session = ref.watch(sessionControllerProvider);
      return ref.read(notificationServiceProvider).syncSession(session);
    });

class NotificationPreferencesScreen extends ConsumerWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);

    if (!session.isAuthenticated) {
      return AppScaffoldWrapper(
        title: l10n.settingsNotificationsTitle,
        child: ProtectedFeatureGate(
          title: l10n.notificationsGateTitle,
          message: l10n.notificationsGateMessage,
          primaryLabel: l10n.authSignInTitle,
          onPrimary: () {
            ref
                .read(sessionControllerProvider.notifier)
                .setPendingProtectedAction(
                  path: AppRoutePaths.notificationPreferences,
                  requirement: ProtectedActionRequirement.customerAccount,
                  preferredAuthIntent: AuthIntent.signIn,
                );
            context.go(AppRoutePaths.signIn);
          },
          secondaryLabel: l10n.authSignUpTitle,
          onSecondary: () {
            ref
                .read(sessionControllerProvider.notifier)
                .setPendingProtectedAction(
                  path: AppRoutePaths.notificationPreferences,
                  requirement: ProtectedActionRequirement.customerAccount,
                  preferredAuthIntent: AuthIntent.signUp,
                );
            context.go(AppRoutePaths.signUp);
          },
        ),
      );
    }

    return session.isArtist
        ? const _ArtistNotificationPreferencesView()
        : const _CustomerNotificationPreferencesView();
  }
}

class _CustomerNotificationPreferencesView extends ConsumerWidget {
  const _CustomerNotificationPreferencesView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final preferences = ref.watch(userPreferencesProvider);
    final controller = ref.read(userPreferencesProvider.notifier);
    final deliveryState = ref.watch(_notificationDeliveryStateProvider);

    return AppScaffoldWrapper(
      title: l10n.settingsNotificationsTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.notificationsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.notificationsCustomerDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.settingsNotificationsTitle,
              subtitle: l10n.settingsNotificationsSubtitle,
              children: [
                AppCard(
                  child: deliveryState.when(
                    data: (state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.notificationsDeliveryTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const AppGap.v(AppSpacing.xxs),
                        Text(
                          state.isSessionBound
                              ? l10n.notificationsDeliverySignedIn
                              : l10n.notificationsDeliveryPlaceholder,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Text(l10n.notificationsDeliveryError),
                  ),
                ),
                const AppGap.v(AppSpacing.md),
                AppCard(
                  child: Column(
                    children: [
                      NotificationPreferenceTile(
                        value:
                            preferences.notificationPreferences.bookingUpdates,
                        onChanged: controller.setBookingUpdates,
                        title: l10n.settingsBookingUpdatesTitle,
                        subtitle: l10n.settingsBookingUpdatesSubtitle,
                      ),
                      NotificationPreferenceTile(
                        value:
                            preferences.notificationPreferences.artistResponses,
                        onChanged: controller.setArtistResponses,
                        title: l10n.notificationsArtistResponsesTitle,
                        subtitle: l10n.notificationsArtistResponsesSubtitle,
                      ),
                      NotificationPreferenceTile(
                        value: preferences.notificationPreferences.reminders,
                        onChanged: controller.setReminders,
                        title: l10n.settingsRemindersTitle,
                        subtitle: l10n.settingsRemindersSubtitle,
                      ),
                      NotificationPreferenceTile(
                        value: preferences.notificationPreferences.promotions,
                        onChanged: controller.setPromotions,
                        title: l10n.settingsPromotionsTitle,
                        subtitle: l10n.settingsPromotionsSubtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArtistNotificationPreferencesView extends ConsumerWidget {
  const _ArtistNotificationPreferencesView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(artistManagementControllerProvider);
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final deliveryState = ref.watch(_notificationDeliveryStateProvider);

    return AppScaffoldWrapper(
      title: l10n.settingsNotificationsTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.notificationsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.notificationsArtistDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.artistSettingsNotificationsTitle,
              subtitle: l10n.artistSettingsDescription,
              children: [
                AppCard(
                  child: deliveryState.when(
                    data: (delivery) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.notificationsDeliveryTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const AppGap.v(AppSpacing.xxs),
                        Text(
                          delivery.isSessionBound
                              ? l10n.notificationsDeliverySignedIn
                              : l10n.notificationsDeliveryPlaceholder,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Text(l10n.notificationsDeliveryError),
                  ),
                ),
                const AppGap.v(AppSpacing.md),
                AppCard(
                  child: Column(
                    children: [
                      NotificationPreferenceTile(
                        value: state.notificationsEnabled,
                        onChanged: controller.setNotificationsEnabled,
                        title: l10n.artistSettingsRequestsTitle,
                        subtitle: l10n.artistSettingsRequestsSubtitle,
                      ),
                      NotificationPreferenceTile(
                        value: state.businessNotificationsEnabled,
                        onChanged: controller.setBusinessNotificationsEnabled,
                        title: l10n.artistSettingsBusinessTitle,
                        subtitle: l10n.artistSettingsBusinessSubtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
