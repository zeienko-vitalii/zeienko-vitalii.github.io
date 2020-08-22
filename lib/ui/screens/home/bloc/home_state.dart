part of 'home_bloc.dart';

@immutable
abstract class HomeState extends BaseBlocState {
  const HomeState();
}

class InitialHomeState extends HomeState {}

class ScrollNotificationState extends HomeState {
  const ScrollNotificationState(this.scroll);

  final ScrollNotification scroll;
}
