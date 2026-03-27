import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/core/result/app_result.dart';
import 'package:glam2go/core/network/app_api_client.dart';
import 'package:glam2go/features/search/data/remote/discovery_remote_data_source.dart';
import 'package:glam2go/features/search/data/repositories/hybrid_discovery_repository.dart';

import '../support/fake_api_client.dart';

void main() {
  const remoteConfig = AppConfig(
    environment: AppEnvironment.development,
    apiBaseUrl: 'https://api.dev.glam2go.example',
    enableLocalPersistence: true,
    enableDebugDefaultAccounts: true,
    enableLifecycleTimeline: true,
    enableRemoteSession: false,
    enableRemoteDiscovery: true,
    enableRemoteBookings: false,
    enableRemoteArtistManagement: false,
    enableNotificationDelivery: false,
    enableAnalytics: true,
    enableCrashReporting: false,
    enableApiDebugLogging: false,
  );

  test('hybrid discovery repository parses remote catalog payload', () async {
    final repository = HybridDiscoveryRepository(
      remoteDataSource: DiscoveryRemoteDataSource(
        FakeAppApiClient(
          handlers: {
            'GET /v1/discovery/catalog': (request) async => AppSuccess(
              const ApiResponse(
                statusCode: 200,
                data: {
                  'occasions': ['Bridal'],
                  'featuredArtistIds': ['artist-1'],
                  'popularPackageIds': ['package-1'],
                  'profiles': [
                    {
                      'summary': {
                        'id': 'artist-1',
                        'name': 'Noor Artistry',
                        'locationLabel': 'Toronto',
                        'reviewSummary': {
                          'rating': 4.9,
                          'reviewCount': 24,
                          'highlight': 'Strong bridal reviews',
                        },
                        'specialties': ['Bridal'],
                        'startingPrice': 180,
                        'availabilityHint': 'Limited spots this week',
                        'travelSummary': 'Travel included within Toronto',
                        'heroStartColorValue': 4294181847,
                        'heroEndColorValue': 4289753482,
                        'heroLabel': 'Bridal focus',
                      },
                      'bio': 'Premium bridal artistry.',
                      'portfolioItems': [
                        {
                          'id': 'portfolio-1',
                          'title': 'Classic bridal',
                          'styleLabel': 'Soft glam',
                          'startColorValue': 4294181847,
                          'endColorValue': 4289753482,
                        },
                      ],
                      'packages': [
                        {
                          'id': 'package-1',
                          'title': 'Signature Bridal',
                          'description': 'Luxury bridal package.',
                          'price': 320,
                          'durationMinutes': 120,
                          'includes': ['Lashes'],
                          'suitableFor': ['Bridal'],
                          'isFeatured': true,
                        },
                      ],
                      'availabilityPreview': {
                        'headline': 'Available this week',
                        'nextDates': ['Fri 12 Apr'],
                        'note': 'Final confirmation follows artist review.',
                      },
                      'travelPolicy': {
                        'includedRadiusKm': 20,
                        'extraFeeFrom': 30,
                        'maxTravelDistanceKm': 45,
                        'summary': 'Travel stays clear before booking.',
                      },
                      'trustSignals': ['Verified portfolio'],
                      'socialProof':
                          'Trusted by bridal clients across the GTA.',
                    },
                  ],
                },
              ),
            ),
          },
        ),
      ),
      config: remoteConfig,
    );

    final result = await repository.loadCatalog();

    expect(result.dataOrNull?.profiles, hasLength(1));
    expect(result.dataOrNull?.profiles.first.summary.name, 'Noor Artistry');
    expect(result.dataOrNull?.featuredArtists.first.id, 'artist-1');
  });

  test('hybrid discovery repository surfaces remote failures', () async {
    final repository = HybridDiscoveryRepository(
      remoteDataSource: DiscoveryRemoteDataSource(
        FakeAppApiClient(
          handlers: {
            'GET /v1/discovery/catalog': (request) async =>
                const AppSuccess(ApiResponse(statusCode: 500, data: {})),
          },
        ),
      ),
      config: remoteConfig,
    );

    final result = await repository.loadCatalog();

    expect(result.isFailure, isTrue);
  });
}
