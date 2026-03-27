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

  /// No description provided for @actionExploreResults.
  ///
  /// In en, this message translates to:
  /// **'See all results'**
  String get actionExploreResults;

  /// No description provided for @actionBecomeArtist.
  ///
  /// In en, this message translates to:
  /// **'Become an artist'**
  String get actionBecomeArtist;

  /// No description provided for @actionContinueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get actionContinueAsGuest;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionSubmitBookingRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit booking request'**
  String get actionSubmitBookingRequest;

  /// No description provided for @actionSignInToSubmitRequest.
  ///
  /// In en, this message translates to:
  /// **'Sign in to submit request'**
  String get actionSignInToSubmitRequest;

  /// No description provided for @actionSwitchToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Switch to customer mode'**
  String get actionSwitchToCustomer;

  /// No description provided for @actionSwitchToArtist.
  ///
  /// In en, this message translates to:
  /// **'Switch to artist workspace'**
  String get actionSwitchToArtist;

  /// No description provided for @actionKeepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep booking'**
  String get actionKeepBooking;

  /// No description provided for @priceStartingFrom.
  ///
  /// In en, this message translates to:
  /// **'From {price}'**
  String priceStartingFrom(Object price);

  /// No description provided for @packageDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String packageDurationMinutes(int minutes);

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

  /// No description provided for @artistNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get artistNavDashboard;

  /// No description provided for @artistNavBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get artistNavBookings;

  /// No description provided for @artistNavSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get artistNavSettings;

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
  /// **'Return to your saved account context and continue the action you started.'**
  String get authSignInDescription;

  /// No description provided for @authSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authSignUpTitle;

  /// No description provided for @authSignUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a customer or artist account without losing your current browsing momentum.'**
  String get authSignUpDescription;

  /// No description provided for @authSignUpArtistHint.
  ///
  /// In en, this message translates to:
  /// **'Artists can start setup from here and build their public business presence without leaving the shared app.'**
  String get authSignUpArtistHint;

  /// No description provided for @authContinueAsCustomer.
  ///
  /// In en, this message translates to:
  /// **'Continue as customer'**
  String get authContinueAsCustomer;

  /// No description provided for @authContinueAsArtist.
  ///
  /// In en, this message translates to:
  /// **'Continue as artist'**
  String get authContinueAsArtist;

  /// No description provided for @authPendingActionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your browsing context is preserved. Continue with a role so you can finish the protected action without starting over.'**
  String get authPendingActionMessage;

  /// No description provided for @authSignInHelper.
  ///
  /// In en, this message translates to:
  /// **'Continue with your Glam2GO account details to restore your session and resume protected actions cleanly.'**
  String get authSignInHelper;

  /// No description provided for @authCreateAccountHelper.
  ///
  /// In en, this message translates to:
  /// **'Create an account without losing your route context, booking intent, or protected-action continuation.'**
  String get authCreateAccountHelper;

  /// No description provided for @authRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'We could not complete that account request. Please try again.'**
  String get authRequestFailed;

  /// No description provided for @authCredentialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get authCredentialsTitle;

  /// No description provided for @authCreateAccountDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authCreateAccountDetailsTitle;

  /// No description provided for @authNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get authNameFieldLabel;

  /// No description provided for @authNameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'How your account should appear in Glam2GO'**
  String get authNameFieldHint;

  /// No description provided for @authNameValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter a name to continue.'**
  String get authNameValidationMessage;

  /// No description provided for @authEmailFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get authEmailFieldLabel;

  /// No description provided for @authEmailFieldHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get authEmailFieldHint;

  /// No description provided for @authEmailValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authEmailValidationMessage;

  /// No description provided for @authBookingResumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your booking draft is still in progress. Sign in or create an account and the request review step will be ready to resume.'**
  String get authBookingResumeMessage;

  /// No description provided for @authFavoritesResumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your saved-artist action is waiting. Continue with an account and Glam2GO will return you to the same artist profile.'**
  String get authFavoritesResumeMessage;

  /// No description provided for @authArtistResumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Artist tools are account-only. Continue with an artist account to enter setup or dashboard routes cleanly.'**
  String get authArtistResumeMessage;

  /// No description provided for @authAccountResumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account route is preserved. Continue and Glam2GO will return you to the same place without restarting.'**
  String get authAccountResumeMessage;

  /// No description provided for @authDevShortcutTitle.
  ///
  /// In en, this message translates to:
  /// **'Development shortcut'**
  String get authDevShortcutTitle;

  /// No description provided for @authDevShortcutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a default local account when you want to skip manual entry during product work.'**
  String get authDevShortcutSubtitle;

  /// No description provided for @authUseDefaultCustomer.
  ///
  /// In en, this message translates to:
  /// **'Use default customer account'**
  String get authUseDefaultCustomer;

  /// No description provided for @authUseDefaultArtist.
  ///
  /// In en, this message translates to:
  /// **'Use default artist account'**
  String get authUseDefaultArtist;

  /// No description provided for @authCreateAccountInlineCta.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Create one'**
  String get authCreateAccountInlineCta;

  /// No description provided for @authAlreadyHaveAccountCta.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authAlreadyHaveAccountCta;

  /// No description provided for @authCreateCustomerAccount.
  ///
  /// In en, this message translates to:
  /// **'Create customer account'**
  String get authCreateCustomerAccount;

  /// No description provided for @authCreateArtistAccount.
  ///
  /// In en, this message translates to:
  /// **'Join as artist'**
  String get authCreateArtistAccount;

  /// No description provided for @authSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get authSignOutTitle;

  /// No description provided for @authSignOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Return to guest mode and keep browsing without account-only actions.'**
  String get authSignOutSubtitle;

  /// No description provided for @authArtistSignOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leave the artist workspace and return to guest browsing mode.'**
  String get authArtistSignOutSubtitle;

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
  /// **'Browse artists for bridal, nikkah, soft glam, photoshoots, and formal events with clear pricing and travel expectations.'**
  String get homeDescription;

  /// No description provided for @homeServiceAreaEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Serving Toronto and the GTA'**
  String get homeServiceAreaEyebrow;

  /// No description provided for @homeOccasionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Book by occasion'**
  String get homeOccasionsTitle;

  /// No description provided for @homeOccasionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Jump straight into artists that fit the event you are planning.'**
  String get homeOccasionsSubtitle;

  /// No description provided for @homeFeaturedArtistsTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured artists'**
  String get homeFeaturedArtistsTitle;

  /// No description provided for @homeFeaturedArtistsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A premium shortlist with strong ratings, clear travel policies, and booking momentum.'**
  String get homeFeaturedArtistsSubtitle;

  /// No description provided for @homeSeeAllLabel.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAllLabel;

  /// No description provided for @homePopularPackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular packages'**
  String get homePopularPackagesTitle;

  /// No description provided for @homePopularPackagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compare the most-booked service types before you commit to a profile.'**
  String get homePopularPackagesSubtitle;

  /// No description provided for @homePackageAction.
  ///
  /// In en, this message translates to:
  /// **'View package'**
  String get homePackageAction;

  /// No description provided for @homeTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'Why discovery feels clear on Glam2GO'**
  String get homeTrustTitle;

  /// No description provided for @homeTrustPricing.
  ///
  /// In en, this message translates to:
  /// **'Starting prices and package inclusions are visible early.'**
  String get homeTrustPricing;

  /// No description provided for @homeTrustTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel radius and extra distance fees are explained upfront.'**
  String get homeTrustTravel;

  /// No description provided for @homeTrustAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability previews help you decide before entering the booking flow.'**
  String get homeTrustAvailability;

  /// No description provided for @discoveryLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading artists and packages for discovery.'**
  String get discoveryLoadingMessage;

  /// No description provided for @discoveryLoadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'We could not load artists right now'**
  String get discoveryLoadErrorTitle;

  /// No description provided for @discoveryLoadErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again. Glam2GO will retry the discovery feed when you are ready.'**
  String get discoveryLoadErrorMessage;

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
  /// **'Search by artist name, occasion, or style and narrow the list with simple, readable filters.'**
  String get searchDescription;

  /// No description provided for @searchInputHint.
  ///
  /// In en, this message translates to:
  /// **'Search by artist, style, or occasion'**
  String get searchInputHint;

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
  /// **'Compare artists quickly by trust signals, travel fit, availability, and starting price.'**
  String get searchResultsDescription;

  /// No description provided for @sortPlaceholderLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortPlaceholderLabel;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No artists match that search yet'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a broader search or clear the occasion filter to see more available artists.'**
  String get searchEmptyMessage;

  /// No description provided for @searchEmptyReset.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get searchEmptyReset;

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

  /// No description provided for @artistProfileAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About this artist'**
  String get artistProfileAboutTitle;

  /// No description provided for @artistProfilePortfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio preview'**
  String get artistProfilePortfolioTitle;

  /// No description provided for @artistProfilePortfolioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick look at finish, style direction, and event fit.'**
  String get artistProfilePortfolioSubtitle;

  /// No description provided for @artistProfilePackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Packages and services'**
  String get artistProfilePackagesTitle;

  /// No description provided for @artistProfilePackagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear inclusions, duration, and starting price before the booking flow.'**
  String get artistProfilePackagesSubtitle;

  /// No description provided for @artistProfilePackageAction.
  ///
  /// In en, this message translates to:
  /// **'Select package'**
  String get artistProfilePackageAction;

  /// No description provided for @artistProfileAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability preview'**
  String get artistProfileAvailabilityTitle;

  /// No description provided for @artistProfileTravelTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel and service area'**
  String get artistProfileTravelTitle;

  /// No description provided for @artistProfileReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Client signal'**
  String get artistProfileReviewTitle;

  /// No description provided for @artistProfileMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist not found'**
  String get artistProfileMissingTitle;

  /// No description provided for @artistProfileMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'This artist profile is no longer available.'**
  String get artistProfileMissingMessage;

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

  /// No description provided for @packageMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Package not found'**
  String get packageMissingTitle;

  /// No description provided for @packageMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'This package is no longer available for booking.'**
  String get packageMissingMessage;

  /// No description provided for @bookingStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get bookingStartTitle;

  /// No description provided for @bookingStartHeadline.
  ///
  /// In en, this message translates to:
  /// **'Choose your service.'**
  String get bookingStartHeadline;

  /// No description provided for @bookingStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Confirm the package you want before moving into event details, schedule selection, and location pricing.'**
  String get bookingStartDescription;

  /// No description provided for @bookingStartMissingArtistTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an artist first'**
  String get bookingStartMissingArtistTitle;

  /// No description provided for @bookingStartMissingArtistMessage.
  ///
  /// In en, this message translates to:
  /// **'Start booking from an artist profile or package so the flow knows who you are booking with.'**
  String get bookingStartMissingArtistMessage;

  /// No description provided for @bookingContinueToDetails.
  ///
  /// In en, this message translates to:
  /// **'Continue to event details'**
  String get bookingContinueToDetails;

  /// No description provided for @bookingDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get bookingDetailsTitle;

  /// No description provided for @bookingDetailsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set the booking context.'**
  String get bookingDetailsHeadline;

  /// No description provided for @bookingDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep this step lean: tell the artist what type of event this is and anything important about the look.'**
  String get bookingDetailsDescription;

  /// No description provided for @bookingOccasionField.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get bookingOccasionField;

  /// No description provided for @bookingPartySizeField.
  ///
  /// In en, this message translates to:
  /// **'Party size'**
  String get bookingPartySizeField;

  /// No description provided for @bookingNotesField.
  ///
  /// In en, this message translates to:
  /// **'Booking notes'**
  String get bookingNotesField;

  /// No description provided for @bookingNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Share look preferences, start-time constraints, or anything the artist should know.'**
  String get bookingNotesHint;

  /// No description provided for @bookingBackToService.
  ///
  /// In en, this message translates to:
  /// **'Back to service'**
  String get bookingBackToService;

  /// No description provided for @bookingMissingServiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Pick a package before continuing with the booking flow.'**
  String get bookingMissingServiceMessage;

  /// No description provided for @bookingDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get bookingDateTitle;

  /// No description provided for @bookingDateHeadline.
  ///
  /// In en, this message translates to:
  /// **'Choose the appointment date.'**
  String get bookingDateHeadline;

  /// No description provided for @bookingDateDescription.
  ///
  /// In en, this message translates to:
  /// **'These dates are a preview of likely availability. Final confirmation still depends on artist approval.'**
  String get bookingDateDescription;

  /// No description provided for @bookingDateHint.
  ///
  /// In en, this message translates to:
  /// **'Flexible timing can improve approval odds.'**
  String get bookingDateHint;

  /// No description provided for @bookingBackToDetails.
  ///
  /// In en, this message translates to:
  /// **'Back to details'**
  String get bookingBackToDetails;

  /// No description provided for @bookingContinueToTime.
  ///
  /// In en, this message translates to:
  /// **'Continue to time'**
  String get bookingContinueToTime;

  /// No description provided for @bookingTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get bookingTimeTitle;

  /// No description provided for @bookingTimeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Choose a time slot.'**
  String get bookingTimeHeadline;

  /// No description provided for @bookingTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick a time that fits the appointment window and travel setup for the artist.'**
  String get bookingTimeDescription;

  /// No description provided for @bookingBackToDate.
  ///
  /// In en, this message translates to:
  /// **'Back to date'**
  String get bookingBackToDate;

  /// No description provided for @bookingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get bookingLocationTitle;

  /// No description provided for @bookingLocationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Add the service address.'**
  String get bookingLocationHeadline;

  /// No description provided for @bookingLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'This step keeps travel expectations clear before you confirm the request.'**
  String get bookingLocationDescription;

  /// No description provided for @bookingAddressLine1Field.
  ///
  /// In en, this message translates to:
  /// **'Address line 1'**
  String get bookingAddressLine1Field;

  /// No description provided for @bookingAddressLine1Hint.
  ///
  /// In en, this message translates to:
  /// **'Street address'**
  String get bookingAddressLine1Hint;

  /// No description provided for @bookingUnitField.
  ///
  /// In en, this message translates to:
  /// **'Unit or access details'**
  String get bookingUnitField;

  /// No description provided for @bookingUnitHint.
  ///
  /// In en, this message translates to:
  /// **'Apartment, condo entry, or suite number'**
  String get bookingUnitHint;

  /// No description provided for @bookingCityField.
  ///
  /// In en, this message translates to:
  /// **'City or area'**
  String get bookingCityField;

  /// No description provided for @bookingCityHint.
  ///
  /// In en, this message translates to:
  /// **'Toronto, Mississauga, Scarborough, North York...'**
  String get bookingCityHint;

  /// No description provided for @bookingAccessNotesField.
  ///
  /// In en, this message translates to:
  /// **'Access notes'**
  String get bookingAccessNotesField;

  /// No description provided for @bookingAccessNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Parking, concierge, elevator, or timing notes'**
  String get bookingAccessNotesHint;

  /// No description provided for @bookingTravelPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel preview'**
  String get bookingTravelPreviewTitle;

  /// No description provided for @bookingTravelPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel estimate will update after address review'**
  String get bookingTravelPendingTitle;

  /// No description provided for @bookingTravelIncludedTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel included for this request'**
  String get bookingTravelIncludedTitle;

  /// No description provided for @bookingTravelExtraTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional travel fee may apply'**
  String get bookingTravelExtraTitle;

  /// No description provided for @bookingBackToTime.
  ///
  /// In en, this message translates to:
  /// **'Back to time'**
  String get bookingBackToTime;

  /// No description provided for @bookingReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review booking'**
  String get bookingReviewTitle;

  /// No description provided for @bookingReviewHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review before you confirm.'**
  String get bookingReviewHeadline;

  /// No description provided for @bookingReviewDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the clean summary of what you are requesting from the artist before final submission.'**
  String get bookingReviewDescription;

  /// No description provided for @bookingReviewIncompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete the earlier booking steps before reviewing the request.'**
  String get bookingReviewIncompleteMessage;

  /// No description provided for @bookingReviewServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Service selection'**
  String get bookingReviewServiceTitle;

  /// No description provided for @bookingReviewEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get bookingReviewEventTitle;

  /// No description provided for @bookingReviewScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get bookingReviewScheduleTitle;

  /// No description provided for @bookingReviewLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location and travel'**
  String get bookingReviewLocationTitle;

  /// No description provided for @bookingReviewPriceTitle.
  ///
  /// In en, this message translates to:
  /// **'Price summary'**
  String get bookingReviewPriceTitle;

  /// No description provided for @bookingReviewApprovalNote.
  ///
  /// In en, this message translates to:
  /// **'Submitting this step sends a booking request to the artist. The appointment is only confirmed after the artist accepts.'**
  String get bookingReviewApprovalNote;

  /// No description provided for @bookingEditLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get bookingEditLabel;

  /// No description provided for @bookingArtistLabel.
  ///
  /// In en, this message translates to:
  /// **'Artist'**
  String get bookingArtistLabel;

  /// No description provided for @bookingPackageLabel.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get bookingPackageLabel;

  /// No description provided for @bookingOccasionLabel.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get bookingOccasionLabel;

  /// No description provided for @bookingPartySizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Party size'**
  String get bookingPartySizeLabel;

  /// No description provided for @bookingNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get bookingNotesLabel;

  /// No description provided for @bookingDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get bookingDateLabel;

  /// No description provided for @bookingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get bookingTimeLabel;

  /// No description provided for @bookingNoNotesValue.
  ///
  /// In en, this message translates to:
  /// **'No extra notes'**
  String get bookingNoNotesValue;

  /// No description provided for @bookingPriceSubtotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Service subtotal'**
  String get bookingPriceSubtotalLabel;

  /// No description provided for @bookingPriceTravelLabel.
  ///
  /// In en, this message translates to:
  /// **'Travel estimate'**
  String get bookingPriceTravelLabel;

  /// No description provided for @bookingPriceTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated total'**
  String get bookingPriceTotalLabel;

  /// No description provided for @bookingConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get bookingConfirmationTitle;

  /// No description provided for @bookingConfirmationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your booking request is in.'**
  String get bookingConfirmationHeadline;

  /// No description provided for @bookingConfirmationStatus.
  ///
  /// In en, this message translates to:
  /// **'Confirmation is now wired to the draft booking flow.'**
  String get bookingConfirmationStatus;

  /// No description provided for @bookingConfirmationMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'No confirmation available'**
  String get bookingConfirmationMissingTitle;

  /// No description provided for @bookingConfirmationMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'This confirmation screen needs a valid in-session booking request.'**
  String get bookingConfirmationMissingMessage;

  /// No description provided for @bookingConfirmationNextStep.
  ///
  /// In en, this message translates to:
  /// **'The artist reviews your request next. You will see accepted or declined status updates in your bookings list.'**
  String get bookingConfirmationNextStep;

  /// No description provided for @bookingConfirmationSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Requested booking'**
  String get bookingConfirmationSummaryTitle;

  /// No description provided for @bookingConfirmationHomeCta.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get bookingConfirmationHomeCta;

  /// No description provided for @bookingConfirmationBookingsCta.
  ///
  /// In en, this message translates to:
  /// **'View bookings'**
  String get bookingConfirmationBookingsCta;

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
  /// **'Review upcoming appointments, revisit past looks, and keep status, timing, and location details in one place.'**
  String get bookingsDescription;

  /// No description provided for @bookingsStatus.
  ///
  /// In en, this message translates to:
  /// **'Booking history is now connected to local account data and current in-session confirmations.'**
  String get bookingsStatus;

  /// No description provided for @bookingsUpcomingTab.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get bookingsUpcomingTab;

  /// No description provided for @bookingsPastTab.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get bookingsPastTab;

  /// No description provided for @bookingsUpcomingEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No upcoming bookings yet'**
  String get bookingsUpcomingEmptyTitle;

  /// No description provided for @bookingsUpcomingEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Once you request a booking, it will appear here with status, schedule, and travel details.'**
  String get bookingsUpcomingEmptyMessage;

  /// No description provided for @bookingsPastEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No past bookings yet'**
  String get bookingsPastEmptyTitle;

  /// No description provided for @bookingsPastEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Completed appointments will stay here for quick reference and future rebooking.'**
  String get bookingsPastEmptyMessage;

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
  /// **'Booking detail is now connected to local customer booking data.'**
  String get bookingDetailStatus;

  /// No description provided for @bookingDetailSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking summary'**
  String get bookingDetailSummaryTitle;

  /// No description provided for @bookingDetailNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking notes'**
  String get bookingDetailNotesTitle;

  /// No description provided for @bookingDetailNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What happens next'**
  String get bookingDetailNextTitle;

  /// No description provided for @bookingDetailPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Policy and support'**
  String get bookingDetailPolicyTitle;

  /// No description provided for @bookingDetailSupportCta.
  ///
  /// In en, this message translates to:
  /// **'Help and policies'**
  String get bookingDetailSupportCta;

  /// No description provided for @bookingDetailCancelCta.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get bookingDetailCancelCta;

  /// No description provided for @bookingDetailCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking request?'**
  String get bookingDetailCancelTitle;

  /// No description provided for @bookingDetailCancelMessage.
  ///
  /// In en, this message translates to:
  /// **'This keeps the request in your history, but it will no longer be treated as an active appointment or pending artist review.'**
  String get bookingDetailCancelMessage;

  /// No description provided for @bookingDetailMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking not found'**
  String get bookingDetailMissingTitle;

  /// No description provided for @bookingDetailMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'This booking detail is no longer available in the current local account state.'**
  String get bookingDetailMissingMessage;

  /// No description provided for @bookingTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Request timeline'**
  String get bookingTimelineTitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesHeadline.
  ///
  /// In en, this message translates to:
  /// **'Saved artists, ready to revisit.'**
  String get favoritesHeadline;

  /// No description provided for @favoritesDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep a short list of artists you trust so you can return to profiles and booking entry points quickly.'**
  String get favoritesDescription;

  /// No description provided for @favoritesStatus.
  ///
  /// In en, this message translates to:
  /// **'Favorites are stored locally for now and can be replaced by a connected account layer later.'**
  String get favoritesStatus;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved artists yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Save artists from their profile to build a shortlist for later booking.'**
  String get favoritesEmptyMessage;

  /// No description provided for @favoritesRemoveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get favoritesRemoveTooltip;

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
  /// **'Profile now acts as the customer account hub for bookings, favorites, addresses, and preferences.'**
  String get profileStatus;

  /// No description provided for @profileHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Account hub'**
  String get profileHubTitle;

  /// No description provided for @profileHubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Move between bookings, saved artists, and service-ready addresses without losing context.'**
  String get profileHubSubtitle;

  /// No description provided for @profileBookingsSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No upcoming bookings} one{1 upcoming booking} other{{count} upcoming bookings}}'**
  String profileBookingsSummary(int count);

  /// No description provided for @profileFavoritesSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No saved artists} one{1 saved artist} other{{count} saved artists}}'**
  String profileFavoritesSummary(int count);

  /// No description provided for @profileNoDefaultAddressSummary.
  ///
  /// In en, this message translates to:
  /// **'No default address selected yet'**
  String get profileNoDefaultAddressSummary;

  /// No description provided for @profileWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish your account setup'**
  String get profileWelcomeTitle;

  /// No description provided for @profileWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a saved address and tune notification preferences so booking requests stay easy to track.'**
  String get profileWelcomeMessage;

  /// No description provided for @profilePreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferencesTitle;

  /// No description provided for @profilePreferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A light foundation for service area context, style preferences, and notification expectations.'**
  String get profilePreferencesSubtitle;

  /// No description provided for @profilePreferredAreaTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferred service area'**
  String get profilePreferredAreaTitle;

  /// No description provided for @profilePreferredOccasionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferred occasions'**
  String get profilePreferredOccasionsTitle;

  /// No description provided for @profileCommunicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Communication preference'**
  String get profileCommunicationTitle;

  /// No description provided for @profileAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account and support'**
  String get profileAccountTitle;

  /// No description provided for @profileNotificationsShortcut.
  ///
  /// In en, this message translates to:
  /// **'Manage booking updates, artist responses, reminders, and product news.'**
  String get profileNotificationsShortcut;

  /// No description provided for @profileSwitchToArtistMessage.
  ///
  /// In en, this message translates to:
  /// **'Switch into the artist workspace without leaving the shared app.'**
  String get profileSwitchToArtistMessage;

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
  /// **'Keep the basic customer profile current so booking coordination stays straightforward.'**
  String get profileEditDescription;

  /// No description provided for @profileEditNameField.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileEditNameField;

  /// No description provided for @profileEditEmailField.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEditEmailField;

  /// No description provided for @profileEditPhoneField.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profileEditPhoneField;

  /// No description provided for @profileEditCancelCta.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileEditCancelCta;

  /// No description provided for @profileEditSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get profileEditSaveCta;

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
  /// **'Adjust reminders, communication defaults, and trust-related app information without turning this area into account sprawl.'**
  String get settingsDescription;

  /// No description provided for @settingsStatus.
  ///
  /// In en, this message translates to:
  /// **'Settings now cover notification and trust preferences, with account complexity still intentionally limited.'**
  String get settingsStatus;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep booking updates useful and timely without creating noise.'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @notificationsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Manage notifications'**
  String get notificationsHeadline;

  /// No description provided for @notificationsCustomerDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose which booking and artist-response updates should reach you first as the marketplace lifecycle evolves.'**
  String get notificationsCustomerDescription;

  /// No description provided for @notificationsArtistDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep artist-side requests and business updates visible without turning the dashboard into a noisy inbox.'**
  String get notificationsArtistDescription;

  /// No description provided for @notificationsGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage notifications'**
  String get notificationsGateTitle;

  /// No description provided for @notificationsGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences are tied to an account session so the app can restore them cleanly later.'**
  String get notificationsGateMessage;

  /// No description provided for @notificationsDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery readiness'**
  String get notificationsDeliveryTitle;

  /// No description provided for @notificationsDeliveryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Notification delivery wiring is prepared and can bind to platform tokens once push configuration is enabled.'**
  String get notificationsDeliveryPlaceholder;

  /// No description provided for @notificationsDeliverySignedIn.
  ///
  /// In en, this message translates to:
  /// **'Notification delivery wiring is ready for this signed-in session. Device token registration and push transport stay behind the environment-controlled delivery boundary.'**
  String get notificationsDeliverySignedIn;

  /// No description provided for @notificationsDeliveryError.
  ///
  /// In en, this message translates to:
  /// **'Notification delivery status is unavailable right now.'**
  String get notificationsDeliveryError;

  /// No description provided for @notificationsArtistResponsesTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist responses'**
  String get notificationsArtistResponsesTitle;

  /// No description provided for @notificationsArtistResponsesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Accepted, declined, and other lifecycle responses on your booking requests.'**
  String get notificationsArtistResponsesSubtitle;

  /// No description provided for @notificationsAccountShortcut.
  ///
  /// In en, this message translates to:
  /// **'Booking updates, artist responses, reminders, and product news.'**
  String get notificationsAccountShortcut;

  /// No description provided for @notificationsArtistShortcut.
  ///
  /// In en, this message translates to:
  /// **'Incoming requests and artist-side business updates.'**
  String get notificationsArtistShortcut;

  /// No description provided for @settingsBookingUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking updates'**
  String get settingsBookingUpdatesTitle;

  /// No description provided for @settingsBookingUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Artist approval, status changes, and key booking updates.'**
  String get settingsBookingUpdatesSubtitle;

  /// No description provided for @settingsRemindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment reminders'**
  String get settingsRemindersTitle;

  /// No description provided for @settingsRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start-time reminders and preparation nudges before your appointment.'**
  String get settingsRemindersSubtitle;

  /// No description provided for @settingsPromotionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product updates'**
  String get settingsPromotionsTitle;

  /// No description provided for @settingsPromotionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Occasional product news, seasonal availability, and service highlights.'**
  String get settingsPromotionsSubtitle;

  /// No description provided for @settingsAppPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'App preferences'**
  String get settingsAppPreferencesTitle;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English is active in this baseline. Locale switching can be added later.'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsAreaContextTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved address and area context'**
  String get settingsAreaContextTitle;

  /// No description provided for @settingsHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help, privacy, and trust'**
  String get settingsHelpTitle;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Address and event details are only captured to support booking coordination and travel clarity.'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingsTermsTitle;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review the current editable marketplace terms draft before public release.'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsBookingPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking policy'**
  String get settingsBookingPolicyTitle;

  /// No description provided for @settingsBookingPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Request-state booking guidance, travel clarity, and support expectations.'**
  String get settingsBookingPolicySubtitle;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Glam2GO'**
  String get settingsAboutTitle;

  /// No description provided for @settingsAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A premium beauty-service marketplace baseline for customer discovery and booking.'**
  String get settingsAboutSubtitle;

  /// No description provided for @savedAddressesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get savedAddressesTitle;

  /// No description provided for @savedAddressesHeadline.
  ///
  /// In en, this message translates to:
  /// **'Manage service-ready locations.'**
  String get savedAddressesHeadline;

  /// No description provided for @savedAddressesDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep a small list of trusted service addresses so future booking reuse stays fast and clear.'**
  String get savedAddressesDescription;

  /// No description provided for @savedAddressesDefaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get savedAddressesDefaultLabel;

  /// No description provided for @savedAddressesFutureTitle.
  ///
  /// In en, this message translates to:
  /// **'Address management stays intentionally lean'**
  String get savedAddressesFutureTitle;

  /// No description provided for @savedAddressesFutureMessage.
  ///
  /// In en, this message translates to:
  /// **'Add and edit flows can connect later. This pass focuses on clear reuse, default selection, and booking-readiness.'**
  String get savedAddressesFutureMessage;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help and policies'**
  String get supportTitle;

  /// No description provided for @supportHeadline.
  ///
  /// In en, this message translates to:
  /// **'Help, policies, and next steps in one place.'**
  String get supportHeadline;

  /// No description provided for @supportDescription.
  ///
  /// In en, this message translates to:
  /// **'Find booking guidance, policy details, and the right support path without leaving the app guessing.'**
  String get supportDescription;

  /// No description provided for @supportEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Get help'**
  String get supportEntryTitle;

  /// No description provided for @supportEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use these links for booking guidance, support direction, and policy details during beta and launch prep.'**
  String get supportEntrySubtitle;

  /// No description provided for @supportEntryChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get supportEntryChatTitle;

  /// No description provided for @supportEntryChatMessage.
  ///
  /// In en, this message translates to:
  /// **'Replace this placeholder with your final support channel before launch so customers know exactly where to ask for help.'**
  String get supportEntryChatMessage;

  /// No description provided for @supportEntryPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you book'**
  String get supportEntryPolicyTitle;

  /// No description provided for @supportEntryPolicyMessage.
  ///
  /// In en, this message translates to:
  /// **'Review booking and cancellation guidance here so expectations stay clear before an appointment is accepted.'**
  String get supportEntryPolicyMessage;

  /// No description provided for @supportPoliciesTitle.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get supportPoliciesTitle;

  /// No description provided for @supportPoliciesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep the most important platform policies easy to find from customer and artist settings.'**
  String get supportPoliciesSubtitle;

  /// No description provided for @supportPrivacySummary.
  ///
  /// In en, this message translates to:
  /// **'Review the current editable privacy draft and how Glam2GO handles account, address, and booking coordination data.'**
  String get supportPrivacySummary;

  /// No description provided for @supportTermsSummary.
  ///
  /// In en, this message translates to:
  /// **'Review the current editable platform terms draft for marketplace access, account usage, and release-stage limitations.'**
  String get supportTermsSummary;

  /// No description provided for @supportCancellationSummary.
  ///
  /// In en, this message translates to:
  /// **'Review how booking requests, artist responses, and cancellation handling are currently explained in V1.'**
  String get supportCancellationSummary;

  /// No description provided for @supportBookingSummary.
  ///
  /// In en, this message translates to:
  /// **'Review request-state booking expectations, travel clarity, and when to use support instead of self-serve actions.'**
  String get supportBookingSummary;

  /// No description provided for @supportFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Common questions'**
  String get supportFaqTitle;

  /// No description provided for @supportFaqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answer the questions testers and early users ask most often without adding a heavy support flow.'**
  String get supportFaqSubtitle;

  /// No description provided for @supportFaqBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking requests and confirmations'**
  String get supportFaqBookingTitle;

  /// No description provided for @supportFaqBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Glam2GO currently treats booking submission as a request. Customers should rely on accepted status, not request submission alone, before treating the appointment as confirmed.'**
  String get supportFaqBookingMessage;

  /// No description provided for @supportFaqArtistTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist-side setup and updates'**
  String get supportFaqArtistTitle;

  /// No description provided for @supportFaqArtistMessage.
  ///
  /// In en, this message translates to:
  /// **'Artists can manage profile, packages, availability, travel policy, and portfolio metadata. Media upload and moderation remain intentionally limited until those contracts are connected.'**
  String get supportFaqArtistMessage;

  /// No description provided for @supportFaqAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account and session guidance'**
  String get supportFaqAccountTitle;

  /// No description provided for @supportFaqAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Use the same shared app for guest browsing, customer account flows, and artist workspace entry. If a session expires, sign in again and Glam2GO will try to return you to the correct route.'**
  String get supportFaqAccountMessage;

  /// No description provided for @policyDraftNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Draft legal content'**
  String get policyDraftNoticeTitle;

  /// No description provided for @policyDraftNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'This screen is structurally ready for launch review, but the text should be replaced with approved legal or operations copy before public release.'**
  String get policyDraftNoticeMessage;

  /// No description provided for @policyPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get policyPrivacyTitle;

  /// No description provided for @policyPrivacyHeadline.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data handling, explained clearly.'**
  String get policyPrivacyHeadline;

  /// No description provided for @policyPrivacyDescription.
  ///
  /// In en, this message translates to:
  /// **'This V1 draft explains the main types of customer, artist, and booking data the app currently uses.'**
  String get policyPrivacyDescription;

  /// No description provided for @policyPrivacyCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'What Glam2GO collects'**
  String get policyPrivacyCollectionTitle;

  /// No description provided for @policyPrivacyCollectionBody.
  ///
  /// In en, this message translates to:
  /// **'Glam2GO currently stores account basics, booking request details, saved addresses, travel-related booking context, and artist business setup information needed to run discovery and booking coordination.'**
  String get policyPrivacyCollectionBody;

  /// No description provided for @policyPrivacyUseTitle.
  ///
  /// In en, this message translates to:
  /// **'How that data is used'**
  String get policyPrivacyUseTitle;

  /// No description provided for @policyPrivacyUseBody.
  ///
  /// In en, this message translates to:
  /// **'This data is used to restore sessions, power discovery, support booking requests, show artist availability and travel expectations, and keep customer and artist status updates coherent across the marketplace lifecycle.'**
  String get policyPrivacyUseBody;

  /// No description provided for @policyPrivacyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy updates and support'**
  String get policyPrivacyContactTitle;

  /// No description provided for @policyPrivacyContactBody.
  ///
  /// In en, this message translates to:
  /// **'Until a final support and legal workflow is connected, privacy-related questions should route through the main help surface so the team can respond with the latest approved guidance.'**
  String get policyPrivacyContactBody;

  /// No description provided for @policyTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get policyTermsTitle;

  /// No description provided for @policyTermsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Marketplace terms, kept honest for V1.'**
  String get policyTermsHeadline;

  /// No description provided for @policyTermsDescription.
  ///
  /// In en, this message translates to:
  /// **'This V1 draft explains how Glam2GO currently frames account use, booking requests, and release-stage limitations.'**
  String get policyTermsDescription;

  /// No description provided for @policyTermsMarketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Marketplace expectations'**
  String get policyTermsMarketplaceTitle;

  /// No description provided for @policyTermsMarketplaceBody.
  ///
  /// In en, this message translates to:
  /// **'Glam2GO is a beauty-service marketplace that connects customers and artists. Booking submission does not guarantee a confirmed appointment unless the lifecycle later reflects artist acceptance.'**
  String get policyTermsMarketplaceBody;

  /// No description provided for @policyTermsAccountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Account usage and access'**
  String get policyTermsAccountsTitle;

  /// No description provided for @policyTermsAccountsBody.
  ///
  /// In en, this message translates to:
  /// **'Guests can browse discovery and booking setup, while saved actions and artist tools require an authenticated account. Role-aware routing and protected actions are part of the current product experience.'**
  String get policyTermsAccountsBody;

  /// No description provided for @policyTermsEditsTitle.
  ///
  /// In en, this message translates to:
  /// **'Release-stage limitations'**
  String get policyTermsEditsTitle;

  /// No description provided for @policyTermsEditsBody.
  ///
  /// In en, this message translates to:
  /// **'This app is still operating with some hybrid local and remote behavior. Product and policy details may be refined as backend contracts, support operations, and legal review become final.'**
  String get policyTermsEditsBody;

  /// No description provided for @policyCancellationTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancellation policy'**
  String get policyCancellationTitle;

  /// No description provided for @policyCancellationHeadline.
  ///
  /// In en, this message translates to:
  /// **'Cancellation expectations for the current release stage.'**
  String get policyCancellationHeadline;

  /// No description provided for @policyCancellationDescription.
  ///
  /// In en, this message translates to:
  /// **'This V1 draft explains how cancellation is currently represented in the app and where manual support is still required.'**
  String get policyCancellationDescription;

  /// No description provided for @policyCancellationRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending requests'**
  String get policyCancellationRequestsTitle;

  /// No description provided for @policyCancellationRequestsBody.
  ///
  /// In en, this message translates to:
  /// **'Pending booking requests can be cancelled by the customer in-app. That keeps the request in history but removes it from active review or active appointment treatment.'**
  String get policyCancellationRequestsBody;

  /// No description provided for @policyCancellationAcceptedTitle.
  ///
  /// In en, this message translates to:
  /// **'Accepted bookings'**
  String get policyCancellationAcceptedTitle;

  /// No description provided for @policyCancellationAcceptedBody.
  ///
  /// In en, this message translates to:
  /// **'Accepted bookings can currently be marked as cancelled in-app, but policy enforcement, refunds, and reschedule handling are not yet represented as a full production workflow.'**
  String get policyCancellationAcceptedBody;

  /// No description provided for @policyCancellationSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'When support is needed'**
  String get policyCancellationSupportTitle;

  /// No description provided for @policyCancellationSupportBody.
  ///
  /// In en, this message translates to:
  /// **'Use support for anything that requires exception handling, manual coordination, or clarification beyond the current self-serve cancellation surface.'**
  String get policyCancellationSupportBody;

  /// No description provided for @policyBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking policy'**
  String get policyBookingTitle;

  /// No description provided for @policyBookingHeadline.
  ///
  /// In en, this message translates to:
  /// **'Booking expectations and lifecycle clarity.'**
  String get policyBookingHeadline;

  /// No description provided for @policyBookingDescription.
  ///
  /// In en, this message translates to:
  /// **'This V1 draft keeps request-state wording, travel expectations, and what-happens-next guidance explicit for customers and artists.'**
  String get policyBookingDescription;

  /// No description provided for @policyBookingRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Request submission'**
  String get policyBookingRequestsTitle;

  /// No description provided for @policyBookingRequestsBody.
  ///
  /// In en, this message translates to:
  /// **'Submitting a booking sends a request to the artist. Customers should wait for accepted status before treating the booking as confirmed, and artists should review request details before accepting.'**
  String get policyBookingRequestsBody;

  /// No description provided for @policyBookingTravelTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel and location clarity'**
  String get policyBookingTravelTitle;

  /// No description provided for @policyBookingTravelBody.
  ///
  /// In en, this message translates to:
  /// **'Travel fees and service-area summaries are shown as part of booking context. Final operational handling may still depend on backend validation and connected policy logic.'**
  String get policyBookingTravelBody;

  /// No description provided for @policyBookingSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support and trust'**
  String get policyBookingSupportTitle;

  /// No description provided for @policyBookingSupportBody.
  ///
  /// In en, this message translates to:
  /// **'Use support surfaces when booking status, travel expectations, or release-stage limitations are unclear. Keep trust language aligned with the shared lifecycle rather than treating requests as guaranteed appointments.'**
  String get policyBookingSupportBody;

  /// No description provided for @customerModeRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This part of Glam2GO is currently tied to the customer experience. Switch to customer mode to continue.'**
  String get customerModeRequiredMessage;

  /// No description provided for @guestBookingsGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your bookings'**
  String get guestBookingsGateTitle;

  /// No description provided for @guestBookingsGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Guests can explore artists and packages, but bookings history and request tracking need a customer account.'**
  String get guestBookingsGateMessage;

  /// No description provided for @guestFavoritesGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Save artists with an account'**
  String get guestFavoritesGateTitle;

  /// No description provided for @guestFavoritesGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Guests can browse freely, but saving artists for later needs a customer account.'**
  String get guestFavoritesGateMessage;

  /// No description provided for @guestFavoritesActionMessage.
  ///
  /// In en, this message translates to:
  /// **'Save this artist after signing in or creating an account. Your current profile view will stay easy to return to.'**
  String get guestFavoritesActionMessage;

  /// No description provided for @guestProfileGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your account'**
  String get guestProfileGateTitle;

  /// No description provided for @guestProfileGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile, saved preferences, and booking-ready account details need a customer account.'**
  String get guestProfileGateMessage;

  /// No description provided for @guestSettingsGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to change account settings'**
  String get guestSettingsGateTitle;

  /// No description provided for @guestSettingsGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences, saved-area context, and account controls are only available after sign-in.'**
  String get guestSettingsGateMessage;

  /// No description provided for @guestAddressesGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage saved addresses'**
  String get guestAddressesGateTitle;

  /// No description provided for @guestAddressesGateMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved service addresses are tied to customer account reuse in future bookings.'**
  String get guestAddressesGateMessage;

  /// No description provided for @bookingStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get bookingStatusPending;

  /// No description provided for @bookingStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingStatusConfirmed;

  /// No description provided for @bookingStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get bookingStatusAccepted;

  /// No description provided for @bookingStatusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get bookingStatusDeclined;

  /// No description provided for @bookingStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get bookingStatusCancelled;

  /// No description provided for @bookingStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bookingStatusCompleted;

  /// No description provided for @bookingLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading booking updates...'**
  String get bookingLoadingMessage;

  /// No description provided for @bookingLoadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking updates need another try'**
  String get bookingLoadErrorTitle;

  /// No description provided for @bookingLoadErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh the latest booking lifecycle details. Try again in a moment.'**
  String get bookingLoadErrorMessage;

  /// No description provided for @bookingSubmissionFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t submit your booking request right now. Try again in a moment.'**
  String get bookingSubmissionFailedMessage;

  /// No description provided for @artistFavoriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save artist'**
  String get artistFavoriteTooltip;

  /// No description provided for @artistOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist onboarding'**
  String get artistOnboardingTitle;

  /// No description provided for @artistOnboardingHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set up your artist profile.'**
  String get artistOnboardingHeadline;

  /// No description provided for @artistOnboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Create the minimum professional setup needed to become discoverable and booking-ready later.'**
  String get artistOnboardingDescription;

  /// No description provided for @artistOnboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Become a Glam2GO artist'**
  String get artistOnboardingWelcomeTitle;

  /// No description provided for @artistOnboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This flow keeps setup guided and lean: profile, specialties, travel, packages, and availability.'**
  String get artistOnboardingWelcomeSubtitle;

  /// No description provided for @artistOnboardingProfileStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile basics'**
  String get artistOnboardingProfileStepTitle;

  /// No description provided for @artistOnboardingSpecialtiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get artistOnboardingSpecialtiesTitle;

  /// No description provided for @artistOnboardingTravelTitle.
  ///
  /// In en, this message translates to:
  /// **'Service area and travel'**
  String get artistOnboardingTravelTitle;

  /// No description provided for @artistOnboardingPackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get artistOnboardingPackagesTitle;

  /// No description provided for @artistOnboardingPackagesSummary.
  ///
  /// In en, this message translates to:
  /// **'Keep packages clean, event-specific, and transparent before publish-ready availability is connected.'**
  String get artistOnboardingPackagesSummary;

  /// No description provided for @artistOnboardingAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get artistOnboardingAvailabilityTitle;

  /// No description provided for @artistOnboardingAvailabilitySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly availability is rule-based for now and can later connect to a richer calendar system.'**
  String get artistOnboardingAvailabilitySummary;

  /// No description provided for @artistOnboardingSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Readiness summary'**
  String get artistOnboardingSummaryTitle;

  /// No description provided for @artistOnboardingSummaryReady.
  ///
  /// In en, this message translates to:
  /// **'Your current mock setup is structurally ready for public discovery later.'**
  String get artistOnboardingSummaryReady;

  /// No description provided for @artistOnboardingSummaryMissing.
  ///
  /// In en, this message translates to:
  /// **'Still incomplete: {items}'**
  String artistOnboardingSummaryMissing(Object items);

  /// No description provided for @artistOnboardingContinueCta.
  ///
  /// In en, this message translates to:
  /// **'Open artist dashboard'**
  String get artistOnboardingContinueCta;

  /// No description provided for @artistOnboardingEditProfileCta.
  ///
  /// In en, this message translates to:
  /// **'Edit public profile'**
  String get artistOnboardingEditProfileCta;

  /// No description provided for @artistOnboardingCurrentStep.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String artistOnboardingCurrentStep(int current, int total);

  /// No description provided for @artistDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist dashboard'**
  String get artistDashboardTitle;

  /// No description provided for @artistDashboardHeadline.
  ///
  /// In en, this message translates to:
  /// **'Run your Glam2GO setup from one place.'**
  String get artistDashboardHeadline;

  /// No description provided for @artistDashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'Review readiness, upcoming bookings, package coverage, availability, and travel setup without switching to a second app.'**
  String get artistDashboardDescription;

  /// No description provided for @artistDashboardCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile readiness'**
  String get artistDashboardCompletionTitle;

  /// No description provided for @artistDashboardPackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get artistDashboardPackagesTitle;

  /// No description provided for @artistDashboardPackagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Active service setup'**
  String get artistDashboardPackagesSubtitle;

  /// No description provided for @artistDashboardAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get artistDashboardAvailabilityTitle;

  /// No description provided for @artistDashboardAvailabilitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly availability days'**
  String get artistDashboardAvailabilitySubtitle;

  /// No description provided for @artistDashboardServiceAreaTitle.
  ///
  /// In en, this message translates to:
  /// **'Service area'**
  String get artistDashboardServiceAreaTitle;

  /// No description provided for @artistDashboardBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get artistDashboardBookingsTitle;

  /// No description provided for @artistDashboardBookingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current booking visibility'**
  String get artistDashboardBookingsSubtitle;

  /// No description provided for @artistDashboardPendingBookingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No accepted appointments yet} one{1 accepted appointment} other{{count} accepted appointments}}'**
  String artistDashboardPendingBookingsSubtitle(int count);

  /// No description provided for @artistDashboardQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get artistDashboardQuickActionsTitle;

  /// No description provided for @artistDashboardQuickActionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Move directly into the setup surfaces that affect discoverability and booking readiness.'**
  String get artistDashboardQuickActionsSubtitle;

  /// No description provided for @artistDashboardEditProfileCta.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get artistDashboardEditProfileCta;

  /// No description provided for @artistDashboardManagePackagesCta.
  ///
  /// In en, this message translates to:
  /// **'Manage packages'**
  String get artistDashboardManagePackagesCta;

  /// No description provided for @artistDashboardManageAvailabilityCta.
  ///
  /// In en, this message translates to:
  /// **'Manage availability'**
  String get artistDashboardManageAvailabilityCta;

  /// No description provided for @artistDashboardViewBookingsCta.
  ///
  /// In en, this message translates to:
  /// **'View bookings'**
  String get artistDashboardViewBookingsCta;

  /// No description provided for @artistDashboardNextBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Next bookings overview'**
  String get artistDashboardNextBookingsTitle;

  /// No description provided for @artistProfileManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist profile'**
  String get artistProfileManagementTitle;

  /// No description provided for @artistProfileManagementHeadline.
  ///
  /// In en, this message translates to:
  /// **'Manage your public profile.'**
  String get artistProfileManagementHeadline;

  /// No description provided for @artistProfileManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Everything here should map cleanly to what customers eventually see in discovery and profile view.'**
  String get artistProfileManagementDescription;

  /// No description provided for @artistProfileDisplayNameField.
  ///
  /// In en, this message translates to:
  /// **'Business or display name'**
  String get artistProfileDisplayNameField;

  /// No description provided for @artistProfileBioField.
  ///
  /// In en, this message translates to:
  /// **'Short bio'**
  String get artistProfileBioField;

  /// No description provided for @artistProfileExperienceField.
  ///
  /// In en, this message translates to:
  /// **'Experience summary'**
  String get artistProfileExperienceField;

  /// No description provided for @artistProfileInstagramField.
  ///
  /// In en, this message translates to:
  /// **'Instagram handle'**
  String get artistProfileInstagramField;

  /// No description provided for @artistProfileTikTokField.
  ///
  /// In en, this message translates to:
  /// **'TikTok handle'**
  String get artistProfileTikTokField;

  /// No description provided for @artistProfileSpecialtiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Specialties and style tags'**
  String get artistProfileSpecialtiesTitle;

  /// No description provided for @artistProfileSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save profile details'**
  String get artistProfileSaveCta;

  /// No description provided for @artistProfileValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a display name, a short bio, and at least one specialty before saving.'**
  String get artistProfileValidationMessage;

  /// No description provided for @artistProfileSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Artist profile updated.'**
  String get artistProfileSavedMessage;

  /// No description provided for @artistPortfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio management'**
  String get artistPortfolioTitle;

  /// No description provided for @artistPortfolioAddCta.
  ///
  /// In en, this message translates to:
  /// **'Add portfolio item'**
  String get artistPortfolioAddCta;

  /// No description provided for @artistPortfolioSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save portfolio item'**
  String get artistPortfolioSaveCta;

  /// No description provided for @artistPortfolioEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No portfolio items yet'**
  String get artistPortfolioEmptyTitle;

  /// No description provided for @artistPortfolioEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a few polished examples so discovery can communicate trust and style direction clearly.'**
  String get artistPortfolioEmptyMessage;

  /// No description provided for @artistPortfolioAddSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add portfolio item'**
  String get artistPortfolioAddSheetTitle;

  /// No description provided for @artistPortfolioEditSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit portfolio item'**
  String get artistPortfolioEditSheetTitle;

  /// No description provided for @artistPortfolioEditorMessage.
  ///
  /// In en, this message translates to:
  /// **'Portfolio metadata is ready now. Media upload is kept behind a clean integration boundary until storage contracts are enabled.'**
  String get artistPortfolioEditorMessage;

  /// No description provided for @artistPortfolioTitleField.
  ///
  /// In en, this message translates to:
  /// **'Look title'**
  String get artistPortfolioTitleField;

  /// No description provided for @artistPortfolioCategoryField.
  ///
  /// In en, this message translates to:
  /// **'Category or style'**
  String get artistPortfolioCategoryField;

  /// No description provided for @artistPortfolioCaptionField.
  ///
  /// In en, this message translates to:
  /// **'Caption'**
  String get artistPortfolioCaptionField;

  /// No description provided for @artistPortfolioValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a title, category, and caption before saving.'**
  String get artistPortfolioValidationMessage;

  /// No description provided for @artistPortfolioUploadPlaceholderNote.
  ///
  /// In en, this message translates to:
  /// **'Media upload and ordering stay intentionally lightweight in this phase. Save polished metadata now so the portfolio structure remains ready for external beta.'**
  String get artistPortfolioUploadPlaceholderNote;

  /// No description provided for @artistPortfolioMediaPending.
  ///
  /// In en, this message translates to:
  /// **'Media pending'**
  String get artistPortfolioMediaPending;

  /// No description provided for @artistPortfolioMediaReady.
  ///
  /// In en, this message translates to:
  /// **'Media ready'**
  String get artistPortfolioMediaReady;

  /// No description provided for @artistPortfolioMediaStatusNote.
  ///
  /// In en, this message translates to:
  /// **'Media selection and upload stay behind the repository boundary so beta wiring can evolve without changing this UI.'**
  String get artistPortfolioMediaStatusNote;

  /// No description provided for @artistPortfolioRemoveCta.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get artistPortfolioRemoveCta;

  /// No description provided for @artistPortfolioRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove portfolio item?'**
  String get artistPortfolioRemoveTitle;

  /// No description provided for @artistPortfolioRemoveMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes the item from your public portfolio structure, but the media upload pipeline is still intentionally limited in this phase.'**
  String get artistPortfolioRemoveMessage;

  /// No description provided for @artistPackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get artistPackagesTitle;

  /// No description provided for @artistPackagesHeadline.
  ///
  /// In en, this message translates to:
  /// **'Manage packages and services.'**
  String get artistPackagesHeadline;

  /// No description provided for @artistPackagesDescription.
  ///
  /// In en, this message translates to:
  /// **'Define clean package titles, inclusions, pricing, and event fit so customers can compare them quickly.'**
  String get artistPackagesDescription;

  /// No description provided for @artistPackagesAddCta.
  ///
  /// In en, this message translates to:
  /// **'Add package'**
  String get artistPackagesAddCta;

  /// No description provided for @artistPackagesEditCta.
  ///
  /// In en, this message translates to:
  /// **'Edit package'**
  String get artistPackagesEditCta;

  /// No description provided for @artistPackagesSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save package'**
  String get artistPackagesSaveCta;

  /// No description provided for @artistPackagesSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Package details updated.'**
  String get artistPackagesSavedMessage;

  /// No description provided for @artistPackagesActivateCta.
  ///
  /// In en, this message translates to:
  /// **'Mark active'**
  String get artistPackagesActivateCta;

  /// No description provided for @artistPackagesDeactivateCta.
  ///
  /// In en, this message translates to:
  /// **'Mark inactive'**
  String get artistPackagesDeactivateCta;

  /// No description provided for @artistPackagesActiveField.
  ///
  /// In en, this message translates to:
  /// **'Package is active'**
  String get artistPackagesActiveField;

  /// No description provided for @artistPackageTitleField.
  ///
  /// In en, this message translates to:
  /// **'Package title'**
  String get artistPackageTitleField;

  /// No description provided for @artistPackageDescriptionField.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get artistPackageDescriptionField;

  /// No description provided for @artistPackagePriceField.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get artistPackagePriceField;

  /// No description provided for @artistPackageDurationField.
  ///
  /// In en, this message translates to:
  /// **'Duration (minutes)'**
  String get artistPackageDurationField;

  /// No description provided for @artistPackageIncludesField.
  ///
  /// In en, this message translates to:
  /// **'Included items (comma separated)'**
  String get artistPackageIncludesField;

  /// No description provided for @artistPackageOccasionsField.
  ///
  /// In en, this message translates to:
  /// **'Suitable occasions (comma separated)'**
  String get artistPackageOccasionsField;

  /// No description provided for @artistPackageValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a title, description, price, duration, inclusions, and suitable occasions before saving.'**
  String get artistPackageValidationMessage;

  /// No description provided for @artistAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get artistAvailabilityTitle;

  /// No description provided for @artistAvailabilityHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set weekly availability.'**
  String get artistAvailabilityHeadline;

  /// No description provided for @artistAvailabilityDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep availability rule-based and predictable for now. Weekly windows can later connect to a fuller calendar engine.'**
  String get artistAvailabilityDescription;

  /// No description provided for @artistAvailabilityAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get artistAvailabilityAvailableLabel;

  /// No description provided for @artistAvailabilityUnavailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get artistAvailabilityUnavailableLabel;

  /// No description provided for @artistAvailabilityAddWindowCta.
  ///
  /// In en, this message translates to:
  /// **'Add time window'**
  String get artistAvailabilityAddWindowCta;

  /// No description provided for @artistAvailabilityEditWindowCta.
  ///
  /// In en, this message translates to:
  /// **'Edit time window'**
  String get artistAvailabilityEditWindowCta;

  /// No description provided for @artistAvailabilityStartField.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get artistAvailabilityStartField;

  /// No description provided for @artistAvailabilityEndField.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get artistAvailabilityEndField;

  /// No description provided for @artistAvailabilitySaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save window'**
  String get artistAvailabilitySaveCta;

  /// No description provided for @artistAvailabilitySavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Availability updated.'**
  String get artistAvailabilitySavedMessage;

  /// No description provided for @artistAvailabilityValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Add both a start time and an end time.'**
  String get artistAvailabilityValidationMessage;

  /// No description provided for @artistTravelTitle.
  ///
  /// In en, this message translates to:
  /// **'Service area'**
  String get artistTravelTitle;

  /// No description provided for @artistTravelHeadline.
  ///
  /// In en, this message translates to:
  /// **'Define travel policy clearly.'**
  String get artistTravelHeadline;

  /// No description provided for @artistTravelDescription.
  ///
  /// In en, this message translates to:
  /// **'Travel setup should feel transparent and operational, not punitive. This data should later connect directly to customer-side booking logic.'**
  String get artistTravelDescription;

  /// No description provided for @artistTravelAreaField.
  ///
  /// In en, this message translates to:
  /// **'Primary service area'**
  String get artistTravelAreaField;

  /// No description provided for @artistTravelRadiusField.
  ///
  /// In en, this message translates to:
  /// **'Included radius (km)'**
  String get artistTravelRadiusField;

  /// No description provided for @artistTravelFeeField.
  ///
  /// In en, this message translates to:
  /// **'Extra travel fee from'**
  String get artistTravelFeeField;

  /// No description provided for @artistTravelMaxDistanceField.
  ///
  /// In en, this message translates to:
  /// **'Max travel distance (km)'**
  String get artistTravelMaxDistanceField;

  /// No description provided for @artistTravelNotesField.
  ///
  /// In en, this message translates to:
  /// **'Travel notes'**
  String get artistTravelNotesField;

  /// No description provided for @artistTravelSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save travel policy'**
  String get artistTravelSaveCta;

  /// No description provided for @artistTravelValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Add a primary service area, included radius, and max travel distance before saving.'**
  String get artistTravelValidationMessage;

  /// No description provided for @artistTravelSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Travel policy updated.'**
  String get artistTravelSavedMessage;

  /// No description provided for @artistTravelFeePreview.
  ///
  /// In en, this message translates to:
  /// **'Travel fee +\${fee}'**
  String artistTravelFeePreview(int fee);

  /// No description provided for @artistTravelRadiusValue.
  ///
  /// In en, this message translates to:
  /// **'{km} km included'**
  String artistTravelRadiusValue(int km);

  /// No description provided for @artistTravelSummaryValue.
  ///
  /// In en, this message translates to:
  /// **'{area} • {km} km included'**
  String artistTravelSummaryValue(Object area, int km);

  /// No description provided for @artistBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist bookings'**
  String get artistBookingsTitle;

  /// No description provided for @artistBookingsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review requests and appointments.'**
  String get artistBookingsHeadline;

  /// No description provided for @artistBookingsDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the operational booking overview foundation for artists. Accept/decline and deeper workflows can connect later.'**
  String get artistBookingsDescription;

  /// No description provided for @artistBookingsRequestsTab.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get artistBookingsRequestsTab;

  /// No description provided for @artistBookingsUpcomingTab.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get artistBookingsUpcomingTab;

  /// No description provided for @artistBookingsPastTab.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get artistBookingsPastTab;

  /// No description provided for @artistBookingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No artist bookings yet'**
  String get artistBookingsEmptyTitle;

  /// No description provided for @artistBookingsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking requests and appointments will appear here once marketplace flows are connected.'**
  String get artistBookingsEmptyMessage;

  /// No description provided for @artistBookingAcceptCta.
  ///
  /// In en, this message translates to:
  /// **'Accept request'**
  String get artistBookingAcceptCta;

  /// No description provided for @artistBookingDeclineCta.
  ///
  /// In en, this message translates to:
  /// **'Decline request'**
  String get artistBookingDeclineCta;

  /// No description provided for @artistSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Artist settings'**
  String get artistSettingsTitle;

  /// No description provided for @artistSettingsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Business preferences and shortcuts.'**
  String get artistSettingsHeadline;

  /// No description provided for @artistSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep artist-side settings practical: notifications, business setup shortcuts, and help/policy access.'**
  String get artistSettingsDescription;

  /// No description provided for @artistSettingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get artistSettingsNotificationsTitle;

  /// No description provided for @artistSettingsRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking request alerts'**
  String get artistSettingsRequestsTitle;

  /// No description provided for @artistSettingsRequestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified when a new request needs review or schedule confirmation.'**
  String get artistSettingsRequestsSubtitle;

  /// No description provided for @artistSettingsBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'Business settings'**
  String get artistSettingsBusinessTitle;

  /// No description provided for @artistMutationSavingLabel.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get artistMutationSavingLabel;

  /// No description provided for @artistMutationFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t save that update right now. Try again.'**
  String get artistMutationFailedMessage;

  /// No description provided for @artistSettingsBusinessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay aware of package, availability, and service-area updates.'**
  String get artistSettingsBusinessSubtitle;

  /// No description provided for @artistSettingsProfileShortcut.
  ///
  /// In en, this message translates to:
  /// **'Update the public-facing profile customers will discover later.'**
  String get artistSettingsProfileShortcut;

  /// No description provided for @artistSettingsTravelShortcut.
  ///
  /// In en, this message translates to:
  /// **'Review radius, extra-fee setup, and service-area notes.'**
  String get artistSettingsTravelShortcut;

  /// No description provided for @artistSettingsSupportShortcut.
  ///
  /// In en, this message translates to:
  /// **'Support, policies, and platform guidance.'**
  String get artistSettingsSupportShortcut;

  /// No description provided for @artistSettingsPolicyShortcut.
  ///
  /// In en, this message translates to:
  /// **'Shared booking-policy guidance for artist-side operational use.'**
  String get artistSettingsPolicyShortcut;

  /// No description provided for @artistSettingsSwitchToCustomerMessage.
  ///
  /// In en, this message translates to:
  /// **'Return to customer browsing, bookings, and saved-account surfaces.'**
  String get artistSettingsSwitchToCustomerMessage;

  /// No description provided for @artistBookingStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending request'**
  String get artistBookingStatusPending;

  /// No description provided for @artistBookingStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get artistBookingStatusConfirmed;

  /// No description provided for @artistBookingStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get artistBookingStatusCompleted;

  /// No description provided for @artistReadinessProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} readiness steps complete'**
  String artistReadinessProgress(int completed, int total);

  /// No description provided for @artistReadinessProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'profile'**
  String get artistReadinessProfileLabel;

  /// No description provided for @artistReadinessSpecialtiesLabel.
  ///
  /// In en, this message translates to:
  /// **'specialties'**
  String get artistReadinessSpecialtiesLabel;

  /// No description provided for @artistReadinessTravelLabel.
  ///
  /// In en, this message translates to:
  /// **'travel'**
  String get artistReadinessTravelLabel;

  /// No description provided for @artistReadinessPackagesLabel.
  ///
  /// In en, this message translates to:
  /// **'packages'**
  String get artistReadinessPackagesLabel;

  /// No description provided for @artistReadinessAvailabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'availability'**
  String get artistReadinessAvailabilityLabel;

  /// No description provided for @artistPackageCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No packages yet} one{1 package} other{{count} packages}}'**
  String artistPackageCount(int count);

  /// No description provided for @artistAvailabilityDayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No active days yet} one{1 active day} other{{count} active days}}'**
  String artistAvailabilityDayCount(int count);

  /// No description provided for @scaffoldIncompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This screen is a baseline scaffold only. Business logic and production content will be added in later feature passes.'**
  String get scaffoldIncompleteMessage;

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No artists} one{1 artist} other{{count} artists}}'**
  String searchResultsCount(int count);

  /// No description provided for @artistProfileTravelRadius.
  ///
  /// In en, this message translates to:
  /// **'{km} km service radius included'**
  String artistProfileTravelRadius(int km);

  /// No description provided for @artistProfileTravelFee.
  ///
  /// In en, this message translates to:
  /// **'Travel beyond the included radius starts from {fee}.'**
  String artistProfileTravelFee(Object fee);

  /// No description provided for @artistProfileTravelDistance.
  ///
  /// In en, this message translates to:
  /// **'Willing to travel up to {km} km for the right booking.'**
  String artistProfileTravelDistance(int km);

  /// No description provided for @packageDetailsForArtist.
  ///
  /// In en, this message translates to:
  /// **'Selected from {artistName}'**
  String packageDetailsForArtist(Object artistName);

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

  /// No description provided for @bookingPartySizeValue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 person} other{{count} people}}'**
  String bookingPartySizeValue(int count);

  /// No description provided for @bookingTravelIncludedNote.
  ///
  /// In en, this message translates to:
  /// **'This request appears to sit inside the included {radiusKm} km service radius.'**
  String bookingTravelIncludedNote(int radiusKm);

  /// No description provided for @bookingTravelExtraNote.
  ///
  /// In en, this message translates to:
  /// **'This address may add an estimated \${fee} travel fee beyond the artist\'s included radius.'**
  String bookingTravelExtraNote(int fee);

  /// No description provided for @bookingTravelPendingNote.
  ///
  /// In en, this message translates to:
  /// **'{radiusKm} km is included. Travel beyond that may start from \${fee} after location review.'**
  String bookingTravelPendingNote(int radiusKm, int fee);

  /// No description provided for @bookingSelectedPackageDescription.
  ///
  /// In en, this message translates to:
  /// **'Booking route loaded for artist {artistId} and package {packageId}.'**
  String bookingSelectedPackageDescription(Object artistId, Object packageId);
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
