import 'package:go_router/go_router.dart';

import '../features/artist_profile/presentation/screens/artist_package_screen.dart';
import '../features/artist_profile/presentation/screens/artist_profile_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/booking/presentation/screens/booking_checkout_screen.dart';
import '../features/booking/presentation/screens/booking_confirmation_screen.dart';
import '../features/booking/presentation/screens/booking_date_time_screen.dart';
import '../features/booking/presentation/screens/booking_location_screen.dart';
import '../features/booking/presentation/screens/booking_start_screen.dart';
import '../features/bookings/presentation/screens/booking_detail_screen.dart';
import '../features/bookings/presentation/screens/bookings_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/profile/presentation/screens/profile_edit_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
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
  static const bookingDateTime = '/booking/date-time';
  static const bookingLocation = '/booking/location';
  static const bookingCheckout = '/booking/checkout';
  static const settings = '/settings';
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
  static const bookingDateTime = 'bookingDateTime';
  static const bookingLocation = 'bookingLocation';
  static const bookingCheckout = 'bookingCheckout';
  static const bookingConfirmation = 'bookingConfirmation';
  static const bookingDetail = 'bookingDetail';
  static const profileEdit = 'profileEdit';
  static const settings = 'settings';
}

GoRouter buildAppRouter() {
  return GoRouter(
    initialLocation: AppRoutePaths.splash,
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
        path: AppRoutePaths.bookingDateTime,
        name: AppRouteNames.bookingDateTime,
        builder: (context, state) => const BookingDateTimeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingLocation,
        name: AppRouteNames.bookingLocation,
        builder: (context, state) => const BookingLocationScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.bookingCheckout,
        name: AppRouteNames.bookingCheckout,
        builder: (context, state) => const BookingCheckoutScreen(),
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
        path: AppRoutePaths.settings,
        name: AppRouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
