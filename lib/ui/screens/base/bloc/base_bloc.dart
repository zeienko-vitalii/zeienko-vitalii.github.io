import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';

part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState => InitialBaseState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
  }
}
