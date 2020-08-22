part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends BaseEvent {
  const HomeEvent();
}

class ScrollNotificationEvent extends HomeEvent {
  const ScrollNotificationEvent(this.scroll);

  final ScrollNotification scroll;
}
