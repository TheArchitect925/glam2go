import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/app_tag.dart';
import '../../../../shared/widgets/artist_package_card.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../profile/application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';
import '../../../search/application/discovery_providers.dart';
import '../widgets/availability_preview_card.dart';
import '../widgets/portfolio_preview_strip.dart';

class ArtistProfileScreen extends ConsumerWidget {
  const ArtistProfileScreen({super.key, required this.artistId});

  final String artistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final profileAsync = ref.watch(artistProfileProvider(artistId));
    final favoriteArtistIds = ref.watch(favoriteArtistIdsProvider);
    final isFavorite = favoriteArtistIds.contains(artistId);

    return profileAsync.when(
      loading: () => AppScaffoldWrapper(
        title: l10n.artistProfileTitle,
        child: LoadingState(label: l10n.discoveryLoadingMessage),
      ),
      error: (error, stackTrace) => AppScaffoldWrapper(
        title: l10n.artistProfileTitle,
        child: ErrorState(
          title: l10n.discoveryLoadErrorTitle,
          message: l10n.discoveryLoadErrorMessage,
          actionLabel: l10n.actionRetry,
          onAction: () => ref.read(discoveryCatalogProvider.notifier).refresh(),
        ),
      ),
      data: (profile) {
        if (profile == null) {
          return AppScaffoldWrapper(
            title: l10n.artistProfileTitle,
            child: ErrorState(
              title: l10n.artistProfileMissingTitle,
              message: l10n.artistProfileMissingMessage,
              actionLabel: l10n.actionBrowseArtists,
              onAction: () => context.go(AppRoutePaths.searchResults),
            ),
          );
        }

        return AppScaffoldWrapper(
          title: l10n.artistProfileTitle,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeroCard(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      profile.summary.heroStartColor,
                      profile.summary.heroEndColor,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTag(
                        label: profile.summary.heroLabel,
                        tone: AppTagTone.soft,
                      ),
                      const AppGap.v(AppSpacing.lg),
                      Text(
                        profile.summary.name,
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                      const AppGap.v(AppSpacing.xs),
                      Text(
                        '${formatRating(profile.summary.reviewSummary.rating)} '
                        '(${profile.summary.reviewSummary.reviewCount}) • '
                        '${profile.summary.locationLabel}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const AppGap.v(AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: profile.summary.specialties
                            .map(
                              (tag) =>
                                  AppTag(label: tag, tone: AppTagTone.soft),
                            )
                            .toList(growable: false),
                      ),
                      const AppGap.v(AppSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: l10n.actionStartBooking,
                              onPressed: () {
                                final featuredPackage = profile.packages.first;
                                context.go(
                                  '/booking/start/artist/$artistId/package/${featuredPackage.id}',
                                );
                              },
                            ),
                          ),
                          const AppGap.h(AppSpacing.sm),
                          IconButton(
                            onPressed: () {
                              if (!session.isCustomer) {
                                ref
                                    .read(sessionControllerProvider.notifier)
                                    .setPendingProtectedAction(
                                      path: '/artists/$artistId',
                                      requirement:
                                          ProtectedActionRequirement.favorites,
                                      preferredAuthIntent: AuthIntent.signIn,
                                      artistId: artistId,
                                    );
                                showProtectedActionPrompt(
                                  context: context,
                                  title: l10n.guestFavoritesGateTitle,
                                  message: session.isGuest
                                      ? l10n.guestFavoritesActionMessage
                                      : l10n.customerModeRequiredMessage,
                                  primaryLabel: session.isGuest
                                      ? l10n.authSignInTitle
                                      : l10n.actionSwitchToCustomer,
                                  onPrimary: () {
                                    if (session.isGuest) {
                                      context.go(AppRoutePaths.signIn);
                                    } else {
                                      ref
                                          .read(
                                            sessionControllerProvider.notifier,
                                          )
                                          .switchToCustomer();
                                    }
                                  },
                                  secondaryLabel: session.isGuest
                                      ? l10n.authSignUpTitle
                                      : null,
                                  onSecondary: session.isGuest
                                      ? () => context.go(AppRoutePaths.signUp)
                                      : null,
                                );
                                return;
                              }
                              ref
                                  .read(favoriteArtistIdsProvider.notifier)
                                  .toggle(artistId);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.white.withValues(
                                alpha: 0.16,
                              ),
                              minimumSize: const Size(52, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.extraLarge,
                                ),
                              ),
                            ),
                            tooltip: isFavorite
                                ? l10n.favoritesRemoveTooltip
                                : l10n.artistFavoriteTooltip,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.artistProfileAboutTitle,
                  subtitle: profile.bio,
                ),
                const AppGap.v(AppSpacing.md),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.socialProof,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const AppGap.v(AppSpacing.md),
                      ...profile.trustSignals.map(
                        (signal) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const AppGap.h(AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  signal,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.artistProfilePortfolioTitle,
                  subtitle: l10n.artistProfilePortfolioSubtitle,
                ),
                const AppGap.v(AppSpacing.md),
                PortfolioPreviewStrip(items: profile.portfolioItems),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.artistProfilePackagesTitle,
                  subtitle: l10n.artistProfilePackagesSubtitle,
                ),
                const AppGap.v(AppSpacing.md),
                ...profile.packages.map(
                  (artistPackage) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ArtistPackageCard(
                      artistPackage: artistPackage,
                      actionLabel: l10n.artistProfilePackageAction,
                      onPressed: () => context.go(
                        '/artists/$artistId/packages/${artistPackage.id}',
                      ),
                    ),
                  ),
                ),
                const AppGap.v(AppSpacing.lg),
                AvailabilityPreviewCard(
                  preview: profile.availabilityPreview,
                  title: l10n.artistProfileAvailabilityTitle,
                ),
                const AppGap.v(AppSpacing.md),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.artistProfileTravelTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const AppGap.v(AppSpacing.sm),
                      Text(
                        l10n.artistProfileTravelRadius(
                          profile.travelPolicy.includedRadiusKm,
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const AppGap.v(AppSpacing.xs),
                      Text(
                        l10n.artistProfileTravelFee(
                          formatCurrency(profile.travelPolicy.extraFeeFrom),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const AppGap.v(AppSpacing.xs),
                      Text(
                        l10n.artistProfileTravelDistance(
                          profile.travelPolicy.maxTravelDistanceKm,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const AppGap.v(AppSpacing.md),
                      Text(
                        profile.travelPolicy.summary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const AppGap.v(AppSpacing.md),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.artistProfileReviewTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const AppGap.v(AppSpacing.xs),
                      Text(
                        profile.summary.reviewSummary.highlight,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
