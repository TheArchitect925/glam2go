import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/core/network/app_api_client.dart';
import 'package:glam2go/core/result/app_result.dart';
import 'package:glam2go/features/booking/data/local_marketplace_booking_storage.dart';
import 'package:glam2go/features/booking/data/remote/marketplace_booking_remote_data_source.dart';
import 'package:glam2go/features/booking/data/repositories/hybrid_marketplace_booking_repository.dart';
import 'package:glam2go/features/booking/domain/models/booking_models.dart';
import 'package:glam2go/features/booking/domain/models/marketplace_booking_models.dart';
import 'package:glam2go/features/session/data/dtos/session_storage_dto.dart';
import 'package:glam2go/features/session/data/local_session_storage.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

import '../support/fake_api_client.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  const remoteConfig = AppConfig(
    environment: AppEnvironment.development,
    apiBaseUrl: 'https://api.dev.glam2go.example',
    enableLocalPersistence: true,
    enableDebugDefaultAccounts: true,
    enableLifecycleTimeline: true,
    enableRemoteSession: false,
    enableRemoteDiscovery: false,
    enableRemoteBookings: true,
    enableRemoteArtistManagement: false,
    enableNotificationDelivery: false,
    enableAnalytics: true,
    enableCrashReporting: false,
    enableApiDebugLogging: false,
  );

  test('hybrid marketplace booking repository loads remote records', () async {
    final sessionStorage = const LocalSessionStorage();
    await sessionStorage.save(
      SessionStorageDto.fromDomain(
        const SessionState.authenticated(
          userMode: AppUserMode.customer,
          userSummary: SessionUserSummary(
            userId: 'customer-sana-malik',
            displayName: 'Sana Malik',
            email: 'sana.malik@example.com',
            mode: AppUserMode.customer,
            isNewAccount: false,
          ),
        ),
        authToken: 'session-token-123',
      ),
    );

    final repository = HybridMarketplaceBookingRepository(
      bookingStorage: const LocalMarketplaceBookingStorage(),
      sessionStorage: sessionStorage,
      remoteDataSource: MarketplaceBookingRemoteDataSource(
        FakeAppApiClient(
          handlers: {
            'GET /v1/bookings': (request) async => AppSuccess(
              ApiResponse(
                statusCode: 200,
                data: {
                  'bookings': [_remoteBooking],
                },
              ),
            ),
          },
        ),
      ),
      config: remoteConfig,
    );

    final result = await repository.loadBookings();

    expect(result.dataOrNull, hasLength(1));
    expect(result.dataOrNull?.first.id, 'bk-remote-1');
    expect(
      result.dataOrNull?.first.status,
      BookingLifecycleStatus.pendingArtistResponse,
    );
  });

  test(
    'hybrid marketplace booking repository submits remote booking request',
    () async {
      final sessionStorage = const LocalSessionStorage();
      await sessionStorage.save(
        SessionStorageDto.fromDomain(
          const SessionState.authenticated(
            userMode: AppUserMode.customer,
            userSummary: SessionUserSummary(
              userId: 'customer-sana-malik',
              displayName: 'Sana Malik',
              email: 'sana.malik@example.com',
              mode: AppUserMode.customer,
              isNewAccount: false,
            ),
          ),
          authToken: 'session-token-123',
        ),
      );

      final repository = HybridMarketplaceBookingRepository(
        bookingStorage: const LocalMarketplaceBookingStorage(),
        sessionStorage: sessionStorage,
        remoteDataSource: MarketplaceBookingRemoteDataSource(
          FakeAppApiClient(
            handlers: {
              'POST /v1/bookings/requests': (request) async => AppSuccess(
                ApiResponse(statusCode: 201, data: {'booking': _remoteBooking}),
              ),
            },
          ),
        ),
        config: remoteConfig,
      );

      final result = await repository.submitBookingRequest(
        draft: _draft,
        customer: const SessionUserSummary(
          userId: 'customer-sana-malik',
          displayName: 'Sana Malik',
          email: 'sana.malik@example.com',
          mode: AppUserMode.customer,
          isNewAccount: false,
        ),
        originatedAsGuest: false,
      );

      expect(result.dataOrNull?.id, 'bk-remote-1');

      final cached = await const LocalMarketplaceBookingStorage()
          .loadBookings();
      expect(cached, hasLength(1));
    },
  );
}

const _remoteBooking = {
  'id': 'bk-remote-1',
  'customerId': 'customer-sana-malik',
  'customerName': 'Sana Malik',
  'artistId': 'aaliyah-noor',
  'artistName': 'Aaliyah Noor',
  'packageId': 'bridal-signature',
  'packageTitle': 'Signature Bridal',
  'status': 'pendingArtistResponse',
  'scheduledAtIso': '2026-04-20T00:00:00.000',
  'timeLabel': '9:00 AM',
  'location': {
    'addressLine1': '121 King Street West',
    'unitDetails': 'Unit 1804',
    'cityArea': 'Toronto',
    'accessNotes': 'Concierge access',
  },
  'eventDetails': {
    'occasion': 'Bridal',
    'partySize': 1,
    'notes': 'Soft glam bridal look',
  },
  'travelFeeSummary': {'isIncluded': true, 'locationKnown': true, 'fee': 0},
  'priceSummary': {'subtotal': 320, 'travelFee': 0, 'total': 320},
  'timeline': [
    {
      'status': 'pendingArtistResponse',
      'occurredAtIso': '2026-03-26T10:00:00.000',
      'note': 'Booking request submitted for artist review.',
    },
  ],
  'requestedAtIso': '2026-03-26T10:00:00.000',
  'isUpcoming': true,
  'originatedAsGuest': false,
  'policySummary':
      'This request is not a final confirmed appointment until the artist accepts it.',
  'nextStepNote':
      'Your request is waiting on the artist to confirm availability, timing, and travel details.',
};

final _draft = BookingDraft.initial().copyWith(
  artistId: 'aaliyah-noor',
  artistName: 'Aaliyah Noor',
  selectedPackage: const SelectedServicePackage(
    id: 'bridal-signature',
    title: 'Signature Bridal',
    description: 'Luxury bridal package',
    price: 320,
    durationMinutes: 120,
    includes: ['Lashes'],
  ),
  eventDetails: const BookingEventDetails(
    occasion: 'Bridal',
    partySize: 1,
    notes: 'Soft glam bridal look',
  ),
  dateSelection: BookingDateSelection(
    date: DateTime(2026, 4, 20),
    label: 'Mon 20 Apr',
  ),
  timeSelection: const BookingTimeSelection(label: '9:00 AM', time24h: '09:00'),
  location: const BookingLocation(
    addressLine1: '121 King Street West',
    unitDetails: 'Unit 1804',
    cityArea: 'Toronto',
    accessNotes: 'Concierge access',
  ),
  travelFeeSummary: const TravelFeeSummary(
    isIncluded: true,
    locationKnown: true,
    fee: 0,
  ),
  priceSummary: const BookingPriceSummary(
    subtotal: 320,
    travelFee: 0,
    total: 320,
  ),
);
