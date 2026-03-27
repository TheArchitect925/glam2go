import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/profile/data/local_account_storage.dart';
import 'package:glam2go/features/profile/data/repositories/local_account_repository.dart';
import 'package:glam2go/features/profile/domain/models/account_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('local account repository persists preferences and favorites', () async {
    final repository = LocalAccountRepository(const LocalAccountStorage());

    const preferences = UserPreferences(
      preferredArea: 'Downtown Toronto',
      preferredOccasions: ['Bridal'],
      communicationPreference: 'In-app updates first',
      notificationPreferences: NotificationPreferences(
        bookingUpdates: true,
        artistResponses: true,
        reminders: false,
        promotions: false,
      ),
    );

    await repository.savePreferences(preferences);
    await repository.saveFavoriteArtistIds({'aaliyah-noor'});

    final restoredPreferences = await repository.loadPreferences();
    final restoredFavorites = await repository.loadFavoriteArtistIds();

    expect(restoredPreferences.dataOrNull?.preferredArea, 'Downtown Toronto');
    expect(
      restoredPreferences.dataOrNull?.notificationPreferences.artistResponses,
      isTrue,
    );
    expect(restoredFavorites.dataOrNull, contains('aaliyah-noor'));
  });
}
