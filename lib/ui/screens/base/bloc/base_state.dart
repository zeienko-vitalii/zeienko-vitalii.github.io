part of 'base_bloc.dart';

@immutable
abstract class BaseBlocState {
  const BaseBlocState();
}

class InitialBaseState extends BaseBlocState {}

class UpdateThemeState extends BaseBlocState {
  const UpdateThemeState(this.theme);

  final ThemeData theme;
}
