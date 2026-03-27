enum AppEnvironment { development, staging, production }

extension AppEnvironmentX on AppEnvironment {
  String get nameLabel => switch (this) {
    AppEnvironment.development => 'development',
    AppEnvironment.staging => 'staging',
    AppEnvironment.production => 'production',
  };

  bool get isProduction => this == AppEnvironment.production;
}
