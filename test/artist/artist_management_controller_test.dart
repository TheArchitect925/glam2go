import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/artist_management/application/artist_management_providers.dart';
import 'package:glam2go/features/artist_management/domain/models/artist_management_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'artist management controller updates readiness-critical setup state',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(
        artistManagementControllerProvider.notifier,
      );

      await controller.toggleSpecialty('Party Glam');
      await controller.savePackage(
        const ArtistServicePackageDraft(
          id: 'artist-new-package',
          title: 'Elevated Event Glam',
          description: 'Long-wear glam for formal evenings.',
          price: 210,
          durationMinutes: 90,
          includes: ['Lashes', 'Skin prep'],
          suitableOccasions: ['Formal Event'],
          isActive: true,
        ),
      );
      await controller.toggleAvailability('sun');

      final state = container.read(artistManagementControllerProvider);
      final readiness = container.read(artistReadinessProvider);

      expect(
        state.profileDraft.specialties.any(
          (specialty) =>
              specialty.label == 'Party Glam' && specialty.isSelected,
        ),
        true,
      );
      expect(readiness.completedCount, greaterThan(0));
    },
  );

  test('artist management controller saves portfolio metadata', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(
      artistManagementControllerProvider.notifier,
    );

    final result = await controller.savePortfolioItem(
      title: 'Refined reception glam',
      category: 'Reception',
      caption: 'Soft neutral glam with long-wear skin finish.',
    );

    expect(result.dataOrNull, isNotNull);
    final items = container.read(
      artistManagementControllerProvider.select(
        (state) => state.profileDraft.portfolioItems,
      ),
    );
    expect(items.first.title, 'Refined reception glam');
  });
}
