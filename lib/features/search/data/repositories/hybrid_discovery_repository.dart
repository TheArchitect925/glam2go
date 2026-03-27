import '../../../../core/config/app_config.dart';
import '../../../../core/result/app_result.dart';
import '../../domain/models/discovery_models.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../mock_discovery_catalog.dart';
import '../remote/discovery_remote_data_source.dart';

class HybridDiscoveryRepository implements DiscoveryRepository {
  const HybridDiscoveryRepository({
    required DiscoveryRemoteDataSource remoteDataSource,
    required AppConfig config,
  }) : _remoteDataSource = remoteDataSource,
       _config = config;

  final DiscoveryRemoteDataSource _remoteDataSource;
  final AppConfig _config;

  @override
  Future<AppResult<DiscoveryCatalog>> loadCatalog() async {
    if (!_config.enableRemoteDiscovery) {
      return const AppSuccess(mockDiscoveryCatalog);
    }

    final remoteResult = await _remoteDataSource.loadCatalog();
    if (remoteResult.dataOrNull != null) {
      return AppSuccess(remoteResult.dataOrNull!.toDomain());
    }
    return AppFailureResult(remoteResult.failureOrNull!);
  }
}
