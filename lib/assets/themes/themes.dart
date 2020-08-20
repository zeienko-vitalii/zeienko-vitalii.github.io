import 'package:cv_profile/assets/themes/app_colors.dart';
import 'package:flutter/material.dart';

enum ThemeKeys { light, dark }

class AppThemes {
  static final Map<ThemeKeys, ThemeData> _themes = <ThemeKeys, ThemeData>{
    ThemeKeys.light: ThemeData(
      primaryColor: AppColors.color1,
      brightness: Brightness.light,
    ),
    ThemeKeys.dark: ThemeData(
      primaryColor: const Color(0xFF0A0A0A),
//      primaryColor: AppColors.color2,
      brightness: Brightness.dark,
    ),
  };

  ThemeData getTheme(ThemeKeys key) => _themes[key];
}
