part of 'base_bloc.dart';

@immutable
abstract class BaseEvent {}

class UpdateThemeEvent extends BaseEvent {
  UpdateThemeEvent(this.themeKey);

  final ThemeKeys themeKey;
}
