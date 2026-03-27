import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';

class ArtistOnboardingScreen extends ConsumerWidget {
  const ArtistOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(artistManagementControllerProvider);
    final readiness = ref.watch(artistReadinessProvider);
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final selectedSpecialties = ref.watch(artistSelectedSpecialtiesProvider);
    final missingLabels = readiness.missingItems
        .map((item) => _localizedMissingItem(context, item))
        .toList(growable: false);

    return AppScaffoldWrapper(
      title: l10n.artistOnboardingTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: l10n.artistOnboardingHeadline,
              subtitle: l10n.artistOnboardingDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.artistOnboardingWelcomeTitle,
              subtitle: l10n.artistOnboardingWelcomeSubtitle,
              children: [
                Text(
                  l10n.artistOnboardingCurrentStep(
                    state.onboardingStep.index + 1,
                    ArtistOnboardingStep.values.length,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingProfileStepTitle,
              subtitle: state.profileDraft.displayName,
              children: [
                Text(
                  state.profileDraft.bio,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingSpecialtiesTitle,
              subtitle: selectedSpecialties.join(', '),
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: state.profileDraft.specialties
                      .map(
                        (item) => FilterChip(
                          label: Text(item.label),
                          selected: item.isSelected,
                          onSelected: (_) =>
                              controller.toggleSpecialty(item.label),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingTravelTitle,
              subtitle: l10n.artistTravelSummaryValue(
                state.travelPolicy.primaryServiceArea,
                state.travelPolicy.includedRadiusKm,
              ),
              children: [
                Text(
                  state.travelPolicy.travelNotes,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingPackagesTitle,
              subtitle: l10n.artistPackageCount(state.packages.length),
              children: [
                Text(
                  l10n.artistOnboardingPackagesSummary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingAvailabilityTitle,
              subtitle: l10n.artistAvailabilityDayCount(
                state.availabilityDays.where((item) => item.isAvailable).length,
              ),
              children: [
                Text(
                  l10n.artistOnboardingAvailabilitySummary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.artistOnboardingSummaryTitle,
              subtitle: l10n.artistReadinessProgress(
                readiness.completedCount,
                readiness.totalCount,
              ),
              children: [
                if (readiness.missingItems.isEmpty)
                  Text(
                    l10n.artistOnboardingSummaryReady,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                else
                  Text(
                    l10n.artistOnboardingSummaryMissing(
                      missingLabels.join(', '),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
            const AppGap.v(AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.artistOnboardingContinueCta,
                    onPressed: () => context.go(AppRoutePaths.artistDashboard),
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.artistOnboardingEditProfileCta,
                    onPressed: () =>
                        context.go(AppRoutePaths.artistProfileManagement),
                    tone: AppButtonTone.secondary,
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

String _localizedMissingItem(BuildContext context, String value) {
  final l10n = context.l10n;
  return switch (value) {
    'profile' => l10n.artistReadinessProfileLabel,
    'specialties' => l10n.artistReadinessSpecialtiesLabel,
    'travel' => l10n.artistReadinessTravelLabel,
    'packages' => l10n.artistReadinessPackagesLabel,
    'availability' => l10n.artistReadinessAvailabilityLabel,
    _ => value,
  };
}
