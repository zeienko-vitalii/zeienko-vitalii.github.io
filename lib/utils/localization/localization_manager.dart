import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_alarm/utils/constants/constants.dart';

class LocalizationManager {
  LocalizationManager(this.locale);

  final Locale locale;
  final Map<String, String> _sentences = <String, String>{};

  static LocalizationManager of(BuildContext context) {
    return Localizations.of<LocalizationManager>(context, LocalizationManager);
  }

  Future<bool> load() async {
    final String data = await rootBundle.loadString(
      PATH_TO_LOCALIZATION_FILE + '${locale.languageCode}.json',
    );
    final Map<String, dynamic> _result = json.decode(data);

    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String operator [](String key) =>
      _sentences[key] ?? '';
}
