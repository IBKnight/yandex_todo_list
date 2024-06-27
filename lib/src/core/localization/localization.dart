import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'gen/app_localizations.dart';

final class Localization {
  static List<Locale> get supportedLocales => const [Locale('ru')];

  static const _delegate = AppLocalizations.delegate;

  static List<LocalizationsDelegate> get localizationDelegates => const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        _delegate,
      ];
}
