// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Glam2GO';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionBrowseArtists => 'Browse artists';

  @override
  String get actionViewSearchResults => 'View search results';

  @override
  String get actionViewArtistProfile => 'Open artist profile';

  @override
  String get actionStartBooking => 'Start booking';

  @override
  String get actionChooseDateTime => 'Choose date and time';

  @override
  String get actionChooseLocation => 'Choose location';

  @override
  String get actionReviewBooking => 'Review booking';

  @override
  String get actionConfirmBooking => 'Confirm booking';

  @override
  String get actionViewBookingDetail => 'Open booking detail';

  @override
  String get actionOpenSettings => 'Open settings';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get splashLoading => 'Preparing the Glam2GO booking baseline.';

  @override
  String get onboardingTitle => 'Beauty booking, organized cleanly.';

  @override
  String get onboardingSubtitle =>
      'The baseline app shell is ready for customer discovery and booking flows.';

  @override
  String get onboardingStatus =>
      'Onboarding is intentionally lean in this pass. Authentication and role setup will be implemented in feature-focused passes.';

  @override
  String get authSignInTitle => 'Sign in';

  @override
  String get authSignInDescription =>
      'Authentication entry scaffold for returning customers and artists.';

  @override
  String get authSignUpTitle => 'Create account';

  @override
  String get authSignUpDescription =>
      'Registration scaffold for the Glam2GO marketplace.';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeHeadline => 'Discovery starts here.';

  @override
  String get homeDescription =>
      'This home scaffold will grow into the premium discovery surface for nearby artists, trust signals, and occasion-led entry points.';

  @override
  String get homeStatus =>
      'Home is scaffolded with router, theme, and localization wiring only.';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchHeadline => 'Search and filter artists.';

  @override
  String get searchDescription =>
      'Search is wired into the app shell and ready for real filtering state in a future pass.';

  @override
  String get searchStatus =>
      'Search is scaffolded but intentionally not populated with fake data.';

  @override
  String get searchResultsTitle => 'Search results';

  @override
  String get searchResultsHeadline => 'Review candidate artists.';

  @override
  String get searchResultsDescription =>
      'Results routing is in place so the discovery flow can deepen without route drift.';

  @override
  String get searchResultsStatus =>
      'No seeded artist catalog is shown in this pass.';

  @override
  String get artistProfileTitle => 'Artist profile';

  @override
  String get artistProfileHeadline => 'Evaluate artist fit.';

  @override
  String get artistProfileStatus =>
      'Artist profile is scaffolded for portfolio, package, pricing, and trust sections.';

  @override
  String get packageDetailsTitle => 'Package details';

  @override
  String get packageDetailsHeadline => 'Inspect package details cleanly.';

  @override
  String get packageDetailsStatus =>
      'Package detail scaffolding exists without fake package content.';

  @override
  String get bookingStartTitle => 'Booking';

  @override
  String get bookingStartHeadline => 'Start a structured booking.';

  @override
  String get bookingStartDescription =>
      'The booking entry flow is wired and ready for real booking state.';

  @override
  String get bookingStartStatus =>
      'No backend booking state or payment integration is attached in this pass.';

  @override
  String get bookingDateTimeTitle => 'Date and time';

  @override
  String get bookingDateTimeHeadline => 'Choose the appointment slot.';

  @override
  String get bookingDateTimeDescription =>
      'Date and time selection will connect to artist availability in a dedicated booking pass.';

  @override
  String get bookingDateTimeStatus =>
      'Availability logic is intentionally not implemented yet.';

  @override
  String get bookingLocationTitle => 'Location';

  @override
  String get bookingLocationHeadline => 'Set the service address.';

  @override
  String get bookingLocationDescription =>
      'Location and travel-fee rules will build on the booking foundation without hiding pricing impact.';

  @override
  String get bookingLocationStatus =>
      'Address collection and distance pricing remain future implementation work.';

  @override
  String get bookingCheckoutTitle => 'Checkout';

  @override
  String get bookingCheckoutHeadline => 'Review before confirmation.';

  @override
  String get bookingCheckoutDescription =>
      'Checkout is present as a route and UI scaffold only.';

  @override
  String get bookingCheckoutStatus =>
      'Payment remains a placeholder architecture concern for a later pass.';

  @override
  String get bookingConfirmationTitle => 'Confirmation';

  @override
  String get bookingConfirmationHeadline =>
      'Booking confirmation will live here.';

  @override
  String get bookingConfirmationStatus =>
      'Confirmation is scaffolded as a stable destination route.';

  @override
  String get bookingsTitle => 'Bookings';

  @override
  String get bookingsHeadline => 'Track upcoming and past bookings.';

  @override
  String get bookingsDescription =>
      'Bookings are part of the authenticated customer shell from the start.';

  @override
  String get bookingsStatus =>
      'Booking history data and states will be added in a dedicated pass.';

  @override
  String get bookingDetailTitle => 'Booking detail';

  @override
  String get bookingDetailHeadline => 'Review one booking.';

  @override
  String get bookingDetailStatus =>
      'This route exists now to keep detail navigation stable.';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get favoritesHeadline => 'Save artists worth revisiting.';

  @override
  String get favoritesDescription =>
      'Favorites are scaffolded as a first-class customer destination.';

  @override
  String get favoritesStatus => 'No persistence layer is connected yet.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileHeadline => 'Manage your account.';

  @override
  String get profileDescription =>
      'Profile and settings stay narrow in V1 and expand only when justified.';

  @override
  String get profileStatus =>
      'Profile is scaffolded for account-level work, not yet feature-complete.';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileEditHeadline => 'Update account details.';

  @override
  String get profileEditDescription =>
      'Profile editing is reserved as a stable route for future implementation.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsHeadline => 'Control app preferences.';

  @override
  String get settingsDescription =>
      'Settings will grow carefully as localization and account options mature.';

  @override
  String get settingsStatus =>
      'Settings are intentionally minimal in this pass.';

  @override
  String get scaffoldIncompleteMessage =>
      'This screen is a baseline scaffold only. Business logic and production content will be added in later feature passes.';

  @override
  String artistProfileDescription(Object artistId) {
    return 'Artist profile route loaded for artist id: $artistId.';
  }

  @override
  String packageDetailsDescription(Object packageId) {
    return 'Package detail route loaded for package id: $packageId.';
  }

  @override
  String bookingSelectedPackageDescription(Object artistId, Object packageId) {
    return 'Booking route loaded for artist $artistId and package $packageId.';
  }

  @override
  String bookingConfirmationDescription(Object bookingId) {
    return 'Confirmation route loaded for booking id: $bookingId.';
  }

  @override
  String bookingDetailDescription(Object bookingId) {
    return 'Booking detail route loaded for booking id: $bookingId.';
  }
}
