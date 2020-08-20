part of 'base_bloc.dart';

@immutable
abstract class BaseBlocState {}

class InitialBaseState extends BaseBlocState {}

class UpdateThemeState extends BaseBlocState {
  UpdateThemeState(this.theme);

  final ThemeData theme;
}
