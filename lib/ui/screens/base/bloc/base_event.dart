part of 'base_bloc.dart';

@immutable
abstract class BaseEvent {
  const BaseEvent();
}

class UpdateThemeEvent extends BaseEvent {
  const UpdateThemeEvent(this.themeKey);

  final ThemeKeys themeKey;
}
