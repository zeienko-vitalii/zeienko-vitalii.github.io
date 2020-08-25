import 'dart:async';
import 'dart:convert';

import 'package:cv_profile/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;
  final Map<String, String> _sentences = <String, String>{};

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
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

  String operator [](String key) => _sentences[key] ?? '';
}

extension LocalizationExt on BuildContext {
  AppLocalization get locale => AppLocalization.of(this);
}
