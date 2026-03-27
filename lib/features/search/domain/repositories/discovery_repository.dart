import '../../../../core/result/app_result.dart';
import '../models/discovery_models.dart';

abstract class DiscoveryRepository {
  Future<AppResult<DiscoveryCatalog>> loadCatalog();
}
