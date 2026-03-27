import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/session/data/local_session_storage.dart';
import 'package:glam2go/features/session/data/repositories/local_session_repository.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'local session repository persists and restores authenticated state',
    () async {
      final repository = LocalSessionRepository(const LocalSessionStorage());
      const session = SessionState.authenticated(
        userMode: AppUserMode.customer,
        userSummary: SessionUserSummary(
          userId: 'customer-sana-malik',
          displayName: 'Sana Malik',
          email: 'sana.malik@example.com',
          mode: AppUserMode.customer,
          isNewAccount: false,
        ),
      );

      await repository.saveSession(session);
      final restored = await repository.loadSession();

      expect(restored.dataOrNull?.isCustomer, isTrue);
      expect(restored.dataOrNull?.userSummary?.displayName, 'Sana Malik');
    },
  );
}
