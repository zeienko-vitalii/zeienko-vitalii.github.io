import 'package:flutter/material.dart';

enum ThemeKeys { LIGHT, DARK }

class AppThemes {
  static final Map<ThemeKeys, ThemeData> _alarmThemes = <ThemeKeys, ThemeData>{
    ThemeKeys.LIGHT: ThemeData(
      primaryColor: Colors.blue,
      brightness: Brightness.light,
    ),
    ThemeKeys.DARK: ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
    ),
  };

  ThemeData getTheme(ThemeKeys key) {
    return _alarmThemes[key];
  }
}
