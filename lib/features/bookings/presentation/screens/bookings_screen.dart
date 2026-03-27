import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../booking/application/marketplace_booking_providers.dart';
import '../../../profile/application/account_providers.dart';
import '../../../profile/domain/models/account_models.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';
import '../widgets/customer_booking_card.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final upcomingBookingsAsync = ref.watch(upcomingBookingsProvider);
    final pastBookingsAsync = ref.watch(pastBookingsProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.bookingsTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestBookingsGateTitle,
          message: session.isGuest
              ? l10n.guestBookingsGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    AppRoutePaths.bookings,
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
                        AppRoutePaths.bookings,
                        ProtectedActionRequirement.customerAccount,
                      );
                  context.go(AppRoutePaths.signUp);
                }
              : null,
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.bookingsTitle,
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.bookingsHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.bookingsDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.lg),
            TabBar(
              tabs: [
                Tab(text: l10n.bookingsUpcomingTab),
                Tab(text: l10n.bookingsPastTab),
              ],
            ),
            const AppGap.v(AppSpacing.lg),
            Expanded(
              child: TabBarView(
                children: [
                  upcomingBookingsAsync.when(
                    data: (bookings) => _BookingsList(
                      bookings: bookings,
                      emptyTitle: l10n.bookingsUpcomingEmptyTitle,
                      emptyMessage: l10n.bookingsUpcomingEmptyMessage,
                      emptyActionLabel: l10n.actionBrowseArtists,
                      onEmptyAction: () => context.go(AppRoutePaths.home),
                    ),
                    loading: () =>
                        LoadingState(label: l10n.bookingLoadingMessage),
                    error: (error, stackTrace) => ErrorState(
                      title: l10n.bookingLoadErrorTitle,
                      message: l10n.bookingLoadErrorMessage,
                      actionLabel: l10n.actionRetry,
                      onAction: () => ref
                          .read(marketplaceBookingsControllerProvider.notifier)
                          .refresh(),
                    ),
                  ),
                  pastBookingsAsync.when(
                    data: (bookings) => _BookingsList(
                      bookings: bookings,
                      emptyTitle: l10n.bookingsPastEmptyTitle,
                      emptyMessage: l10n.bookingsPastEmptyMessage,
                      emptyActionLabel: l10n.actionBrowseArtists,
                      onEmptyAction: () => context.go(AppRoutePaths.search),
                    ),
                    loading: () =>
                        LoadingState(label: l10n.bookingLoadingMessage),
                    error: (error, stackTrace) => ErrorState(
                      title: l10n.bookingLoadErrorTitle,
                      message: l10n.bookingLoadErrorMessage,
                      actionLabel: l10n.actionRetry,
                      onAction: () => ref
                          .read(marketplaceBookingsControllerProvider.notifier)
                          .refresh(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  const _BookingsList({
    required this.bookings,
    required this.emptyTitle,
    required this.emptyMessage,
    required this.emptyActionLabel,
    required this.onEmptyAction,
  });

  final List<CustomerBookingDetails> bookings;
  final String emptyTitle;
  final String emptyMessage;
  final String emptyActionLabel;
  final VoidCallback onEmptyAction;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyState(
        title: emptyTitle,
        message: emptyMessage,
        actionLabel: emptyActionLabel,
        onAction: onEmptyAction,
      );
    }

    return ListView.separated(
      itemCount: bookings.length,
      separatorBuilder: (context, index) => const AppGap.v(AppSpacing.md),
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return CustomerBookingCard(
          booking: booking,
          onTap: () => context.go('/bookings/${booking.id}'),
        );
      },
    );
  }
}
