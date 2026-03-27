import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/core/network/app_api_client.dart';
import 'package:glam2go/core/result/app_result.dart';
import 'package:glam2go/features/artist_management/data/dtos/artist_management_state_dto.dart';
import 'package:glam2go/features/artist_management/data/local_artist_management_storage.dart';
import 'package:glam2go/features/artist_management/data/mock_artist_management_data.dart';
import 'package:glam2go/features/artist_management/data/remote/artist_management_remote_data_source.dart';
import 'package:glam2go/features/artist_management/data/repositories/hybrid_artist_management_repository.dart';
import 'package:glam2go/features/artist_management/domain/models/artist_management_models.dart';
import 'package:glam2go/features/session/data/dtos/session_storage_dto.dart';
import 'package:glam2go/features/session/data/local_session_storage.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';
import '../support/fake_api_client.dart';

const remoteConfig = AppConfig(
  environment: AppEnvironment.development,
  apiBaseUrl: 'https://api.dev.glam2go.example',
  enableLocalPersistence: true,
  enableDebugDefaultAccounts: true,
  enableLifecycleTimeline: true,
  enableRemoteSession: false,
  enableRemoteDiscovery: false,
  enableRemoteBookings: false,
  enableRemoteArtistManagement: true,
  enableNotificationDelivery: false,
  enableAnalytics: true,
  enableCrashReporting: false,
  enableApiDebugLogging: false,
);

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('hybrid artist repository loads remote management state', () async {
    final repository = await _buildRepository(
      handlers: {
        'GET /v1/artist/me/management': (_) async => AppSuccess(
          ApiResponse(
            statusCode: 200,
            data: {
              'artist': ArtistManagementStateDto.fromDomain(
                mockArtistManagementState.copyWith(
                  travelPolicy: mockArtistManagementState.travelPolicy.copyWith(
                    primaryServiceArea: 'Scarborough',
                  ),
                ),
              ).toMap(),
            },
          ),
        ),
      },
    );

    final result = await repository.loadState();

    expect(result.dataOrNull?.travelPolicy.primaryServiceArea, 'Scarborough');
  });

  test('hybrid artist repository updates travel policy remotely', () async {
    final updatedPolicy = mockArtistManagementState.travelPolicy.copyWith(
      primaryServiceArea: 'North York',
      includedRadiusKm: 22,
    );
    final repository = await _buildRepository(
      handlers: {
        'GET /v1/artist/me/management': (_) async => AppSuccess(
          ApiResponse(
            statusCode: 200,
            data: {
              'artist': ArtistManagementStateDto.fromDomain(
                mockArtistManagementState,
              ).toMap(),
            },
          ),
        ),
        'PUT /v1/artist/me/travel-policy': (_) async => AppSuccess(
          ApiResponse(
            statusCode: 200,
            data: {
              'travelPolicy': ArtistTravelPolicyDto.fromDomain(
                updatedPolicy,
              ).toMap(),
            },
          ),
        ),
      },
    );

    final result = await repository.updateTravelPolicy(updatedPolicy);

    expect(result.dataOrNull?.travelPolicy.primaryServiceArea, 'North York');
    expect(result.dataOrNull?.travelPolicy.includedRadiusKm, 22);
  });

  test('hybrid artist repository saves portfolio item remotely', () async {
    const portfolioItem = ArtistPortfolioItemDraft(
      id: 'portfolio-new',
      title: 'Reception bronze glam',
      category: 'Reception',
      caption: 'Soft bronze eyes with polished skin and long-wear finish.',
      mediaReference: 'portfolio-reception-bronze-glam',
      startColorValue: 0xFFF3DFD7,
      endColorValue: 0xFFB8818E,
    );
    final repository = await _buildRepository(
      handlers: {
        'GET /v1/artist/me/management': (_) async => AppSuccess(
          ApiResponse(
            statusCode: 200,
            data: {
              'artist': ArtistManagementStateDto.fromDomain(
                mockArtistManagementState,
              ).toMap(),
            },
          ),
        ),
        'POST /v1/artist/me/portfolio': (_) async => AppSuccess(
          ApiResponse(
            statusCode: 200,
            data: {
              'portfolioItem': ArtistPortfolioItemDraftDto.fromDomain(
                portfolioItem,
              ).toMap(),
            },
          ),
        ),
      },
    );

    final result = await repository.savePortfolioItem(portfolioItem);

    expect(
      result.dataOrNull?.profileDraft.portfolioItems.any(
        (item) => item.id == 'portfolio-new',
      ),
      isTrue,
    );
  });
}

Future<HybridArtistManagementRepository> _buildRepository({
  required Map<String, ApiHandler> handlers,
}) async {
  final sessionStorage = const LocalSessionStorage();
  await sessionStorage.save(
    SessionStorageDto.fromDomain(
      const SessionState.authenticated(
        userMode: AppUserMode.artist,
        userSummary: SessionUserSummary(
          userId: 'artist-aaliyah-noor',
          displayName: 'Aaliyah Noor',
          email: 'artist@glam2go.example',
          mode: AppUserMode.artist,
          artistProfileId: 'aaliyah-noor',
          isNewAccount: false,
        ),
      ),
      authToken: 'artist-token',
    ),
  );

  return HybridArtistManagementRepository(
    storage: const LocalArtistManagementStorage(),
    sessionStorage: sessionStorage,
    remoteDataSource: ArtistManagementRemoteDataSource(
      FakeAppApiClient(handlers: handlers),
    ),
    config: remoteConfig,
  );
}
