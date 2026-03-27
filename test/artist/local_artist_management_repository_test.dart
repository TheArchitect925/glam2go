import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/artist_management/data/local_artist_management_storage.dart';
import 'package:glam2go/features/artist_management/data/repositories/local_artist_management_repository.dart';
import 'package:glam2go/features/artist_management/domain/models/artist_management_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('local artist management repository persists draft changes', () async {
    final repository = LocalArtistManagementRepository(
      const LocalArtistManagementStorage(),
    );

    final loadResult = await repository.loadState();
    final initial = loadResult.dataOrNull!;
    final updated = initial.copyWith(
      onboardingStep: ArtistOnboardingStep.profile,
      travelPolicy: initial.travelPolicy.copyWith(
        primaryServiceArea: 'North York',
      ),
    );

    await repository.saveState(updated);
    final restored = await repository.loadState();

    expect(restored.dataOrNull?.onboardingStep, ArtistOnboardingStep.profile);
    expect(restored.dataOrNull?.travelPolicy.primaryServiceArea, 'North York');
  });
}
