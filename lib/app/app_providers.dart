import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/artist_management/application/artist_management_providers.dart';
import '../features/session/application/session_providers.dart';
import 'app_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final session = ref.watch(sessionControllerProvider);
  final artistReadiness = ref.watch(artistReadinessProvider);
  return buildAppRouter(
    session,
    artistReadinessProgress: artistReadiness.progress,
  );
});
