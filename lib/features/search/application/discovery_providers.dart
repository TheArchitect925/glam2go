import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/network/network_providers.dart';
import '../data/mock_discovery_catalog.dart';
import '../domain/models/discovery_models.dart';
import '../domain/repositories/discovery_repository.dart';
import '../data/remote/discovery_remote_data_source.dart';
import '../data/repositories/hybrid_discovery_repository.dart';

final discoveryRepositoryProvider = Provider<DiscoveryRepository>((ref) {
  return HybridDiscoveryRepository(
    remoteDataSource: DiscoveryRemoteDataSource(
      ref.watch(appApiClientProvider),
    ),
    config: ref.watch(appConfigProvider),
  );
});

final discoveryCatalogProvider =
    AsyncNotifierProvider<DiscoveryCatalogController, DiscoveryCatalog>(
      DiscoveryCatalogController.new,
    );

class DiscoveryCatalogController extends AsyncNotifier<DiscoveryCatalog> {
  @override
  Future<DiscoveryCatalog> build() async {
    final result = await ref.read(discoveryRepositoryProvider).loadCatalog();
    if (result.dataOrNull != null) {
      return result.dataOrNull!;
    }
    throw _DiscoveryLoadException(result.failureOrNull?.message);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(discoveryRepositoryProvider).loadCatalog();
      if (result.dataOrNull != null) {
        return result.dataOrNull!;
      }
      throw _DiscoveryLoadException(result.failureOrNull?.message);
    });
  }
}

class _DiscoveryLoadException implements Exception {
  const _DiscoveryLoadException(this.message);

  final String? message;

  @override
  String toString() => message ?? 'Discovery catalog failed to load.';
}

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedOccasionProvider = StateProvider<String?>((ref) => null);

final discoveryCatalogSnapshotProvider = Provider<DiscoveryCatalog>((ref) {
  return ref.watch(discoveryCatalogProvider).valueOrNull ??
      mockDiscoveryCatalog;
});

final occasionOptionsProvider = Provider<AsyncValue<List<String>>>((ref) {
  return ref
      .watch(discoveryCatalogProvider)
      .whenData((catalog) => catalog.occasions);
});

final artistProfilesProvider = Provider<AsyncValue<List<ArtistProfile>>>((ref) {
  return ref
      .watch(discoveryCatalogProvider)
      .whenData((catalog) => catalog.profiles);
});

final allArtistSummariesProvider = Provider<AsyncValue<List<ArtistSummary>>>((
  ref,
) {
  return ref
      .watch(discoveryCatalogProvider)
      .whenData((catalog) => catalog.artistSummaries);
});

final featuredArtistsProvider = Provider<AsyncValue<List<ArtistSummary>>>((
  ref,
) {
  return ref
      .watch(discoveryCatalogProvider)
      .whenData((catalog) => catalog.featuredArtists);
});

final popularPackagesProvider = Provider<AsyncValue<List<ArtistPackage>>>((
  ref,
) {
  return ref
      .watch(discoveryCatalogProvider)
      .whenData((catalog) => catalog.popularPackages);
});

final filteredArtistsProvider = Provider<AsyncValue<List<ArtistSummary>>>((
  ref,
) {
  final catalogAsync = ref.watch(discoveryCatalogProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final selectedOccasion = ref.watch(selectedOccasionProvider);

  return catalogAsync.whenData((catalog) {
    return catalog.profiles
        .where((profile) {
          final summary = profile.summary;
          final matchesOccasion =
              selectedOccasion == null ||
              summary.specialties.contains(selectedOccasion) ||
              profile.packages.any(
                (artistPackage) =>
                    artistPackage.suitableFor.contains(selectedOccasion),
              );

          if (!matchesOccasion) {
            return false;
          }

          if (query.isEmpty) {
            return true;
          }

          final haystack = <String>[
            summary.name,
            summary.locationLabel,
            summary.heroLabel,
            ...summary.specialties,
            ...profile.packages.map((artistPackage) => artistPackage.title),
            ...profile.packages.expand(
              (artistPackage) => artistPackage.suitableFor,
            ),
          ].join(' ').toLowerCase();

          return haystack.contains(query);
        })
        .map((profile) => profile.summary)
        .toList(growable: false);
  });
});

final artistProfileProvider =
    Provider.family<AsyncValue<ArtistProfile?>, String>((ref, artistId) {
      return ref
          .watch(discoveryCatalogProvider)
          .whenData((catalog) => catalog.profileById(artistId));
    });

final artistProfileSnapshotProvider = Provider.family<ArtistProfile?, String>((
  ref,
  artistId,
) {
  return ref.watch(discoveryCatalogSnapshotProvider).profileById(artistId);
});
