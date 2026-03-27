import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../booking/application/marketplace_booking_providers.dart';
import '../../../booking/domain/models/marketplace_booking_models.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';
import '../widgets/artist_booking_card.dart';

class ArtistBookingsScreen extends ConsumerWidget {
  const ArtistBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final pending = ref.watch(artistPendingBookingsProvider);
    final upcoming = ref.watch(artistUpcomingBookingsProvider);
    final past = ref.watch(artistPastBookingsProvider);

    return AppScaffoldWrapper(
      title: l10n.artistBookingsTitle,
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistBookingsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistBookingsDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.lg),
            TabBar(
              tabs: [
                Tab(text: l10n.artistBookingsRequestsTab),
                Tab(text: l10n.artistBookingsUpcomingTab),
                Tab(text: l10n.artistBookingsPastTab),
              ],
            ),
            const AppGap.v(AppSpacing.lg),
            Expanded(
              child: TabBarView(
                children: [
                  _ArtistBookingsList(bookingsAsync: pending),
                  _ArtistBookingsList(bookingsAsync: upcoming),
                  _ArtistBookingsList(bookingsAsync: past),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArtistBookingsList extends ConsumerWidget {
  const _ArtistBookingsList({required this.bookingsAsync});

  final AsyncValue<List<ArtistBookingSummary>> bookingsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return bookingsAsync.when(
      data: (bookings) {
        if (bookings.isEmpty) {
          return EmptyState(
            title: l10n.artistBookingsEmptyTitle,
            message: l10n.artistBookingsEmptyMessage,
          );
        }

        final mutatingIds = ref.watch(marketplaceBookingMutationIdsProvider);

        return ListView.separated(
          itemCount: bookings.length,
          separatorBuilder: (context, index) => const AppGap.v(AppSpacing.md),
          itemBuilder: (context, index) {
            final booking = bookings[index];
            final isMutating = mutatingIds.contains(booking.id);
            return ArtistBookingCard(
              booking: booking,
              acceptLabel: isMutating ? null : l10n.artistBookingAcceptCta,
              declineLabel: isMutating ? null : l10n.artistBookingDeclineCta,
              onAccept:
                  booking.status ==
                          BookingLifecycleStatus.pendingArtistResponse &&
                      !isMutating
                  ? () => ref
                        .read(marketplaceBookingsControllerProvider.notifier)
                        .applyArtistDecision(
                          booking.id,
                          BookingRequestDecision.accept,
                        )
                  : null,
              onDecline:
                  booking.status ==
                          BookingLifecycleStatus.pendingArtistResponse &&
                      !isMutating
                  ? () => ref
                        .read(marketplaceBookingsControllerProvider.notifier)
                        .applyArtistDecision(
                          booking.id,
                          BookingRequestDecision.decline,
                        )
                  : null,
            );
          },
        );
      },
      loading: () => LoadingState(label: l10n.bookingLoadingMessage),
      error: (error, stackTrace) => ErrorState(
        title: l10n.bookingLoadErrorTitle,
        message: l10n.bookingLoadErrorMessage,
        actionLabel: l10n.actionRetry,
        onAction: () =>
            ref.read(marketplaceBookingsControllerProvider.notifier).refresh(),
      ),
    );
  }
}
