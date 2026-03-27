import '../../../../core/result/app_result.dart';
import '../models/account_models.dart';

abstract class AccountRepository {
  Future<AppResult<CustomerProfile?>> loadProfile();
  Future<AppResult<void>> saveProfile(CustomerProfile profile);

  Future<AppResult<UserPreferences?>> loadPreferences();
  Future<AppResult<void>> savePreferences(UserPreferences preferences);

  Future<AppResult<Set<String>?>> loadFavoriteArtistIds();
  Future<AppResult<void>> saveFavoriteArtistIds(Set<String> values);

  Future<AppResult<List<SavedAddress>?>> loadSavedAddresses();
  Future<AppResult<void>> saveSavedAddresses(List<SavedAddress> addresses);

  List<PolicySummaryItem> getPolicySummaryItems();
}
