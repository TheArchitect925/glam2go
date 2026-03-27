import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_hero_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../artist_bookings/presentation/widgets/artist_booking_card.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../widgets/artist_completion_card.dart';
import '../widgets/artist_summary_card.dart';

class ArtistDashboardScreen extends ConsumerWidget {
  const ArtistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(artistManagementControllerProvider);
    final readiness = ref.watch(artistReadinessProvider);
    final upcoming =
        ref.watch(artistUpcomingBookingsProvider).valueOrNull ?? const [];
    final pending =
        ref.watch(artistPendingBookingsProvider).valueOrNull ?? const [];
    final activePackageCount = state.packages
        .where((item) => item.isActive)
        .length;
    final availableDayCount = state.availabilityDays
        .where((item) => item.isAvailable && item.windows.isNotEmpty)
        .length;
    final missingLabels = readiness.missingItems
        .map((item) => _localizedMissingItem(context, item))
        .toList(growable: false);

    return AppScaffoldWrapper(
      title: l10n.artistDashboardTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeroCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.artistDashboardHeadline,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const AppGap.v(AppSpacing.sm),
                  Text(
                    l10n.artistDashboardDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            ArtistCompletionCard(
              title: l10n.artistDashboardCompletionTitle,
              progressLabel: l10n.artistReadinessProgress(
                readiness.completedCount,
                readiness.totalCount,
              ),
              progress: readiness.progress,
              missingItems: missingLabels,
            ),
            const AppGap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: ArtistSummaryCard(
                    title: l10n.artistDashboardPackagesTitle,
                    value: '$activePackageCount',
                    subtitle: l10n.artistPackageCount(activePackageCount),
                    icon: Icons.inventory_2_outlined,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: ArtistSummaryCard(
                    title: l10n.artistDashboardAvailabilityTitle,
                    value: '$availableDayCount',
                    subtitle: l10n.artistDashboardAvailabilitySubtitle,
                    icon: Icons.schedule_outlined,
                  ),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: ArtistSummaryCard(
                    title: l10n.artistDashboardServiceAreaTitle,
                    value: state.travelPolicy.primaryServiceArea,
                    subtitle: l10n.artistTravelRadiusValue(
                      state.travelPolicy.includedRadiusKm,
                    ),
                    icon: Icons.near_me_outlined,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: ArtistSummaryCard(
                    title: l10n.artistDashboardBookingsTitle,
                    value: '${pending.length}',
                    subtitle: l10n.artistDashboardPendingBookingsSubtitle(
                      upcoming.length,
                    ),
                    icon: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.xl),
            SectionHeader(
              title: l10n.artistDashboardQuickActionsTitle,
              subtitle: l10n.artistDashboardQuickActionsSubtitle,
            ),
            const AppGap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.artistDashboardEditProfileCta,
                    onPressed: () =>
                        context.go(AppRoutePaths.artistProfileManagement),
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.artistDashboardManagePackagesCta,
                    onPressed: () => context.go(AppRoutePaths.artistPackages),
                    tone: AppButtonTone.secondary,
                  ),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.artistDashboardManageAvailabilityCta,
                    onPressed: () =>
                        context.go(AppRoutePaths.artistAvailability),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.artistDashboardViewBookingsCta,
                    onPressed: () => context.go(AppRoutePaths.artistBookings),
                    tone: AppButtonTone.secondary,
                  ),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.artistDashboardNextBookingsTitle,
              children: upcoming
                  .take(2)
                  .map(
                    (booking) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: ArtistBookingCard(booking: booking),
                    ),
                  )
                  .toList(growable: false),
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
