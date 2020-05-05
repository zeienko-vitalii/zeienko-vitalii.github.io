import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/assets/themes/themes.dart';

class ThemeBloc extends Bloc<ThemeKeys, ThemeData> {
  final AppThemes _appThemes = AppThemes();
  final ScreenUtil screenUtil = ScreenUtil();

  ThemeKeys _themeKey = ThemeKeys.DARK;

  ThemeKeys get themeKey => _themeKey;

  @override
  ThemeData get initialState => _appThemes.getTheme(_themeKey);

  @override
  Stream<ThemeData> mapEventToState(ThemeKeys event) async* {
    _themeKey = event;
    switch (_themeKey) {
      case ThemeKeys.LIGHT:
        yield _appThemes.getTheme(ThemeKeys.LIGHT);
        break;
      case ThemeKeys.DARK:
        yield _appThemes.getTheme(ThemeKeys.DARK);
        break;
    }
  }
}
