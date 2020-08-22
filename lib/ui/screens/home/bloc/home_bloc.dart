import 'dart:async';

import 'package:cv_profile/ui/screens/base/bloc/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState());

  @override
  Stream<BaseBlocState> mapChildEventToState(BaseEvent event) async* {
    if (event is ScrollNotificationEvent) {
      yield ScrollNotificationState(event.scroll);
    }
  }
}
