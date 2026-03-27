import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../domain/models/account_models.dart';
import '../../domain/repositories/account_repository.dart';
import '../dtos/account_storage_dto.dart';
import '../local_account_storage.dart';
import '../mock_account_data.dart';

class LocalAccountRepository implements AccountRepository {
  const LocalAccountRepository(this._storage);

  final LocalAccountStorage _storage;

  @override
  List<PolicySummaryItem> getPolicySummaryItems() => mockPolicySummaryItems;

  @override
  Future<AppResult<Set<String>?>> loadFavoriteArtistIds() async {
    try {
      return AppSuccess(await _storage.loadFavoriteArtistIds());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore favorite artists.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<CustomerProfile?>> loadProfile() async {
    try {
      final dto = await _storage.loadProfile();
      return AppSuccess(dto?.toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore customer profile.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<UserPreferences?>> loadPreferences() async {
    try {
      final dto = await _storage.loadPreferences();
      return AppSuccess(dto?.toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore customer preferences.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<List<SavedAddress>?>> loadSavedAddresses() async {
    try {
      final dtos = await _storage.loadSavedAddresses();
      return AppSuccess(
        dtos?.map((dto) => dto.toDomain()).toList(growable: false),
      );
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore saved addresses.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> saveFavoriteArtistIds(Set<String> values) async {
    try {
      await _storage.saveFavoriteArtistIds(values);
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist favorite artists.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> savePreferences(UserPreferences preferences) async {
    try {
      await _storage.savePreferences(
        UserPreferencesDto.fromDomain(preferences),
      );
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist customer preferences.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> saveProfile(CustomerProfile profile) async {
    try {
      await _storage.saveProfile(CustomerProfileDto.fromDomain(profile));
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist customer profile.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> saveSavedAddresses(
    List<SavedAddress> addresses,
  ) async {
    try {
      await _storage.saveSavedAddresses(
        addresses
            .map((address) => SavedAddressDto.fromDomain(address))
            .toList(growable: false),
      );
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist saved addresses.',
          cause: error,
        ),
      );
    }
  }
}
