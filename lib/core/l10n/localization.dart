import 'package:flutter/widgets.dart';
import 'package:glam2go/l10n/app_localizations.dart';

export 'package:glam2go/l10n/app_localizations.dart';

class AppLocalizationSetup {
  const AppLocalizationSetup._();

  static final delegates = AppLocalizations.localizationsDelegates;
  static final supportedLocales = AppLocalizations.supportedLocales;
}

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
