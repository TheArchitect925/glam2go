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
  String get actionExploreResults => 'See all results';

  @override
  String get actionBecomeArtist => 'Become an artist';

  @override
  String get actionContinueAsGuest => 'Continue as guest';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionSubmitBookingRequest => 'Submit booking request';

  @override
  String get actionSignInToSubmitRequest => 'Sign in to submit request';

  @override
  String get actionSwitchToCustomer => 'Switch to customer mode';

  @override
  String get actionSwitchToArtist => 'Switch to artist workspace';

  @override
  String get actionKeepBooking => 'Keep booking';

  @override
  String priceStartingFrom(Object price) {
    return 'From $price';
  }

  @override
  String packageDurationMinutes(int minutes) {
    return '$minutes min';
  }

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
  String get artistNavDashboard => 'Dashboard';

  @override
  String get artistNavBookings => 'Bookings';

  @override
  String get artistNavSettings => 'Settings';

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
      'Return to your saved account context and continue the action you started.';

  @override
  String get authSignUpTitle => 'Create account';

  @override
  String get authSignUpDescription =>
      'Create a customer or artist account without losing your current browsing momentum.';

  @override
  String get authSignUpArtistHint =>
      'Artists can start setup from here and build their public business presence without leaving the shared app.';

  @override
  String get authContinueAsCustomer => 'Continue as customer';

  @override
  String get authContinueAsArtist => 'Continue as artist';

  @override
  String get authPendingActionMessage =>
      'Your browsing context is preserved. Continue with a role so you can finish the protected action without starting over.';

  @override
  String get authSignInHelper =>
      'Continue with your Glam2GO account details to restore your session and resume protected actions cleanly.';

  @override
  String get authCreateAccountHelper =>
      'Create an account without losing your route context, booking intent, or protected-action continuation.';

  @override
  String get authRequestFailed =>
      'We could not complete that account request. Please try again.';

  @override
  String get authCredentialsTitle => 'Account details';

  @override
  String get authCreateAccountDetailsTitle => 'Create your account';

  @override
  String get authNameFieldLabel => 'Full name';

  @override
  String get authNameFieldHint => 'How your account should appear in Glam2GO';

  @override
  String get authNameValidationMessage => 'Enter a name to continue.';

  @override
  String get authEmailFieldLabel => 'Email address';

  @override
  String get authEmailFieldHint => 'name@example.com';

  @override
  String get authEmailValidationMessage => 'Enter a valid email address.';

  @override
  String get authBookingResumeMessage =>
      'Your booking draft is still in progress. Sign in or create an account and the request review step will be ready to resume.';

  @override
  String get authFavoritesResumeMessage =>
      'Your saved-artist action is waiting. Continue with an account and Glam2GO will return you to the same artist profile.';

  @override
  String get authArtistResumeMessage =>
      'Artist tools are account-only. Continue with an artist account to enter setup or dashboard routes cleanly.';

  @override
  String get authAccountResumeMessage =>
      'Your account route is preserved. Continue and Glam2GO will return you to the same place without restarting.';

  @override
  String get authDevShortcutTitle => 'Development shortcut';

  @override
  String get authDevShortcutSubtitle =>
      'Use a default local account when you want to skip manual entry during product work.';

  @override
  String get authUseDefaultCustomer => 'Use default customer account';

  @override
  String get authUseDefaultArtist => 'Use default artist account';

  @override
  String get authCreateAccountInlineCta => 'Need an account? Create one';

  @override
  String get authAlreadyHaveAccountCta => 'Already have an account? Sign in';

  @override
  String get authCreateCustomerAccount => 'Create customer account';

  @override
  String get authCreateArtistAccount => 'Join as artist';

  @override
  String get authSignOutTitle => 'Sign out';

  @override
  String get authSignOutSubtitle =>
      'Return to guest mode and keep browsing without account-only actions.';

  @override
  String get authArtistSignOutSubtitle =>
      'Leave the artist workspace and return to guest browsing mode.';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeHeadline => 'Discovery starts here.';

  @override
  String get homeDescription =>
      'Browse artists for bridal, nikkah, soft glam, photoshoots, and formal events with clear pricing and travel expectations.';

  @override
  String get homeServiceAreaEyebrow => 'Serving Toronto and the GTA';

  @override
  String get homeOccasionsTitle => 'Book by occasion';

  @override
  String get homeOccasionsSubtitle =>
      'Jump straight into artists that fit the event you are planning.';

  @override
  String get homeFeaturedArtistsTitle => 'Featured artists';

  @override
  String get homeFeaturedArtistsSubtitle =>
      'A premium shortlist with strong ratings, clear travel policies, and booking momentum.';

  @override
  String get homeSeeAllLabel => 'See all';

  @override
  String get homePopularPackagesTitle => 'Popular packages';

  @override
  String get homePopularPackagesSubtitle =>
      'Compare the most-booked service types before you commit to a profile.';

  @override
  String get homePackageAction => 'View package';

  @override
  String get homeTrustTitle => 'Why discovery feels clear on Glam2GO';

  @override
  String get homeTrustPricing =>
      'Starting prices and package inclusions are visible early.';

  @override
  String get homeTrustTravel =>
      'Travel radius and extra distance fees are explained upfront.';

  @override
  String get homeTrustAvailability =>
      'Availability previews help you decide before entering the booking flow.';

  @override
  String get discoveryLoadingMessage =>
      'Loading artists and packages for discovery.';

  @override
  String get discoveryLoadErrorTitle => 'We could not load artists right now';

  @override
  String get discoveryLoadErrorMessage =>
      'Check your connection and try again. Glam2GO will retry the discovery feed when you are ready.';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchHeadline => 'Search and filter artists.';

  @override
  String get searchDescription =>
      'Search by artist name, occasion, or style and narrow the list with simple, readable filters.';

  @override
  String get searchInputHint => 'Search by artist, style, or occasion';

  @override
  String get searchResultsTitle => 'Search results';

  @override
  String get searchResultsHeadline => 'Review candidate artists.';

  @override
  String get searchResultsDescription =>
      'Compare artists quickly by trust signals, travel fit, availability, and starting price.';

  @override
  String get sortPlaceholderLabel => 'Sort';

  @override
  String get searchEmptyTitle => 'No artists match that search yet';

  @override
  String get searchEmptyMessage =>
      'Try a broader search or clear the occasion filter to see more available artists.';

  @override
  String get searchEmptyReset => 'Clear filters';

  @override
  String get artistProfileTitle => 'Artist profile';

  @override
  String get artistProfileHeadline => 'Evaluate artist fit.';

  @override
  String get artistProfileAboutTitle => 'About this artist';

  @override
  String get artistProfilePortfolioTitle => 'Portfolio preview';

  @override
  String get artistProfilePortfolioSubtitle =>
      'A quick look at finish, style direction, and event fit.';

  @override
  String get artistProfilePackagesTitle => 'Packages and services';

  @override
  String get artistProfilePackagesSubtitle =>
      'Clear inclusions, duration, and starting price before the booking flow.';

  @override
  String get artistProfilePackageAction => 'Select package';

  @override
  String get artistProfileAvailabilityTitle => 'Availability preview';

  @override
  String get artistProfileTravelTitle => 'Travel and service area';

  @override
  String get artistProfileReviewTitle => 'Client signal';

  @override
  String get artistProfileMissingTitle => 'Artist not found';

  @override
  String get artistProfileMissingMessage =>
      'This artist profile is no longer available.';

  @override
  String get packageDetailsTitle => 'Package details';

  @override
  String get packageDetailsHeadline => 'Inspect package details cleanly.';

  @override
  String get packageMissingTitle => 'Package not found';

  @override
  String get packageMissingMessage =>
      'This package is no longer available for booking.';

  @override
  String get bookingStartTitle => 'Booking';

  @override
  String get bookingStartHeadline => 'Choose your service.';

  @override
  String get bookingStartDescription =>
      'Confirm the package you want before moving into event details, schedule selection, and location pricing.';

  @override
  String get bookingStartMissingArtistTitle => 'Choose an artist first';

  @override
  String get bookingStartMissingArtistMessage =>
      'Start booking from an artist profile or package so the flow knows who you are booking with.';

  @override
  String get bookingContinueToDetails => 'Continue to event details';

  @override
  String get bookingDetailsTitle => 'Event details';

  @override
  String get bookingDetailsHeadline => 'Set the booking context.';

  @override
  String get bookingDetailsDescription =>
      'Keep this step lean: tell the artist what type of event this is and anything important about the look.';

  @override
  String get bookingOccasionField => 'Occasion';

  @override
  String get bookingPartySizeField => 'Party size';

  @override
  String get bookingNotesField => 'Booking notes';

  @override
  String get bookingNotesHint =>
      'Share look preferences, start-time constraints, or anything the artist should know.';

  @override
  String get bookingBackToService => 'Back to service';

  @override
  String get bookingMissingServiceMessage =>
      'Pick a package before continuing with the booking flow.';

  @override
  String get bookingDateTitle => 'Date';

  @override
  String get bookingDateHeadline => 'Choose the appointment date.';

  @override
  String get bookingDateDescription =>
      'These dates are a preview of likely availability. Final confirmation still depends on artist approval.';

  @override
  String get bookingDateHint => 'Flexible timing can improve approval odds.';

  @override
  String get bookingBackToDetails => 'Back to details';

  @override
  String get bookingContinueToTime => 'Continue to time';

  @override
  String get bookingTimeTitle => 'Time';

  @override
  String get bookingTimeHeadline => 'Choose a time slot.';

  @override
  String get bookingTimeDescription =>
      'Pick a time that fits the appointment window and travel setup for the artist.';

  @override
  String get bookingBackToDate => 'Back to date';

  @override
  String get bookingLocationTitle => 'Location';

  @override
  String get bookingLocationHeadline => 'Add the service address.';

  @override
  String get bookingLocationDescription =>
      'This step keeps travel expectations clear before you confirm the request.';

  @override
  String get bookingAddressLine1Field => 'Address line 1';

  @override
  String get bookingAddressLine1Hint => 'Street address';

  @override
  String get bookingUnitField => 'Unit or access details';

  @override
  String get bookingUnitHint => 'Apartment, condo entry, or suite number';

  @override
  String get bookingCityField => 'City or area';

  @override
  String get bookingCityHint =>
      'Toronto, Mississauga, Scarborough, North York...';

  @override
  String get bookingAccessNotesField => 'Access notes';

  @override
  String get bookingAccessNotesHint =>
      'Parking, concierge, elevator, or timing notes';

  @override
  String get bookingTravelPreviewTitle => 'Travel preview';

  @override
  String get bookingTravelPendingTitle =>
      'Travel estimate will update after address review';

  @override
  String get bookingTravelIncludedTitle => 'Travel included for this request';

  @override
  String get bookingTravelExtraTitle => 'Additional travel fee may apply';

  @override
  String get bookingBackToTime => 'Back to time';

  @override
  String get bookingReviewTitle => 'Review booking';

  @override
  String get bookingReviewHeadline => 'Review before you confirm.';

  @override
  String get bookingReviewDescription =>
      'This is the clean summary of what you are requesting from the artist before final submission.';

  @override
  String get bookingReviewIncompleteMessage =>
      'Complete the earlier booking steps before reviewing the request.';

  @override
  String get bookingReviewServiceTitle => 'Service selection';

  @override
  String get bookingReviewEventTitle => 'Event details';

  @override
  String get bookingReviewScheduleTitle => 'Schedule';

  @override
  String get bookingReviewLocationTitle => 'Location and travel';

  @override
  String get bookingReviewPriceTitle => 'Price summary';

  @override
  String get bookingReviewApprovalNote =>
      'Submitting this step sends a booking request to the artist. The appointment is only confirmed after the artist accepts.';

  @override
  String get bookingEditLabel => 'Edit';

  @override
  String get bookingArtistLabel => 'Artist';

  @override
  String get bookingPackageLabel => 'Package';

  @override
  String get bookingOccasionLabel => 'Occasion';

  @override
  String get bookingPartySizeLabel => 'Party size';

  @override
  String get bookingNotesLabel => 'Notes';

  @override
  String get bookingDateLabel => 'Date';

  @override
  String get bookingTimeLabel => 'Time';

  @override
  String get bookingNoNotesValue => 'No extra notes';

  @override
  String get bookingPriceSubtotalLabel => 'Service subtotal';

  @override
  String get bookingPriceTravelLabel => 'Travel estimate';

  @override
  String get bookingPriceTotalLabel => 'Estimated total';

  @override
  String get bookingConfirmationTitle => 'Confirmation';

  @override
  String get bookingConfirmationHeadline => 'Your booking request is in.';

  @override
  String get bookingConfirmationStatus =>
      'Confirmation is now wired to the draft booking flow.';

  @override
  String get bookingConfirmationMissingTitle => 'No confirmation available';

  @override
  String get bookingConfirmationMissingMessage =>
      'This confirmation screen needs a valid in-session booking request.';

  @override
  String get bookingConfirmationNextStep =>
      'The artist reviews your request next. You will see accepted or declined status updates in your bookings list.';

  @override
  String get bookingConfirmationSummaryTitle => 'Requested booking';

  @override
  String get bookingConfirmationHomeCta => 'Back to home';

  @override
  String get bookingConfirmationBookingsCta => 'View bookings';

  @override
  String get bookingsTitle => 'Bookings';

  @override
  String get bookingsHeadline => 'Track upcoming and past bookings.';

  @override
  String get bookingsDescription =>
      'Review upcoming appointments, revisit past looks, and keep status, timing, and location details in one place.';

  @override
  String get bookingsStatus =>
      'Booking history is now connected to local account data and current in-session confirmations.';

  @override
  String get bookingsUpcomingTab => 'Upcoming';

  @override
  String get bookingsPastTab => 'Past';

  @override
  String get bookingsUpcomingEmptyTitle => 'No upcoming bookings yet';

  @override
  String get bookingsUpcomingEmptyMessage =>
      'Once you request a booking, it will appear here with status, schedule, and travel details.';

  @override
  String get bookingsPastEmptyTitle => 'No past bookings yet';

  @override
  String get bookingsPastEmptyMessage =>
      'Completed appointments will stay here for quick reference and future rebooking.';

  @override
  String get bookingDetailTitle => 'Booking detail';

  @override
  String get bookingDetailHeadline => 'Review one booking.';

  @override
  String get bookingDetailStatus =>
      'Booking detail is now connected to local customer booking data.';

  @override
  String get bookingDetailSummaryTitle => 'Booking summary';

  @override
  String get bookingDetailNotesTitle => 'Booking notes';

  @override
  String get bookingDetailNextTitle => 'What happens next';

  @override
  String get bookingDetailPolicyTitle => 'Policy and support';

  @override
  String get bookingDetailSupportCta => 'Help and policies';

  @override
  String get bookingDetailCancelCta => 'Cancel request';

  @override
  String get bookingDetailCancelTitle => 'Cancel this booking request?';

  @override
  String get bookingDetailCancelMessage =>
      'This keeps the request in your history, but it will no longer be treated as an active appointment or pending artist review.';

  @override
  String get bookingDetailMissingTitle => 'Booking not found';

  @override
  String get bookingDetailMissingMessage =>
      'This booking detail is no longer available in the current local account state.';

  @override
  String get bookingTimelineTitle => 'Request timeline';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get favoritesHeadline => 'Saved artists, ready to revisit.';

  @override
  String get favoritesDescription =>
      'Keep a short list of artists you trust so you can return to profiles and booking entry points quickly.';

  @override
  String get favoritesStatus =>
      'Favorites are stored locally for now and can be replaced by a connected account layer later.';

  @override
  String get favoritesEmptyTitle => 'No saved artists yet';

  @override
  String get favoritesEmptyMessage =>
      'Save artists from their profile to build a shortlist for later booking.';

  @override
  String get favoritesRemoveTooltip => 'Remove from favorites';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileHeadline => 'Manage your account.';

  @override
  String get profileDescription =>
      'Profile and settings stay narrow in V1 and expand only when justified.';

  @override
  String get profileStatus =>
      'Profile now acts as the customer account hub for bookings, favorites, addresses, and preferences.';

  @override
  String get profileHubTitle => 'Account hub';

  @override
  String get profileHubSubtitle =>
      'Move between bookings, saved artists, and service-ready addresses without losing context.';

  @override
  String profileBookingsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count upcoming bookings',
      one: '1 upcoming booking',
      zero: 'No upcoming bookings',
    );
    return '$_temp0';
  }

  @override
  String profileFavoritesSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saved artists',
      one: '1 saved artist',
      zero: 'No saved artists',
    );
    return '$_temp0';
  }

  @override
  String get profileNoDefaultAddressSummary =>
      'No default address selected yet';

  @override
  String get profileWelcomeTitle => 'Finish your account setup';

  @override
  String get profileWelcomeMessage =>
      'Add a saved address and tune notification preferences so booking requests stay easy to track.';

  @override
  String get profilePreferencesTitle => 'Preferences';

  @override
  String get profilePreferencesSubtitle =>
      'A light foundation for service area context, style preferences, and notification expectations.';

  @override
  String get profilePreferredAreaTitle => 'Preferred service area';

  @override
  String get profilePreferredOccasionsTitle => 'Preferred occasions';

  @override
  String get profileCommunicationTitle => 'Communication preference';

  @override
  String get profileAccountTitle => 'Account and support';

  @override
  String get profileNotificationsShortcut =>
      'Manage booking updates, artist responses, reminders, and product news.';

  @override
  String get profileSwitchToArtistMessage =>
      'Switch into the artist workspace without leaving the shared app.';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileEditHeadline => 'Update account details.';

  @override
  String get profileEditDescription =>
      'Keep the basic customer profile current so booking coordination stays straightforward.';

  @override
  String get profileEditNameField => 'Full name';

  @override
  String get profileEditEmailField => 'Email';

  @override
  String get profileEditPhoneField => 'Phone number';

  @override
  String get profileEditCancelCta => 'Cancel';

  @override
  String get profileEditSaveCta => 'Save profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsHeadline => 'Control app preferences.';

  @override
  String get settingsDescription =>
      'Adjust reminders, communication defaults, and trust-related app information without turning this area into account sprawl.';

  @override
  String get settingsStatus =>
      'Settings now cover notification and trust preferences, with account complexity still intentionally limited.';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Keep booking updates useful and timely without creating noise.';

  @override
  String get notificationsHeadline => 'Manage notifications';

  @override
  String get notificationsCustomerDescription =>
      'Choose which booking and artist-response updates should reach you first as the marketplace lifecycle evolves.';

  @override
  String get notificationsArtistDescription =>
      'Keep artist-side requests and business updates visible without turning the dashboard into a noisy inbox.';

  @override
  String get notificationsGateTitle => 'Sign in to manage notifications';

  @override
  String get notificationsGateMessage =>
      'Notification preferences are tied to an account session so the app can restore them cleanly later.';

  @override
  String get notificationsDeliveryTitle => 'Delivery readiness';

  @override
  String get notificationsDeliveryPlaceholder =>
      'Notification delivery wiring is prepared and can bind to platform tokens once push configuration is enabled.';

  @override
  String get notificationsDeliverySignedIn =>
      'Notification delivery wiring is ready for this signed-in session. Device token registration and push transport stay behind the environment-controlled delivery boundary.';

  @override
  String get notificationsDeliveryError =>
      'Notification delivery status is unavailable right now.';

  @override
  String get notificationsArtistResponsesTitle => 'Artist responses';

  @override
  String get notificationsArtistResponsesSubtitle =>
      'Accepted, declined, and other lifecycle responses on your booking requests.';

  @override
  String get notificationsAccountShortcut =>
      'Booking updates, artist responses, reminders, and product news.';

  @override
  String get notificationsArtistShortcut =>
      'Incoming requests and artist-side business updates.';

  @override
  String get settingsBookingUpdatesTitle => 'Booking updates';

  @override
  String get settingsBookingUpdatesSubtitle =>
      'Artist approval, status changes, and key booking updates.';

  @override
  String get settingsRemindersTitle => 'Appointment reminders';

  @override
  String get settingsRemindersSubtitle =>
      'Start-time reminders and preparation nudges before your appointment.';

  @override
  String get settingsPromotionsTitle => 'Product updates';

  @override
  String get settingsPromotionsSubtitle =>
      'Occasional product news, seasonal availability, and service highlights.';

  @override
  String get settingsAppPreferencesTitle => 'App preferences';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle =>
      'English is active in this baseline. Locale switching can be added later.';

  @override
  String get settingsAreaContextTitle => 'Saved address and area context';

  @override
  String get settingsHelpTitle => 'Help, privacy, and trust';

  @override
  String get settingsPrivacyTitle => 'Privacy';

  @override
  String get settingsPrivacySubtitle =>
      'Address and event details are only captured to support booking coordination and travel clarity.';

  @override
  String get settingsTermsTitle => 'Terms of service';

  @override
  String get settingsTermsSubtitle =>
      'Review the current editable marketplace terms draft before public release.';

  @override
  String get settingsBookingPolicyTitle => 'Booking policy';

  @override
  String get settingsBookingPolicySubtitle =>
      'Request-state booking guidance, travel clarity, and support expectations.';

  @override
  String get settingsAboutTitle => 'About Glam2GO';

  @override
  String get settingsAboutSubtitle =>
      'A premium beauty-service marketplace baseline for customer discovery and booking.';

  @override
  String get savedAddressesTitle => 'Saved addresses';

  @override
  String get savedAddressesHeadline => 'Manage service-ready locations.';

  @override
  String get savedAddressesDescription =>
      'Keep a small list of trusted service addresses so future booking reuse stays fast and clear.';

  @override
  String get savedAddressesDefaultLabel => 'Default';

  @override
  String get savedAddressesFutureTitle =>
      'Address management stays intentionally lean';

  @override
  String get savedAddressesFutureMessage =>
      'Add and edit flows can connect later. This pass focuses on clear reuse, default selection, and booking-readiness.';

  @override
  String get supportTitle => 'Help and policies';

  @override
  String get supportHeadline => 'Help, policies, and next steps in one place.';

  @override
  String get supportDescription =>
      'Find booking guidance, policy details, and the right support path without leaving the app guessing.';

  @override
  String get supportEntryTitle => 'Get help';

  @override
  String get supportEntrySubtitle =>
      'Use these links for booking guidance, support direction, and policy details during beta and launch prep.';

  @override
  String get supportEntryChatTitle => 'Contact support';

  @override
  String get supportEntryChatMessage =>
      'Replace this placeholder with your final support channel before launch so customers know exactly where to ask for help.';

  @override
  String get supportEntryPolicyTitle => 'Before you book';

  @override
  String get supportEntryPolicyMessage =>
      'Review booking and cancellation guidance here so expectations stay clear before an appointment is accepted.';

  @override
  String get supportPoliciesTitle => 'Policies';

  @override
  String get supportPoliciesSubtitle =>
      'Keep the most important platform policies easy to find from customer and artist settings.';

  @override
  String get supportPrivacySummary =>
      'Review the current editable privacy draft and how Glam2GO handles account, address, and booking coordination data.';

  @override
  String get supportTermsSummary =>
      'Review the current editable platform terms draft for marketplace access, account usage, and release-stage limitations.';

  @override
  String get supportCancellationSummary =>
      'Review how booking requests, artist responses, and cancellation handling are currently explained in V1.';

  @override
  String get supportBookingSummary =>
      'Review request-state booking expectations, travel clarity, and when to use support instead of self-serve actions.';

  @override
  String get supportFaqTitle => 'Common questions';

  @override
  String get supportFaqSubtitle =>
      'Answer the questions testers and early users ask most often without adding a heavy support flow.';

  @override
  String get supportFaqBookingTitle => 'Booking requests and confirmations';

  @override
  String get supportFaqBookingMessage =>
      'Glam2GO currently treats booking submission as a request. Customers should rely on accepted status, not request submission alone, before treating the appointment as confirmed.';

  @override
  String get supportFaqArtistTitle => 'Artist-side setup and updates';

  @override
  String get supportFaqArtistMessage =>
      'Artists can manage profile, packages, availability, travel policy, and portfolio metadata. Media upload and moderation remain intentionally limited until those contracts are connected.';

  @override
  String get supportFaqAccountTitle => 'Account and session guidance';

  @override
  String get supportFaqAccountMessage =>
      'Use the same shared app for guest browsing, customer account flows, and artist workspace entry. If a session expires, sign in again and Glam2GO will try to return you to the correct route.';

  @override
  String get policyDraftNoticeTitle => 'Draft legal content';

  @override
  String get policyDraftNoticeMessage =>
      'This screen is structurally ready for launch review, but the text should be replaced with approved legal or operations copy before public release.';

  @override
  String get policyPrivacyTitle => 'Privacy policy';

  @override
  String get policyPrivacyHeadline =>
      'Privacy and data handling, explained clearly.';

  @override
  String get policyPrivacyDescription =>
      'This V1 draft explains the main types of customer, artist, and booking data the app currently uses.';

  @override
  String get policyPrivacyCollectionTitle => 'What Glam2GO collects';

  @override
  String get policyPrivacyCollectionBody =>
      'Glam2GO currently stores account basics, booking request details, saved addresses, travel-related booking context, and artist business setup information needed to run discovery and booking coordination.';

  @override
  String get policyPrivacyUseTitle => 'How that data is used';

  @override
  String get policyPrivacyUseBody =>
      'This data is used to restore sessions, power discovery, support booking requests, show artist availability and travel expectations, and keep customer and artist status updates coherent across the marketplace lifecycle.';

  @override
  String get policyPrivacyContactTitle => 'Privacy updates and support';

  @override
  String get policyPrivacyContactBody =>
      'Until a final support and legal workflow is connected, privacy-related questions should route through the main help surface so the team can respond with the latest approved guidance.';

  @override
  String get policyTermsTitle => 'Terms of service';

  @override
  String get policyTermsHeadline => 'Marketplace terms, kept honest for V1.';

  @override
  String get policyTermsDescription =>
      'This V1 draft explains how Glam2GO currently frames account use, booking requests, and release-stage limitations.';

  @override
  String get policyTermsMarketplaceTitle => 'Marketplace expectations';

  @override
  String get policyTermsMarketplaceBody =>
      'Glam2GO is a beauty-service marketplace that connects customers and artists. Booking submission does not guarantee a confirmed appointment unless the lifecycle later reflects artist acceptance.';

  @override
  String get policyTermsAccountsTitle => 'Account usage and access';

  @override
  String get policyTermsAccountsBody =>
      'Guests can browse discovery and booking setup, while saved actions and artist tools require an authenticated account. Role-aware routing and protected actions are part of the current product experience.';

  @override
  String get policyTermsEditsTitle => 'Release-stage limitations';

  @override
  String get policyTermsEditsBody =>
      'This app is still operating with some hybrid local and remote behavior. Product and policy details may be refined as backend contracts, support operations, and legal review become final.';

  @override
  String get policyCancellationTitle => 'Cancellation policy';

  @override
  String get policyCancellationHeadline =>
      'Cancellation expectations for the current release stage.';

  @override
  String get policyCancellationDescription =>
      'This V1 draft explains how cancellation is currently represented in the app and where manual support is still required.';

  @override
  String get policyCancellationRequestsTitle => 'Pending requests';

  @override
  String get policyCancellationRequestsBody =>
      'Pending booking requests can be cancelled by the customer in-app. That keeps the request in history but removes it from active review or active appointment treatment.';

  @override
  String get policyCancellationAcceptedTitle => 'Accepted bookings';

  @override
  String get policyCancellationAcceptedBody =>
      'Accepted bookings can currently be marked as cancelled in-app, but policy enforcement, refunds, and reschedule handling are not yet represented as a full production workflow.';

  @override
  String get policyCancellationSupportTitle => 'When support is needed';

  @override
  String get policyCancellationSupportBody =>
      'Use support for anything that requires exception handling, manual coordination, or clarification beyond the current self-serve cancellation surface.';

  @override
  String get policyBookingTitle => 'Booking policy';

  @override
  String get policyBookingHeadline =>
      'Booking expectations and lifecycle clarity.';

  @override
  String get policyBookingDescription =>
      'This V1 draft keeps request-state wording, travel expectations, and what-happens-next guidance explicit for customers and artists.';

  @override
  String get policyBookingRequestsTitle => 'Request submission';

  @override
  String get policyBookingRequestsBody =>
      'Submitting a booking sends a request to the artist. Customers should wait for accepted status before treating the booking as confirmed, and artists should review request details before accepting.';

  @override
  String get policyBookingTravelTitle => 'Travel and location clarity';

  @override
  String get policyBookingTravelBody =>
      'Travel fees and service-area summaries are shown as part of booking context. Final operational handling may still depend on backend validation and connected policy logic.';

  @override
  String get policyBookingSupportTitle => 'Support and trust';

  @override
  String get policyBookingSupportBody =>
      'Use support surfaces when booking status, travel expectations, or release-stage limitations are unclear. Keep trust language aligned with the shared lifecycle rather than treating requests as guaranteed appointments.';

  @override
  String get customerModeRequiredMessage =>
      'This part of Glam2GO is currently tied to the customer experience. Switch to customer mode to continue.';

  @override
  String get guestBookingsGateTitle => 'Sign in to view your bookings';

  @override
  String get guestBookingsGateMessage =>
      'Guests can explore artists and packages, but bookings history and request tracking need a customer account.';

  @override
  String get guestFavoritesGateTitle => 'Save artists with an account';

  @override
  String get guestFavoritesGateMessage =>
      'Guests can browse freely, but saving artists for later needs a customer account.';

  @override
  String get guestFavoritesActionMessage =>
      'Save this artist after signing in or creating an account. Your current profile view will stay easy to return to.';

  @override
  String get guestProfileGateTitle => 'Sign in to manage your account';

  @override
  String get guestProfileGateMessage =>
      'Profile, saved preferences, and booking-ready account details need a customer account.';

  @override
  String get guestSettingsGateTitle => 'Sign in to change account settings';

  @override
  String get guestSettingsGateMessage =>
      'Notification preferences, saved-area context, and account controls are only available after sign-in.';

  @override
  String get guestAddressesGateTitle => 'Sign in to manage saved addresses';

  @override
  String get guestAddressesGateMessage =>
      'Saved service addresses are tied to customer account reuse in future bookings.';

  @override
  String get bookingStatusPending => 'Pending approval';

  @override
  String get bookingStatusConfirmed => 'Confirmed';

  @override
  String get bookingStatusAccepted => 'Accepted';

  @override
  String get bookingStatusDeclined => 'Declined';

  @override
  String get bookingStatusCancelled => 'Cancelled';

  @override
  String get bookingStatusCompleted => 'Completed';

  @override
  String get bookingLoadingMessage => 'Loading booking updates...';

  @override
  String get bookingLoadErrorTitle => 'Booking updates need another try';

  @override
  String get bookingLoadErrorMessage =>
      'We couldn\'t refresh the latest booking lifecycle details. Try again in a moment.';

  @override
  String get bookingSubmissionFailedMessage =>
      'We couldn\'t submit your booking request right now. Try again in a moment.';

  @override
  String get artistFavoriteTooltip => 'Save artist';

  @override
  String get artistOnboardingTitle => 'Artist onboarding';

  @override
  String get artistOnboardingHeadline => 'Set up your artist profile.';

  @override
  String get artistOnboardingDescription =>
      'Create the minimum professional setup needed to become discoverable and booking-ready later.';

  @override
  String get artistOnboardingWelcomeTitle => 'Become a Glam2GO artist';

  @override
  String get artistOnboardingWelcomeSubtitle =>
      'This flow keeps setup guided and lean: profile, specialties, travel, packages, and availability.';

  @override
  String get artistOnboardingProfileStepTitle => 'Profile basics';

  @override
  String get artistOnboardingSpecialtiesTitle => 'Specialties';

  @override
  String get artistOnboardingTravelTitle => 'Service area and travel';

  @override
  String get artistOnboardingPackagesTitle => 'Packages';

  @override
  String get artistOnboardingPackagesSummary =>
      'Keep packages clean, event-specific, and transparent before publish-ready availability is connected.';

  @override
  String get artistOnboardingAvailabilityTitle => 'Availability';

  @override
  String get artistOnboardingAvailabilitySummary =>
      'Weekly availability is rule-based for now and can later connect to a richer calendar system.';

  @override
  String get artistOnboardingSummaryTitle => 'Readiness summary';

  @override
  String get artistOnboardingSummaryReady =>
      'Your current mock setup is structurally ready for public discovery later.';

  @override
  String artistOnboardingSummaryMissing(Object items) {
    return 'Still incomplete: $items';
  }

  @override
  String get artistOnboardingContinueCta => 'Open artist dashboard';

  @override
  String get artistOnboardingEditProfileCta => 'Edit public profile';

  @override
  String artistOnboardingCurrentStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get artistDashboardTitle => 'Artist dashboard';

  @override
  String get artistDashboardHeadline =>
      'Run your Glam2GO setup from one place.';

  @override
  String get artistDashboardDescription =>
      'Review readiness, upcoming bookings, package coverage, availability, and travel setup without switching to a second app.';

  @override
  String get artistDashboardCompletionTitle => 'Profile readiness';

  @override
  String get artistDashboardPackagesTitle => 'Packages';

  @override
  String get artistDashboardPackagesSubtitle => 'Active service setup';

  @override
  String get artistDashboardAvailabilityTitle => 'Availability';

  @override
  String get artistDashboardAvailabilitySubtitle => 'Weekly availability days';

  @override
  String get artistDashboardServiceAreaTitle => 'Service area';

  @override
  String get artistDashboardBookingsTitle => 'Upcoming';

  @override
  String get artistDashboardBookingsSubtitle => 'Current booking visibility';

  @override
  String artistDashboardPendingBookingsSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accepted appointments',
      one: '1 accepted appointment',
      zero: 'No accepted appointments yet',
    );
    return '$_temp0';
  }

  @override
  String get artistDashboardQuickActionsTitle => 'Quick actions';

  @override
  String get artistDashboardQuickActionsSubtitle =>
      'Move directly into the setup surfaces that affect discoverability and booking readiness.';

  @override
  String get artistDashboardEditProfileCta => 'Edit profile';

  @override
  String get artistDashboardManagePackagesCta => 'Manage packages';

  @override
  String get artistDashboardManageAvailabilityCta => 'Manage availability';

  @override
  String get artistDashboardViewBookingsCta => 'View bookings';

  @override
  String get artistDashboardNextBookingsTitle => 'Next bookings overview';

  @override
  String get artistProfileManagementTitle => 'Artist profile';

  @override
  String get artistProfileManagementHeadline => 'Manage your public profile.';

  @override
  String get artistProfileManagementDescription =>
      'Everything here should map cleanly to what customers eventually see in discovery and profile view.';

  @override
  String get artistProfileDisplayNameField => 'Business or display name';

  @override
  String get artistProfileBioField => 'Short bio';

  @override
  String get artistProfileExperienceField => 'Experience summary';

  @override
  String get artistProfileInstagramField => 'Instagram handle';

  @override
  String get artistProfileTikTokField => 'TikTok handle';

  @override
  String get artistProfileSpecialtiesTitle => 'Specialties and style tags';

  @override
  String get artistProfileSaveCta => 'Save profile details';

  @override
  String get artistProfileValidationMessage =>
      'Add a display name, a short bio, and at least one specialty before saving.';

  @override
  String get artistProfileSavedMessage => 'Artist profile updated.';

  @override
  String get artistPortfolioTitle => 'Portfolio management';

  @override
  String get artistPortfolioAddCta => 'Add portfolio item';

  @override
  String get artistPortfolioSaveCta => 'Save portfolio item';

  @override
  String get artistPortfolioEmptyTitle => 'No portfolio items yet';

  @override
  String get artistPortfolioEmptyMessage =>
      'Add a few polished examples so discovery can communicate trust and style direction clearly.';

  @override
  String get artistPortfolioAddSheetTitle => 'Add portfolio item';

  @override
  String get artistPortfolioEditSheetTitle => 'Edit portfolio item';

  @override
  String get artistPortfolioEditorMessage =>
      'Portfolio metadata is ready now. Media upload is kept behind a clean integration boundary until storage contracts are enabled.';

  @override
  String get artistPortfolioTitleField => 'Look title';

  @override
  String get artistPortfolioCategoryField => 'Category or style';

  @override
  String get artistPortfolioCaptionField => 'Caption';

  @override
  String get artistPortfolioValidationMessage =>
      'Add a title, category, and caption before saving.';

  @override
  String get artistPortfolioUploadPlaceholderNote =>
      'Media upload and ordering stay intentionally lightweight in this phase. Save polished metadata now so the portfolio structure remains ready for external beta.';

  @override
  String get artistPortfolioMediaPending => 'Media pending';

  @override
  String get artistPortfolioMediaReady => 'Media ready';

  @override
  String get artistPortfolioMediaStatusNote =>
      'Media selection and upload stay behind the repository boundary so beta wiring can evolve without changing this UI.';

  @override
  String get artistPortfolioRemoveCta => 'Remove item';

  @override
  String get artistPortfolioRemoveTitle => 'Remove portfolio item?';

  @override
  String get artistPortfolioRemoveMessage =>
      'This removes the item from your public portfolio structure, but the media upload pipeline is still intentionally limited in this phase.';

  @override
  String get artistPackagesTitle => 'Packages';

  @override
  String get artistPackagesHeadline => 'Manage packages and services.';

  @override
  String get artistPackagesDescription =>
      'Define clean package titles, inclusions, pricing, and event fit so customers can compare them quickly.';

  @override
  String get artistPackagesAddCta => 'Add package';

  @override
  String get artistPackagesEditCta => 'Edit package';

  @override
  String get artistPackagesSaveCta => 'Save package';

  @override
  String get artistPackagesSavedMessage => 'Package details updated.';

  @override
  String get artistPackagesActivateCta => 'Mark active';

  @override
  String get artistPackagesDeactivateCta => 'Mark inactive';

  @override
  String get artistPackagesActiveField => 'Package is active';

  @override
  String get artistPackageTitleField => 'Package title';

  @override
  String get artistPackageDescriptionField => 'Description';

  @override
  String get artistPackagePriceField => 'Price';

  @override
  String get artistPackageDurationField => 'Duration (minutes)';

  @override
  String get artistPackageIncludesField => 'Included items (comma separated)';

  @override
  String get artistPackageOccasionsField =>
      'Suitable occasions (comma separated)';

  @override
  String get artistPackageValidationMessage =>
      'Add a title, description, price, duration, inclusions, and suitable occasions before saving.';

  @override
  String get artistAvailabilityTitle => 'Availability';

  @override
  String get artistAvailabilityHeadline => 'Set weekly availability.';

  @override
  String get artistAvailabilityDescription =>
      'Keep availability rule-based and predictable for now. Weekly windows can later connect to a fuller calendar engine.';

  @override
  String get artistAvailabilityAvailableLabel => 'Available';

  @override
  String get artistAvailabilityUnavailableLabel => 'Unavailable';

  @override
  String get artistAvailabilityAddWindowCta => 'Add time window';

  @override
  String get artistAvailabilityEditWindowCta => 'Edit time window';

  @override
  String get artistAvailabilityStartField => 'Start time';

  @override
  String get artistAvailabilityEndField => 'End time';

  @override
  String get artistAvailabilitySaveCta => 'Save window';

  @override
  String get artistAvailabilitySavedMessage => 'Availability updated.';

  @override
  String get artistAvailabilityValidationMessage =>
      'Add both a start time and an end time.';

  @override
  String get artistTravelTitle => 'Service area';

  @override
  String get artistTravelHeadline => 'Define travel policy clearly.';

  @override
  String get artistTravelDescription =>
      'Travel setup should feel transparent and operational, not punitive. This data should later connect directly to customer-side booking logic.';

  @override
  String get artistTravelAreaField => 'Primary service area';

  @override
  String get artistTravelRadiusField => 'Included radius (km)';

  @override
  String get artistTravelFeeField => 'Extra travel fee from';

  @override
  String get artistTravelMaxDistanceField => 'Max travel distance (km)';

  @override
  String get artistTravelNotesField => 'Travel notes';

  @override
  String get artistTravelSaveCta => 'Save travel policy';

  @override
  String get artistTravelValidationMessage =>
      'Add a primary service area, included radius, and max travel distance before saving.';

  @override
  String get artistTravelSavedMessage => 'Travel policy updated.';

  @override
  String artistTravelFeePreview(int fee) {
    return 'Travel fee +\$$fee';
  }

  @override
  String artistTravelRadiusValue(int km) {
    return '$km km included';
  }

  @override
  String artistTravelSummaryValue(Object area, int km) {
    return '$area • $km km included';
  }

  @override
  String get artistBookingsTitle => 'Artist bookings';

  @override
  String get artistBookingsHeadline => 'Review requests and appointments.';

  @override
  String get artistBookingsDescription =>
      'This is the operational booking overview foundation for artists. Accept/decline and deeper workflows can connect later.';

  @override
  String get artistBookingsRequestsTab => 'Requests';

  @override
  String get artistBookingsUpcomingTab => 'Upcoming';

  @override
  String get artistBookingsPastTab => 'Past';

  @override
  String get artistBookingsEmptyTitle => 'No artist bookings yet';

  @override
  String get artistBookingsEmptyMessage =>
      'Booking requests and appointments will appear here once marketplace flows are connected.';

  @override
  String get artistBookingAcceptCta => 'Accept request';

  @override
  String get artistBookingDeclineCta => 'Decline request';

  @override
  String get artistSettingsTitle => 'Artist settings';

  @override
  String get artistSettingsHeadline => 'Business preferences and shortcuts.';

  @override
  String get artistSettingsDescription =>
      'Keep artist-side settings practical: notifications, business setup shortcuts, and help/policy access.';

  @override
  String get artistSettingsNotificationsTitle => 'Notifications';

  @override
  String get artistSettingsRequestsTitle => 'Booking request alerts';

  @override
  String get artistSettingsRequestsSubtitle =>
      'Get notified when a new request needs review or schedule confirmation.';

  @override
  String get artistSettingsBusinessTitle => 'Business settings';

  @override
  String get artistMutationSavingLabel => 'Saving...';

  @override
  String get artistMutationFailedMessage =>
      'We couldn\'t save that update right now. Try again.';

  @override
  String get artistSettingsBusinessSubtitle =>
      'Stay aware of package, availability, and service-area updates.';

  @override
  String get artistSettingsProfileShortcut =>
      'Update the public-facing profile customers will discover later.';

  @override
  String get artistSettingsTravelShortcut =>
      'Review radius, extra-fee setup, and service-area notes.';

  @override
  String get artistSettingsSupportShortcut =>
      'Support, policies, and platform guidance.';

  @override
  String get artistSettingsPolicyShortcut =>
      'Shared booking-policy guidance for artist-side operational use.';

  @override
  String get artistSettingsSwitchToCustomerMessage =>
      'Return to customer browsing, bookings, and saved-account surfaces.';

  @override
  String get artistBookingStatusPending => 'Pending request';

  @override
  String get artistBookingStatusConfirmed => 'Confirmed';

  @override
  String get artistBookingStatusCompleted => 'Completed';

  @override
  String artistReadinessProgress(int completed, int total) {
    return '$completed of $total readiness steps complete';
  }

  @override
  String get artistReadinessProfileLabel => 'profile';

  @override
  String get artistReadinessSpecialtiesLabel => 'specialties';

  @override
  String get artistReadinessTravelLabel => 'travel';

  @override
  String get artistReadinessPackagesLabel => 'packages';

  @override
  String get artistReadinessAvailabilityLabel => 'availability';

  @override
  String artistPackageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count packages',
      one: '1 package',
      zero: 'No packages yet',
    );
    return '$_temp0';
  }

  @override
  String artistAvailabilityDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active days',
      one: '1 active day',
      zero: 'No active days yet',
    );
    return '$_temp0';
  }

  @override
  String get scaffoldIncompleteMessage =>
      'This screen is a baseline scaffold only. Business logic and production content will be added in later feature passes.';

  @override
  String searchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artists',
      one: '1 artist',
      zero: 'No artists',
    );
    return '$_temp0';
  }

  @override
  String artistProfileTravelRadius(int km) {
    return '$km km service radius included';
  }

  @override
  String artistProfileTravelFee(Object fee) {
    return 'Travel beyond the included radius starts from $fee.';
  }

  @override
  String artistProfileTravelDistance(int km) {
    return 'Willing to travel up to $km km for the right booking.';
  }

  @override
  String packageDetailsForArtist(Object artistName) {
    return 'Selected from $artistName';
  }

  @override
  String bookingConfirmationDescription(Object bookingId) {
    return 'Confirmation route loaded for booking id: $bookingId.';
  }

  @override
  String bookingDetailDescription(Object bookingId) {
    return 'Booking detail route loaded for booking id: $bookingId.';
  }

  @override
  String bookingPartySizeValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return '$_temp0';
  }

  @override
  String bookingTravelIncludedNote(int radiusKm) {
    return 'This request appears to sit inside the included $radiusKm km service radius.';
  }

  @override
  String bookingTravelExtraNote(int fee) {
    return 'This address may add an estimated \$$fee travel fee beyond the artist\'s included radius.';
  }

  @override
  String bookingTravelPendingNote(int radiusKm, int fee) {
    return '$radiusKm km is included. Travel beyond that may start from \$$fee after location review.';
  }

  @override
  String bookingSelectedPackageDescription(Object artistId, Object packageId) {
    return 'Booking route loaded for artist $artistId and package $packageId.';
  }
}
