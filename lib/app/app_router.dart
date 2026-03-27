import 'package:go_router/go_router.dart';

import '../features/session/domain/models/session_models.dart';
import '../features/artist_availability/presentation/screens/artist_availability_screen.dart';
import '../features/artist_availability/presentation/screens/artist_service_area_screen.dart';
import '../features/artist_bookings/presentation/screens/artist_bookings_screen.dart';
import '../features/artist_dashboard/presentation/screens/artist_dashboard_screen.dart';
import '../features/artist_onboarding/presentation/screens/artist_onboarding_screen.dart';
import '../features/artist_packages/presentation/screens/artist_packages_screen.dart';
import '../features/artist_profile/presentation/screens/artist_package_screen.dart';
import '../features/artist_profile/presentation/screens/artist_profile_screen.dart';
import '../features/artist_profile_management/presentation/screens/artist_portfolio_management_screen.dart';
import '../features/artist_profile_management/presentation/screens/artist_profile_management_screen.dart';
import '../features/artist_settings/presentation/screens/artist_settings_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/booking/presentation/screens/booking_confirmation_screen.dart';
import '../features/booking/presentation/screens/booking_date_screen.dart';
import '../features/booking/presentation/screens/booking_details_screen.dart';
import '../features/booking/presentation/screens/booking_location_screen.dart';
import '../features/booking/presentation/screens/booking_review_screen.dart';
import '../features/booking/presentation/screens/booking_start_screen.dart';
import '../features/booking/presentation/screens/booking_time_screen.dart';
import '../features/bookings/presentation/screens/booking_detail_screen.dart';
import '../features/bookings/presentation/screens/bookings_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/profile/presentation/screens/profile_edit_screen.dart';
import '../features/profile/presentation/screens/notification_preferences_screen.dart';
import '../features/profile/presentation/screens/policy_surface_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/saved_addresses_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
import '../features/profile/presentation/screens/support_screen.dart';
import '../features/search/presentation/screens/search_results_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../shared/widgets/app_shell.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const home = '/home';
  static const search = '/search';
  static const searchResults = '/search/results';
  static const bookings = '/bookings';
  static const favorites = '/favorites';
  static const profile = '/profile';
  static const bookingStart = '/booking/start';
  static const bookingDetails = '/booking/details';
  static const bookingDate = '/booking/date';
  static const bookingTime = '/booking/time';
  static const bookingLocation = '/booking/location';
  static const bookingReview = '/booking/review';
  static const settings = '/settings';
  static const notificationPreferences = '/settings/notifications';
  static const profileAddresses = '/profile/addresses';
  static const support = '/support';
  static const privacyPolicy = '/support/privacy';
  static const termsOfService = '/support/terms';
  static const cancellationPolicy = '/support/cancellation';
  static const bookingPolicy = '/support/booking-policy';
  static const artistOnboarding = '/artist/onboarding';
  static const artistDashboard = '/artist/dashboard';
  static const artistBookings = '/artist/bookings';
  static const artistSettings = '/artist/settings';
  static const artistProfileManagement = '/artist/profile';
  static const artistPortfolio = '/artist/portfolio';
  static const artistPackages = '/artist/packages';
  static const artistAvailability = '/artist/availability';
  static const artistServiceArea = '/artist/service-area';
}

class AppRouteNames {
  const AppRouteNames._();

  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const signIn = 'signIn';
  static const signUp = 'signUp';
  static const home = 'home';
  static const search = 'search';
  static const searchResults = 'searchResults';
  static const bookings = 'bookings';
  static const favorites = 'favorites';
  static const profile = 'profile';
  static const artistProfile = 'artistProfile';
  static const artistPackage = 'artistPackage';
  static const bookingStart = 'bookingStart';
  static const bookingArtistPackage = 'bookingArtistPackage';
  static const bookingDetails = 'bookingDetails';
  static const bookingDate = 'bookingDate';
  static const bookingTime = 'bookingTime';
  static const bookingLocation = 'bookingLocation';
  static const bookingReview = 'bookingReview';
  static const bookingConfirmation = 'bookingConfirmation';
  static const bookingDetail = 'bookingDetail';
  static const profileEdit = 'profileEdit';
  static const profileAddresses = 'profileAddresses';
  static const settings = 'settings';
  static const notificationPreferences = 'notificationPreferences';
  static const support = 'support';
  static const privacyPolicy = 'privacyPolicy';
  static const termsOfService = 'termsOfService';
  static const cancellationPolicy = 'cancellationPolicy';
  static const bookingPolicy = 'bookingPolicy';
  static const artistOnboarding = 'artistOnboarding';
  static const artistDashboard = 'artistDashboard';
  static const artistBookings = 'artistBookings';
  static const artistSettings = 'artistSettings';
  static const artistProfileManagement = 'artistProfileManagement';
  static const artistPortfolio = 'artistPortfolio';
  static const artistPackages = 'artistPackages';
  static const artistAvailability = 'artistAvailability';
  static const artistServiceArea = 'artistServiceArea';
}

