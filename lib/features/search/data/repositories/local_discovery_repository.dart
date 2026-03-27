import '../../../../core/result/app_result.dart';
import '../../domain/models/discovery_models.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../mock_discovery_catalog.dart';

class LocalDiscoveryRepository implements DiscoveryRepository {
  const LocalDiscoveryRepository();

  @override
  Future<AppResult<DiscoveryCatalog>> loadCatalog() async {
    return const AppSuccess(mockDiscoveryCatalog);
  }
}
