import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import 'app_api_client.dart';
import 'http_app_api_client.dart';

final appApiClientProvider = Provider<AppApiClient>((ref) {
  return HttpAppApiClient(ref.watch(appConfigProvider));
});
