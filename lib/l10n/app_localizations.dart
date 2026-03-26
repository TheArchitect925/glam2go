import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Glam2GO'**
  String get appName;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionBrowseArtists.
  ///
  /// In en, this message translates to:
  /// **'Browse artists'**
  String get actionBrowseArtists;

  /// No description provided for @actionViewSearchResults.
  ///
  /// In en, this message translates to:
  /// **'View search results'**
  String get actionViewSearchResults;

  /// No description provided for @actionViewArtistProfile.
  ///
  /// In en, this message translates to:
  /// **'Open artist profile'**
  String get actionViewArtistProfile;

  /// No description provided for @actionStartBooking.
  ///
  /// In en, this message translates to:
  /// **'Start booking'**
  String get actionStartBooking;

  /// No description provided for @actionChooseDateTime.
  ///
  /// In en, this message translates to:
  /// **'Choose date and time'**
  String get actionChooseDateTime;

  /// No description provided for @actionChooseLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose location'**
  String get actionChooseLocation;

  /// No description provided for @actionReviewBooking.
  ///
  /// In en, this message translates to:
  /// **'Review booking'**
  String get actionReviewBooking;

  /// No description provided for @actionConfirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking'**
  String get actionConfirmBooking;

  /// No description provided for @actionViewBookingDetail.
  ///
  /// In en, this message translates to:
  /// **'Open booking detail'**
  String get actionViewBookingDetail;

  /// No description provided for @actionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get actionOpenSettings;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Preparing the Glam2GO booking baseline.'**
  String get splashLoading;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Beauty booking, organized cleanly.'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The baseline app shell is ready for customer discovery and booking flows.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingStatus.
  ///
  /// In en, this message translates to:
  /// **'Onboarding is intentionally lean in this pass. Authentication and role setup will be implemented in feature-focused passes.'**
  String get onboardingStatus;

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInTitle;

  /// No description provided for @authSignInDescription.
  ///
  /// In en, this message translates to:
  /// **'Authentication entry scaffold for returning customers and artists.'**
  String get authSignInDescription;

  /// No description provided for @authSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authSignUpTitle;

  /// No description provided for @authSignUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Registration scaffold for the Glam2GO marketplace.'**
  String get authSignUpDescription;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Discovery starts here.'**
  String get homeHeadline;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'This home scaffold will grow into the premium discovery surface for nearby artists, trust signals, and occasion-led entry points.'**
  String get homeDescription;

  /// No description provided for @homeStatus.
  ///
  /// In en, this message translates to:
  /// **'Home is scaffolded with router, theme, and localization wiring only.'**
  String get homeStatus;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchHeadline.
  ///
  /// In en, this message translates to:
  /// **'Search and filter artists.'**
  String get searchHeadline;

  /// No description provided for @searchDescription.
  ///
  /// In en, this message translates to:
  /// **'Search is wired into the app shell and ready for real filtering state in a future pass.'**
  String get searchDescription;

  /// No description provided for @searchStatus.
  ///
  /// In en, this message translates to:
  /// **'Search is scaffolded but intentionally not populated with fake data.'**
  String get searchStatus;

  /// No description provided for @searchResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get searchResultsTitle;

  /// No description provided for @searchResultsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review candidate artists.'**
  String get searchResultsHeadline;

  /// No description provided for @searchResultsDescription.
  ///
  /// In en, this message translates to:
  /// **'Results routing is in place so the discovery flow can deepen without route drift.'**
  String get searchResultsDescription;

  /// No description provided for @searchResultsStatus.
  ///
  /// In en, this message translates to:
  /// **'No seeded artist catalog is shown in this pass.'**
  String get searchResultsStatus;

  /// No description provided for @artistProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist profile'**
  String get artistProfileTitle;

  /// No description provided for @artistProfileHeadline.
  ///
  /// In en, this message translates to:
  /// **'Evaluate artist fit.'**
  String get artistProfileHeadline;

  /// No description provided for @artistProfileStatus.
  ///
  /// In en, this message translates to:
  /// **'Artist profile is scaffolded for portfolio, package, pricing, and trust sections.'**
  String get artistProfileStatus;

  /// No description provided for @packageDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Package details'**
  String get packageDetailsTitle;

  /// No description provided for @packageDetailsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Inspect package details cleanly.'**
  String get packageDetailsHeadline;

  /// No description provided for @packageDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Package detail scaffolding exists without fake package content.'**
  String get packageDetailsStatus;

  /// No description provided for @bookingStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get bookingStartTitle;

  /// No description provided for @bookingStartHeadline.
  ///
  /// In en, this message translates to:
  /// **'Start a structured booking.'**
  String get bookingStartHeadline;

  /// No description provided for @bookingStartDescription.
  ///
  /// In en, this message translates to:
  /// **'The booking entry flow is wired and ready for real booking state.'**
  String get bookingStartDescription;

  /// No description provided for @bookingStartStatus.
  ///
  /// In en, this message translates to:
  /// **'No backend booking state or payment integration is attached in this pass.'**
  String get bookingStartStatus;

  /// No description provided for @bookingDateTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get bookingDateTimeTitle;

  /// No description provided for @bookingDateTimeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Choose the appointment slot.'**
  String get bookingDateTimeHeadline;

  /// No description provided for @bookingDateTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Date and time selection will connect to artist availability in a dedicated booking pass.'**
  String get bookingDateTimeDescription;

  /// No description provided for @bookingDateTimeStatus.
  ///
  /// In en, this message translates to:
  /// **'Availability logic is intentionally not implemented yet.'**
  String get bookingDateTimeStatus;

  /// No description provided for @bookingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get bookingLocationTitle;

  /// No description provided for @bookingLocationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set the service address.'**
  String get bookingLocationHeadline;

  /// No description provided for @bookingLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Location and travel-fee rules will build on the booking foundation without hiding pricing impact.'**
  String get bookingLocationDescription;

  /// No description provided for @bookingLocationStatus.
  ///
  /// In en, this message translates to:
  /// **'Address collection and distance pricing remain future implementation work.'**
  String get bookingLocationStatus;

  /// No description provided for @bookingCheckoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get bookingCheckoutTitle;

  /// No description provided for @bookingCheckoutHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review before confirmation.'**
  String get bookingCheckoutHeadline;

  /// No description provided for @bookingCheckoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Checkout is present as a route and UI scaffold only.'**
  String get bookingCheckoutDescription;

  /// No description provided for @bookingCheckoutStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment remains a placeholder architecture concern for a later pass.'**
  String get bookingCheckoutStatus;

  /// No description provided for @bookingConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get bookingConfirmationTitle;

  /// No description provided for @bookingConfirmationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Booking confirmation will live here.'**
  String get bookingConfirmationHeadline;

  /// No description provided for @bookingConfirmationStatus.
  ///
  /// In en, this message translates to:
  /// **'Confirmation is scaffolded as a stable destination route.'**
  String get bookingConfirmationStatus;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTitle;

  /// No description provided for @bookingsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Track upcoming and past bookings.'**
  String get bookingsHeadline;

  /// No description provided for @bookingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Bookings are part of the authenticated customer shell from the start.'**
  String get bookingsDescription;

  /// No description provided for @bookingsStatus.
  ///
  /// In en, this message translates to:
  /// **'Booking history data and states will be added in a dedicated pass.'**
  String get bookingsStatus;

  /// No description provided for @bookingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking detail'**
  String get bookingDetailTitle;

  /// No description provided for @bookingDetailHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review one booking.'**
  String get bookingDetailHeadline;

  /// No description provided for @bookingDetailStatus.
  ///
  /// In en, this message translates to:
  /// **'This route exists now to keep detail navigation stable.'**
  String get bookingDetailStatus;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesHeadline.
  ///
  /// In en, this message translates to:
  /// **'Save artists worth revisiting.'**
  String get favoritesHeadline;

  /// No description provided for @favoritesDescription.
  ///
  /// In en, this message translates to:
  /// **'Favorites are scaffolded as a first-class customer destination.'**
  String get favoritesDescription;

  /// No description provided for @favoritesStatus.
  ///
  /// In en, this message translates to:
  /// **'No persistence layer is connected yet.'**
  String get favoritesStatus;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileHeadline.
  ///
  /// In en, this message translates to:
  /// **'Manage your account.'**
  String get profileHeadline;

  /// No description provided for @profileDescription.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings stay narrow in V1 and expand only when justified.'**
  String get profileDescription;

  /// No description provided for @profileStatus.
  ///
  /// In en, this message translates to:
  /// **'Profile is scaffolded for account-level work, not yet feature-complete.'**
  String get profileStatus;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditHeadline.
  ///
  /// In en, this message translates to:
  /// **'Update account details.'**
  String get profileEditHeadline;

  /// No description provided for @profileEditDescription.
  ///
  /// In en, this message translates to:
  /// **'Profile editing is reserved as a stable route for future implementation.'**
  String get profileEditDescription;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Control app preferences.'**
  String get settingsHeadline;

  /// No description provided for @settingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Settings will grow carefully as localization and account options mature.'**
  String get settingsDescription;

  /// No description provided for @settingsStatus.
  ///
  /// In en, this message translates to:
  /// **'Settings are intentionally minimal in this pass.'**
  String get settingsStatus;

  /// No description provided for @scaffoldIncompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This screen is a baseline scaffold only. Business logic and production content will be added in later feature passes.'**
  String get scaffoldIncompleteMessage;

  /// No description provided for @artistProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Artist profile route loaded for artist id: {artistId}.'**
  String artistProfileDescription(Object artistId);

  /// No description provided for @packageDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Package detail route loaded for package id: {packageId}.'**
  String packageDetailsDescription(Object packageId);

  /// No description provided for @bookingSelectedPackageDescription.
  ///
  /// In en, this message translates to:
  /// **'Booking route loaded for artist {artistId} and package {packageId}.'**
  String bookingSelectedPackageDescription(Object artistId, Object packageId);

  /// No description provided for @bookingConfirmationDescription.
  ///
  /// In en, this message translates to:
  /// **'Confirmation route loaded for booking id: {bookingId}.'**
  String bookingConfirmationDescription(Object bookingId);

  /// No description provided for @bookingDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Booking detail route loaded for booking id: {bookingId}.'**
  String bookingDetailDescription(Object bookingId);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
