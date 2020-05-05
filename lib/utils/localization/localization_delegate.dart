import 'dart:async';

import 'package:flutter/material.dart';

import 'localization_manager.dart';

class LocalizationDelegate extends LocalizationsDelegate<LocalizationManager> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<LocalizationManager> load(Locale locale) async {
    final LocalizationManager localizations = LocalizationManager(
      _getCurrentLocale(locale),
    );
    await localizations.load();
    return localizations;
  }

  Locale _getCurrentLocale(Locale locale) => const Locale('en', '');

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
