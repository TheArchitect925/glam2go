import '../domain/models/account_models.dart';

const CustomerProfile mockCustomerProfile = CustomerProfile(
  displayName: 'Sana Malik',
  email: 'sana.malik@example.com',
  phoneNumber: '+1 647 555 0183',
  memberSinceLabel: 'Member since 2024',
);

const UserPreferences mockUserPreferences = UserPreferences(
  preferredArea: 'Downtown Toronto',
  preferredOccasions: ['Bridal', 'Soft Glam', 'Formal Event'],
  communicationPreference: 'In-app updates first',
  notificationPreferences: NotificationPreferences(
    bookingUpdates: true,
    artistResponses: true,
    reminders: true,
    promotions: false,
  ),
);

const List<String> mockFavoriteArtistIds = ['aaliyah-noor', 'emilia-hart'];

const List<SavedAddress> mockSavedAddresses = [
  SavedAddress(
    id: 'home-downtown',
    label: 'Home',
    addressLine1: '121 King Street West',
    unitDetails: 'Unit 1804',
    cityArea: 'Toronto',
    accessNotes: 'Concierge access after 8 AM. Paid visitor parking available.',
    isDefault: true,
  ),
  SavedAddress(
    id: 'parents-mississauga',
    label: 'Family home',
    addressLine1: '88 Confederation Parkway',
    unitDetails: '',
    cityArea: 'Mississauga',
    accessNotes: 'Front driveway parking. Ring side entrance bell.',
    isDefault: false,
  ),
];

const List<PolicySummaryItem> mockPolicySummaryItems = [
  PolicySummaryItem(
    id: 'support',
    title: 'Support and help',
    summary:
        'Use support entry points for booking questions, schedule clarification, and service expectations.',
  ),
  PolicySummaryItem(
    id: 'cancellation',
    title: 'Cancellation guidance',
    summary:
        'Cancellation and reschedule actions are not self-serve yet. This foundation keeps the policy language ready for the connected flow.',
  ),
  PolicySummaryItem(
    id: 'privacy',
    title: 'Privacy and trust',
    summary:
        'Address and event details are collected only to support booking coordination and travel clarity.',
  ),
];
