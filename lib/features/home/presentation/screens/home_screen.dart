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
import '../../../../shared/widgets/artist_package_card.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../search/application/discovery_providers.dart';
import '../../../search/presentation/widgets/artist_summary_card.dart';
import '../../../search/presentation/widgets/occasion_filter_chips.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final discoveryCatalog = ref.watch(discoveryCatalogProvider);
    final selectedOccasion = ref.watch(selectedOccasionProvider);

    return discoveryCatalog.when(
      data: (_) {
        final featuredArtists =
            ref.watch(featuredArtistsProvider).valueOrNull ?? const [];
        final popularPackages =
            ref.watch(popularPackagesProvider).valueOrNull ?? const [];
        final occasions =
            ref.watch(occasionOptionsProvider).valueOrNull ?? const [];

        return AppScaffoldWrapper(
          title: l10n.homeTitle,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeroCard(
                  gradient: AppGradients.softHero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeServiceAreaEyebrow,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const AppGap.v(AppSpacing.xs),
                      Text(
                        l10n.homeHeadline,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const AppGap.v(AppSpacing.sm),
                      Text(
                        l10n.homeDescription,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const AppGap.v(AppSpacing.lg),
                      AppButton(
                        label: l10n.actionBrowseArtists,
                        onPressed: () => context.go(AppRoutePaths.search),
                      ),
                    ],
                  ),
                ),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.homeOccasionsTitle,
                  subtitle: l10n.homeOccasionsSubtitle,
                ),
                const AppGap.v(AppSpacing.md),
                OccasionFilterChips(
                  options: occasions,
                  selectedValue: selectedOccasion,
                  onSelected: (value) {
                    ref.read(selectedOccasionProvider.notifier).state = value;
                    context.go(AppRoutePaths.search);
                  },
                ),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.homeFeaturedArtistsTitle,
                  subtitle: l10n.homeFeaturedArtistsSubtitle,
                  trailing: TextButton(
                    onPressed: () => context.go(AppRoutePaths.searchResults),
                    child: Text(l10n.homeSeeAllLabel),
                  ),
                ),
                const AppGap.v(AppSpacing.md),
                SizedBox(
                  height: 560,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final artist = featuredArtists[index];

                      return SizedBox(
                        width: 308,
                        child: ArtistSummaryCard(
                          artist: artist,
                          compact: true,
                          viewProfileLabel: l10n.actionViewArtistProfile,
                          onViewProfile: () =>
                              context.go('/artists/${artist.id}'),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const AppGap.h(AppSpacing.md),
                    itemCount: featuredArtists.length,
                  ),
                ),
                const AppGap.v(AppSpacing.xl),
                SectionHeader(
                  title: l10n.homePopularPackagesTitle,
                  subtitle: l10n.homePopularPackagesSubtitle,
                ),
                const AppGap.v(AppSpacing.md),
                ...popularPackages.map(
                  (artistPackage) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ArtistPackageCard(
                      artistPackage: artistPackage,
                      actionLabel: l10n.homePackageAction,
                      onPressed: () {
                        final profiles =
                            ref.read(artistProfilesProvider).valueOrNull ??
                            const [];
                        final profile = profiles.firstWhere(
                          (item) => item.packages.any(
                            (candidate) => candidate.id == artistPackage.id,
                          ),
                        );
                        context.go(
                          '/artists/${profile.summary.id}/packages/${artistPackage.id}',
                        );
                      },
                    ),
                  ),
                ),
                const AppGap.v(AppSpacing.xl),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeTrustTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const AppGap.v(AppSpacing.sm),
                      _TrustLine(label: l10n.homeTrustPricing),
                      const AppGap.v(AppSpacing.xs),
                      _TrustLine(label: l10n.homeTrustTravel),
                      const AppGap.v(AppSpacing.xs),
                      _TrustLine(label: l10n.homeTrustAvailability),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => AppScaffoldWrapper(
        title: l10n.homeTitle,
        child: LoadingState(label: l10n.discoveryLoadingMessage),
      ),
      error: (error, stackTrace) => AppScaffoldWrapper(
        title: l10n.homeTitle,
        child: ErrorState(
          title: l10n.discoveryLoadErrorTitle,
          message: l10n.discoveryLoadErrorMessage,
          actionLabel: l10n.actionRetry,
          onAction: () {
            ref.read(discoveryCatalogProvider.notifier).refresh();
          },
        ),
      ),
    );
  }
}

class _TrustLine extends StatelessWidget {
  const _TrustLine({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: AppColors.primary,
        ),
        const AppGap.h(AppSpacing.xs),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