GoRouter buildAppRouter(
  SessionState session, {
  double artistReadinessProgress = 0,
  String initialLocation = AppRoutePaths.splash,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) {
      final path = state.uri.path;
      final isArtistRoute =
          path.startsWith('/artist') && path != AppRoutePaths.artistOnboarding;
      final isAuthEntryRoute =
          path == AppRoutePaths.onboarding ||
          path == AppRoutePaths.signIn ||
          path == AppRoutePaths.signUp;

      if (isArtistRoute && !session.isArtist) {
        return AppRoutePaths.artistOnboarding;
      }

      if (session.isAuthenticated && isAuthEntryRoute) {
        if (session.pendingProtectedAction != null) {
          return session.pendingProtectedAction!.path;
        }

        if (session.isArtist) {
          return artistReadinessProgress >= 1
              ? AppRoutePaths.artistDashboard
              : AppRoutePaths.artistOnboarding;
        }

        return AppRoutePaths.home;
      }

      if (path == AppRoutePaths.artistOnboarding &&
          session.isArtist &&
          artistReadinessProgress >= 1) {
        return AppRoutePaths.artistDashboard;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', redirect: (_, state) => AppRoutePaths.splash),
      GoRoute(
        path: AppRoutePaths.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.onboarding,
        name: AppRouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signIn,
        name: AppRouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signUp,
        name: AppRouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.artistOnboarding,
        name: AppRouteNames.artistOnboarding,
        builder: (context, state) => const ArtistOnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.home,
                name: AppRouteNames.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.search,
                name: AppRouteNames.search,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SearchScreen()),
                routes: [
                  GoRoute(
                    path: 'results',
                    name: AppRouteNames.searchResults,
                    builder: (context, state) => const SearchResultsScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.bookings,
                name: AppRouteNames.bookings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: BookingsScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.favorites,
                name: AppRouteNames.favorites,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FavoritesScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.profile,
                name: AppRouteNames.profile,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ArtistShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.artistDashboard,
                name: AppRouteNames.artistDashboard,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ArtistDashboardScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.artistBookings,
                name: AppRouteNames.artistBookings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ArtistBookingsScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.artistSettings,
                name: AppRouteNames.artistSettings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ArtistSettingsScreen()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/artists/:artistId',
        name: AppRouteNames.artistProfile,
        builder: (context, state) {
          return ArtistProfileScreen(
            artistId: state.pathParameters['artistId']!,
          );
        },
        routes: [
          GoRoute(
            path: 'packages/:packageId',
            name: AppRouteNames.artistPackage,
            builder: (context, state) {
              return ArtistPackageScreen(
                artistId: state.pathParameters['artistId']!,
                packageId: state.pathParameters['packageId']!,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.bookingStart,
        name: AppRouteNames.bookingStart,
        builder: (context, state) => const BookingStartScreen(),
        routes: [
          GoRoute(
            path: 'artist/:artistId/package/:packageId',
            name: AppRouteNames.bookingArtistPackage,
            builder: (context, state) {
              return BookingStartScreen(
                artistId: state.pathParameters['artistId'],
                packageId: state.pathParameters['packageId'],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.bookingDetails,
        name: AppRouteNames.bookingDetails,
        builder: (context, state) => const BookingDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingDate,
        name: AppRouteNames.bookingDate,
        builder: (context, state) => const BookingDateScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingTime,
        name: AppRouteNames.bookingTime,
        builder: (context, state) => const BookingTimeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingLocation,
        name: AppRouteNames.bookingLocation,
        builder: (context, state) => const BookingLocationScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingReview,
        name: AppRouteNames.bookingReview,
        builder: (context, state) => const BookingReviewScreen(),
      ),
      GoRoute(
        path: '/booking/confirmation/:bookingId',
        name: AppRouteNames.bookingConfirmation,
        builder: (context, state) {
          return BookingConfirmationScreen(
            bookingId: state.pathParameters['bookingId']!,
          );
        },
      ),
      GoRoute(
        path: '/bookings/:bookingId',
        name: AppRouteNames.bookingDetail,
        builder: (context, state) {
          return BookingDetailScreen(
            bookingId: state.pathParameters['bookingId']!,
          );
        },
      ),
      GoRoute(
        path: '/profile/edit',
        name: AppRouteNames.profileEdit,
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.profileAddresses,
        name: AppRouteNames.profileAddresses,
        builder: (context, state) => const SavedAddressesScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        name: AppRouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.notificationPreferences,
        name: AppRouteNames.notificationPreferences,
        builder: (context, state) => const NotificationPreferencesScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.support,
        name: AppRouteNames.support,
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.privacyPolicy,
        name: AppRouteNames.privacyPolicy,
        builder: (context, state) =>
            const PolicySurfaceScreen(surface: PolicySurfaceType.privacy),
      ),
      GoRoute(
        path: AppRoutePaths.termsOfService,
        name: AppRouteNames.termsOfService,
        builder: (context, state) =>
            const PolicySurfaceScreen(surface: PolicySurfaceType.terms),
      ),
      GoRoute(
        path: AppRoutePaths.cancellationPolicy,
        name: AppRouteNames.cancellationPolicy,
        builder: (context, state) =>
            const PolicySurfaceScreen(surface: PolicySurfaceType.cancellation),
      ),
      GoRoute(
        path: AppRoutePaths.bookingPolicy,
        name: AppRouteNames.bookingPolicy,
        builder: (context, state) =>
            const PolicySurfaceScreen(surface: PolicySurfaceType.booking),
      ),
      GoRoute(
        path: AppRoutePaths.artistProfileManagement,
        name: AppRouteNames.artistProfileManagement,
        builder: (context, state) => const ArtistProfileManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.artistPortfolio,
        name: AppRouteNames.artistPortfolio,
        builder: (context, state) => const ArtistPortfolioManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.artistPackages,
        name: AppRouteNames.artistPackages,
        builder: (context, state) => const ArtistPackagesScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.artistAvailability,
        name: AppRouteNames.artistAvailability,
        builder: (context, state) => const ArtistAvailabilityScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.artistServiceArea,
        name: AppRouteNames.artistServiceArea,
        builder: (context, state) => const ArtistServiceAreaScreen(),
      ),
    ],
  );
}
