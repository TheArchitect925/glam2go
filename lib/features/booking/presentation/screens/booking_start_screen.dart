import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../search/application/discovery_providers.dart';
import '../../application/booking_flow_controller.dart';
import '../../domain/models/booking_models.dart';
import '../widgets/booking_package_card.dart';
import '../widgets/booking_step_header.dart';

class BookingStartScreen extends ConsumerStatefulWidget {
  const BookingStartScreen({super.key, this.artistId, this.packageId});

  final String? artistId;
  final String? packageId;

  @override
  ConsumerState<BookingStartScreen> createState() => _BookingStartScreenState();
}

class _BookingStartScreenState extends ConsumerState<BookingStartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.artistId != null) {
        ref
            .read(bookingFlowControllerProvider.notifier)
            .startFlow(
              artistId: widget.artistId!,
              preselectedPackageId: widget.packageId,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = ref.watch(bookingFlowControllerProvider);
    final effectiveArtistId = widget.artistId ?? draft.artistId;
    final profileAsync = effectiveArtistId == null
        ? null
        : ref.watch(artistProfileProvider(effectiveArtistId));
    final snapshotProfile = effectiveArtistId == null
        ? null
        : ref.watch(artistProfileSnapshotProvider(effectiveArtistId));

    if (effectiveArtistId == null ||
        (profileAsync == null && snapshotProfile == null)) {
      return AppScaffoldWrapper(
        title: l10n.bookingStartTitle,
        child: EmptyState(
          title: l10n.bookingStartMissingArtistTitle,
          message: l10n.bookingStartMissingArtistMessage,
          actionLabel: l10n.actionBrowseArtists,
          onAction: () => context.go(AppRoutePaths.searchResults),
        ),
      );
    }

    if (snapshotProfile != null && profileAsync?.isLoading == true) {
      return _buildContent(context, ref, l10n, draft, snapshotProfile);
    }

    return profileAsync!.when(
      loading: () => AppScaffoldWrapper(
        title: l10n.bookingStartTitle,
        child: LoadingState(label: l10n.discoveryLoadingMessage),
      ),
      error: (error, stackTrace) => AppScaffoldWrapper(
        title: l10n.bookingStartTitle,
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
            title: l10n.bookingStartTitle,
            child: EmptyState(
              title: l10n.bookingStartMissingArtistTitle,
              message: l10n.bookingStartMissingArtistMessage,
              actionLabel: l10n.actionBrowseArtists,
              onAction: () => context.go(AppRoutePaths.searchResults),
            ),
          );
        }

        return _buildContent(context, ref, l10n, draft, profile);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    BookingDraft draft,
    dynamic profile,
  ) {
    return AppScaffoldWrapper(
      title: l10n.bookingStartTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStepHeader(
              currentStep: BookingFlowStep.service,
              title: l10n.bookingStartHeadline,
              subtitle: l10n.bookingStartDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.summary.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const AppGap.v(AppSpacing.xs),
                  Text(
                    profile.summary.locationLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const AppGap.v(AppSpacing.sm),
                  Text(
                    profile.travelPolicy.summary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            ...profile.packages.map<Widget>(
              (artistPackage) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: BookingPackageCard(
                  artistPackage: artistPackage,
                  isSelected: draft.selectedPackage?.id == artistPackage.id,
                  onTap: () {
                    ref
                        .read(bookingFlowControllerProvider.notifier)
                        .selectPackage(artistPackage);
                  },
                ),
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            AppButton(
              label: l10n.bookingContinueToDetails,
              onPressed: draft.canContinueFromService
                  ? () {
                      ref
                          .read(bookingFlowControllerProvider.notifier)
                          .setStep(BookingFlowStep.details);
                      context.go(AppRoutePaths.bookingDetails);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
