import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/app_api_client.dart';
import '../../../../core/result/app_result.dart';
import '../dtos/artist_management_state_dto.dart';

class ArtistManagementRemoteDataSource {
  const ArtistManagementRemoteDataSource(this._client);

  final AppApiClient _client;

  Future<AppResult<ArtistManagementStateDto>> loadState({
    required String authToken,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.get,
        path: '/v1/artist/me/management',
        headers: {'Authorization': 'Bearer $authToken'},
      ),
    );

    final dataResult = _unwrapResponse(response);
    if (dataResult.failureOrNull != null) {
      return AppFailureResult(dataResult.failureOrNull!);
    }

    final rawState = _extractMap(
      dataResult.dataOrNull,
      primaryKey: 'artist',
      fallbackKey: 'state',
    );
    if (rawState == null) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.serialization,
          message: 'Artist management payload was not a JSON object.',
        ),
      );
    }

    try {
      return AppSuccess(ArtistManagementStateDto.fromMap(rawState));
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Artist management payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }

  Future<AppResult<ArtistProfileDraftDto?>> updateProfile({
    required String authToken,
    required ArtistProfileDraftDto draft,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.put,
        path: '/v1/artist/me/profile',
        headers: {'Authorization': 'Bearer $authToken'},
        body: draft.toMap(),
      ),
    );
    return _parseOptionalPayload(
      response,
      key: 'profile',
      parser: ArtistProfileDraftDto.fromMap,
      fallbackKeys: const ['artistProfile', 'profileDraft'],
    );
  }

  Future<AppResult<ArtistServicePackageDraftDto?>> savePackage({
    required String authToken,
    required ArtistServicePackageDraftDto package,
    required bool isCreate,
  }) async {
    final request = isCreate
        ? ApiRequest(
            method: AppHttpMethod.post,
            path: '/v1/artist/me/packages',
            headers: {'Authorization': 'Bearer $authToken'},
            body: package.toMap(),
          )
        : ApiRequest(
            method: AppHttpMethod.put,
            path: '/v1/artist/me/packages/${package.id}',
            headers: {'Authorization': 'Bearer $authToken'},
            body: package.toMap(),
          );

    final response = await _client.send(request);
    return _parseOptionalPayload(
      response,
      key: 'package',
      parser: ArtistServicePackageDraftDto.fromMap,
      fallbackKeys: const ['artistPackage'],
    );
  }

  Future<AppResult<ArtistPortfolioItemDraftDto?>> savePortfolioItem({
    required String authToken,
    required ArtistPortfolioItemDraftDto item,
    required bool isCreate,
  }) async {
    final request = isCreate
        ? ApiRequest(
            method: AppHttpMethod.post,
            path: '/v1/artist/me/portfolio',
            headers: {'Authorization': 'Bearer $authToken'},
            body: item.toMap(),
          )
        : ApiRequest(
            method: AppHttpMethod.put,
            path: '/v1/artist/me/portfolio/${item.id}',
            headers: {'Authorization': 'Bearer $authToken'},
            body: item.toMap(),
          );

    final response = await _client.send(request);
    return _parseOptionalPayload(
      response,
      key: 'portfolioItem',
      parser: ArtistPortfolioItemDraftDto.fromMap,
      fallbackKeys: const ['portfolio', 'item'],
    );
  }

  Future<AppResult<void>> removePortfolioItem({
    required String authToken,
    required String itemId,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.delete,
        path: '/v1/artist/me/portfolio/$itemId',
        headers: {'Authorization': 'Bearer $authToken'},
      ),
    );

    final dataResult = _unwrapResponse(response);
    if (dataResult.failureOrNull != null) {
      return AppFailureResult(dataResult.failureOrNull!);
    }
    return const AppSuccess(null);
  }

  Future<AppResult<List<ArtistAvailabilityDayDto>?>> saveAvailabilityDays({
    required String authToken,
    required List<ArtistAvailabilityDayDto> availabilityDays,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.put,
        path: '/v1/artist/me/availability',
        headers: {'Authorization': 'Bearer $authToken'},
        body: {
          'availabilityDays': availabilityDays
              .map((item) => item.toMap())
              .toList(growable: false),
        },
      ),
    );

    final dataResult = _unwrapResponse(response);
    if (dataResult.failureOrNull != null) {
      return AppFailureResult(dataResult.failureOrNull!);
    }

    final data = dataResult.dataOrNull;
    if (data == null) {
      return const AppSuccess(null);
    }

    final rawList = switch (data) {
      {'availabilityDays': final List<Object?> items} => items,
      {'availability': final List<Object?> items} => items,
      final List<Object?> items => items,
      _ => null,
    };

    if (rawList == null) {
      return const AppSuccess(null);
    }

    try {
      final dtos = rawList
          .whereType<Map>()
          .map(
            (item) =>
                ArtistAvailabilityDayDto.fromMap(item.cast<String, Object?>()),
          )
          .toList(growable: false);
      return AppSuccess(dtos);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Availability payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }

  Future<AppResult<ArtistTravelPolicyDto?>> updateTravelPolicy({
    required String authToken,
    required ArtistTravelPolicyDto travelPolicy,
  }) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.put,
        path: '/v1/artist/me/travel-policy',
        headers: {'Authorization': 'Bearer $authToken'},
        body: travelPolicy.toMap(),
      ),
    );
    return _parseOptionalPayload(
      response,
      key: 'travelPolicy',
      parser: ArtistTravelPolicyDto.fromMap,
      fallbackKeys: const ['serviceArea'],
    );
  }

  AppResult<T?> _parseOptionalPayload<T>(
    AppResult<ApiResponse> response, {
    required String key,
    required T Function(Map<String, Object?> map) parser,
    List<String> fallbackKeys = const <String>[],
  }) {
    final dataResult = _unwrapResponse(response);
    if (dataResult.failureOrNull != null) {
      return AppFailureResult(dataResult.failureOrNull!);
    }

    final data = dataResult.dataOrNull;
    if (data == null) {
      return const AppSuccess(null);
    }

    Map<String, Object?>? rawMap = _extractMap(data, primaryKey: key);
    for (final candidateKey in fallbackKeys) {
      rawMap ??= _extractMap(data, primaryKey: candidateKey);
    }
    if (rawMap == null) {
      return const AppSuccess(null);
    }

    try {
      return AppSuccess(parser(rawMap));
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Artist mutation payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }

  Map<String, Object?>? _extractMap(
    Object? data, {
    required String primaryKey,
    String? fallbackKey,
  }) {
    if (data is Map<Object?, Object?>) {
      final map = data.cast<String, Object?>();
      final primary = map[primaryKey];
      if (primary is Map<Object?, Object?>) {
        return primary.cast<String, Object?>();
      }
      if (fallbackKey != null) {
        final fallback = map[fallbackKey];
        if (fallback is Map<Object?, Object?>) {
          return fallback.cast<String, Object?>();
        }
      }
      return map;
    }
    return null;
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
          message: 'Artist management request was not authorized.',
        ),
      );
    }
    if (apiResponse.statusCode < 200 || apiResponse.statusCode >= 300) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message:
              'Artist management request failed with status ${apiResponse.statusCode}.',
        ),
      );
    }

    return AppSuccess(apiResponse.data);
  }
}
