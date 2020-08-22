import 'dart:async';

import 'package:flutter/material.dart';

import 'localization_manager.dart';

class LocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization localizations = AppLocalization(
      _getCurrentLocale(locale),
    );
    await localizations.load();
    return localizations;
  }

  Locale _getCurrentLocale(Locale locale) => const Locale('en', '');

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
