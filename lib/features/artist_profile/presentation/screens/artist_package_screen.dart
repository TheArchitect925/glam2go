import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/artist_package_card.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../search/application/discovery_providers.dart';
import '../../../search/domain/models/discovery_models.dart';

class ArtistPackageScreen extends ConsumerWidget {
  const ArtistPackageScreen({
    super.key,
    required this.artistId,
    required this.packageId,
  });

  final String artistId;
  final String packageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final profileAsync = ref.watch(artistProfileProvider(artistId));

    return profileAsync.when(
      loading: () => AppScaffoldWrapper(
        title: l10n.packageDetailsTitle,
        child: LoadingState(label: l10n.discoveryLoadingMessage),
      ),
      error: (error, stackTrace) => AppScaffoldWrapper(
        title: l10n.packageDetailsTitle,
        child: ErrorState(
          title: l10n.discoveryLoadErrorTitle,
          message: l10n.discoveryLoadErrorMessage,
          actionLabel: l10n.actionRetry,
          onAction: () => ref.read(discoveryCatalogProvider.notifier).refresh(),
        ),
      ),
      data: (profile) {
        ArtistPackage? artistPackage;

        if (profile != null) {
          for (final candidate in profile.packages) {
            if (candidate.id == packageId) {
              artistPackage = candidate;
              break;
            }
          }
        }

        if (profile == null || artistPackage == null) {
          return AppScaffoldWrapper(
            title: l10n.packageDetailsTitle,
            child: ErrorState(
              title: l10n.packageMissingTitle,
              message: l10n.packageMissingMessage,
              actionLabel: l10n.actionBrowseArtists,
              onAction: () => context.go(AppRoutePaths.searchResults),
            ),
          );
        }

        return AppScaffoldWrapper(
          title: l10n.packageDetailsTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: artistPackage.title,
                subtitle: l10n.packageDetailsForArtist(profile.summary.name),
              ),
              const AppGap.v(AppSpacing.lg),
              ArtistPackageCard(
                artistPackage: artistPackage,
                actionLabel: l10n.actionStartBooking,
                onPressed: () {
                  context.go(
                    '/booking/start/artist/$artistId/package/$packageId',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
