import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/favorite_artist_card.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../profile/application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final artists = ref.watch(favoriteArtistsProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.favoritesTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestFavoritesGateTitle,
          message: session.isGuest
              ? l10n.guestFavoritesGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    AppRoutePaths.favorites,
                    ProtectedActionRequirement.favorites,
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
                        AppRoutePaths.favorites,
                        ProtectedActionRequirement.favorites,
                      );
                  context.go(AppRoutePaths.signUp);
                }
              : null,
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.favoritesTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.favoritesHeadline,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const AppGap.v(AppSpacing.sm),
          Text(
            l10n.favoritesDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const AppGap.v(AppSpacing.lg),
          Expanded(
            child: artists.isEmpty
                ? EmptyState(
                    title: l10n.favoritesEmptyTitle,
                    message: l10n.favoritesEmptyMessage,
                    actionLabel: l10n.actionBrowseArtists,
                    onAction: () => context.go(AppRoutePaths.search),
                  )
                : ListView.separated(
                    itemCount: artists.length,
                    separatorBuilder: (context, index) =>
                        const AppGap.v(AppSpacing.md),
                    itemBuilder: (context, index) {
                      final artist = artists[index];
                      return FavoriteArtistCard(
                        artist: artist,
                        viewLabel: l10n.actionViewArtistProfile,
                        removeLabel: l10n.favoritesRemoveTooltip,
                        onView: () => context.go('/artists/${artist.id}'),
                        onRemove: () {
                          ref
                              .read(favoriteArtistIdsProvider.notifier)
                              .toggle(artist.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
