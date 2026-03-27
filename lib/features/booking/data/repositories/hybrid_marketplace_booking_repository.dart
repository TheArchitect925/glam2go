import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../../session/data/local_session_storage.dart';
import '../../../session/domain/models/session_models.dart';
import '../../domain/models/booking_models.dart';
import '../../domain/models/marketplace_booking_models.dart';
import '../../domain/repositories/marketplace_booking_repository.dart';
import '../dtos/booking_submission_payload_dto.dart';
import '../dtos/marketplace_booking_dto.dart';
import '../local_marketplace_booking_storage.dart';
import '../remote/marketplace_booking_remote_data_source.dart';
import 'local_marketplace_booking_repository.dart';

class HybridMarketplaceBookingRepository
    implements MarketplaceBookingRepository {
  const HybridMarketplaceBookingRepository({
    required LocalMarketplaceBookingStorage bookingStorage,
    required LocalSessionStorage sessionStorage,
    required MarketplaceBookingRemoteDataSource remoteDataSource,
    required AppConfig config,
  }) : _bookingStorage = bookingStorage,
       _sessionStorage = sessionStorage,
       _remoteDataSource = remoteDataSource,
       _config = config;

  final LocalMarketplaceBookingStorage _bookingStorage;
  final LocalSessionStorage _sessionStorage;
  final MarketplaceBookingRemoteDataSource _remoteDataSource;
  final AppConfig _config;

  LocalMarketplaceBookingRepository get _localRepository =>
      LocalMarketplaceBookingRepository(_bookingStorage);

  @override
  Future<AppResult<List<MarketplaceBookingRecord>>> loadBookings() async {
    if (!_config.enableRemoteBookings) {
      return _localRepository.loadBookings();
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in session is required to load bookings.',
        ),
      );
    }

    final result = await _remoteDataSource.loadBookings(authToken: authToken);
    if (result.dataOrNull != null) {
      await _localRepository.saveCache(result.dataOrNull!);
    }
    return result;
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> submitBookingRequest({
    required BookingDraft draft,
    required SessionUserSummary customer,
    required bool originatedAsGuest,
  }) async {
    if (!_config.enableRemoteBookings) {
      return _localRepository.submitBookingRequest(
        draft: draft,
        customer: customer,
        originatedAsGuest: originatedAsGuest,
      );
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in session is required to submit bookings.',
        ),
      );
    }

    final result = await _remoteDataSource.submitBookingRequest(
      authToken: authToken,
      payload: BookingSubmissionPayloadDto.fromDomain(
        draft: draft,
        customer: customer,
        originatedAsGuest: originatedAsGuest,
      ),
    );

    if (result.dataOrNull != null) {
      await _upsertCache(result.dataOrNull!);
    }
    return result;
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> applyArtistDecision({
    required String bookingId,
    required BookingRequestDecision decision,
  }) async {
    if (!_config.enableRemoteBookings) {
      return _localRepository.applyArtistDecision(
        bookingId: bookingId,
        decision: decision,
      );
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in session is required to update bookings.',
        ),
      );
    }

    final result = await _remoteDataSource.applyArtistDecision(
      authToken: authToken,
      bookingId: bookingId,
      decision: decision,
    );
    if (result.dataOrNull != null) {
      await _upsertCache(result.dataOrNull!);
    }
    return result;
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> cancelBookingRequest(
    String bookingId,
  ) async {
    if (!_config.enableRemoteBookings) {
      return _localRepository.cancelBookingRequest(bookingId);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in session is required to update bookings.',
        ),
      );
    }

    final result = await _remoteDataSource.cancelBookingRequest(
      authToken: authToken,
      bookingId: bookingId,
    );
    if (result.dataOrNull != null) {
      await _upsertCache(result.dataOrNull!);
    }
    return result;
  }

  Future<String?> _loadAuthToken() async {
    final session = await _sessionStorage.load();
    return session?.authToken;
  }

  Future<void> _upsertCache(MarketplaceBookingRecord updated) async {
    final raw = await _bookingStorage.loadBookings();
    final records = raw == null
        ? <MarketplaceBookingRecord>[]
        : raw
              .map(MarketplaceBookingDto.fromMap)
              .map((dto) => dto.toDomain())
              .toList(growable: true);
    final index = records.indexWhere((item) => item.id == updated.id);
    if (index >= 0) {
      records[index] = updated;
    } else {
      records.insert(0, updated);
    }
    await _localRepository.saveCache(records);
  }
}
