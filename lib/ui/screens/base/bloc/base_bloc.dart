import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cv_profile/assets/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';

part 'base_state.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseBlocState> extends Bloc<BaseEvent, BaseBlocState> {
  BaseBloc(BaseBlocState state) : super(state);

  final AppThemes _appThemes = AppThemes();

  ThemeKeys selectedThemeKey = ThemeKeys.dark;

  ThemeData get themeDataState => _appThemes.getTheme(selectedThemeKey);

  @override
  Stream<BaseBlocState> mapEventToState(BaseEvent event) async* {
    if (event is UpdateThemeEvent) {
      selectedThemeKey = event.themeKey;
      yield UpdateThemeState(_appThemes.getTheme(selectedThemeKey));
    } else {
      yield* mapChildEventToState(event);
    }
  }

  Stream<BaseBlocState> mapChildEventToState(BaseEvent event);
}
