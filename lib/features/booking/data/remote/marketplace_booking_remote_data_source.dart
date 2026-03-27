import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/app_api_client.dart';
import '../../../../core/result/app_result.dart';
import '../dtos/booking_submission_payload_dto.dart';
import '../dtos/marketplace_booking_dto.dart';
import '../../domain/models/marketplace_booking_models.dart';

class MarketplaceBookingRemoteDataSource {
  const MarketplaceBookingRemoteDataSource(this._client);

  final AppApiClient _client;

  Future<AppResult<List<MarketplaceBookingRecord>>> loadBookings({
    required String authToken,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.get,
        path: '/v1/bookings',
        headers: {'Authorization': 'Bearer $authToken'},
      ),
    );

    final apiResponse = _unwrapResponse(response);
    if (apiResponse.failureOrNull != null) {
      return AppFailureResult(apiResponse.failureOrNull!);
    }

    final data = apiResponse.dataOrNull!;
    final rawList = switch (data) {
      {'bookings': final List<Object?> bookings} => bookings,
      final List<Object?> bookings => bookings,
      _ => null,
    };

    if (rawList == null) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.serialization,
          message: 'Booking list payload was not a JSON list.',
        ),
      );
    }

    try {
      final records = rawList
          .whereType<Map>()
          .map(
            (item) =>
                MarketplaceBookingDto.fromMap(item.cast<String, Object?>()),
          )
          .map((dto) => dto.toDomain())
          .toList(growable: false);
      return AppSuccess(records);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Booking list payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }

  Future<AppResult<MarketplaceBookingRecord>> submitBookingRequest({
    required String authToken,
    required BookingSubmissionPayloadDto payload,
  }) {
    return _sendRecordRequest(
      ApiRequest(
        method: AppHttpMethod.post,
        path: '/v1/bookings/requests',
        headers: {'Authorization': 'Bearer $authToken'},
        body: payload.toMap(),
      ),
    );
  }

  Future<AppResult<MarketplaceBookingRecord>> applyArtistDecision({
    required String authToken,
    required String bookingId,
    required BookingRequestDecision decision,
  }) {
    return _sendRecordRequest(
      ApiRequest(
        method: AppHttpMethod.post,
        path: '/v1/bookings/$bookingId/decision',
        headers: {'Authorization': 'Bearer $authToken'},
        body: {'decision': decision.name},
      ),
    );
  }

  Future<AppResult<MarketplaceBookingRecord>> cancelBookingRequest({
    required String authToken,
    required String bookingId,
  }) {
    return _sendRecordRequest(
      ApiRequest(
        method: AppHttpMethod.post,
        path: '/v1/bookings/$bookingId/cancel',
        headers: {'Authorization': 'Bearer $authToken'},
      ),
    );
  }

  Future<AppResult<MarketplaceBookingRecord>> _sendRecordRequest(
    ApiRequest request,
  ) async {
    final response = await _client.send(request);
    final apiResponse = _unwrapResponse(response);
    if (apiResponse.failureOrNull != null) {
      return AppFailureResult(apiResponse.failureOrNull!);
    }

    final data = apiResponse.dataOrNull!;
    final rawRecord = switch (data) {
      {'booking': final Map<Object?, Object?> booking} =>
        booking.cast<String, Object?>(),
      final Map<Object?, Object?> booking => booking.cast<String, Object?>(),
      _ => null,
    };

    if (rawRecord == null) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.serialization,
          message: 'Booking response payload was not a JSON object.',
        ),
      );
    }

    try {
      return AppSuccess(MarketplaceBookingDto.fromMap(rawRecord).toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Booking response payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }

  AppResult<Object?> _unwrapResponse(AppResult<ApiResponse> response) {
    if (response.failureOrNull != null) {
      return AppFailureResult(response.failureOrNull!);
    }

    final apiResponse = response.dataOrNull!;
    if (apiResponse.statusCode == 401) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.unauthorized,
          message: 'Booking request was not authorized.',
        ),
      );
    }
    if (apiResponse.statusCode < 200 || apiResponse.statusCode >= 300) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message:
              'Booking request failed with status ${apiResponse.statusCode}.',
        ),
      );
    }

    return AppSuccess(apiResponse.data);
  }
}
