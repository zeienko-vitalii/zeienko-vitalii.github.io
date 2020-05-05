// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlarmList on AlarmListBase, Store {
  final _$alarmsAtom = Atom(name: 'AlarmListBase.alarms');

  @override
  Map<int, AlarmModel> get alarms {
    _$alarmsAtom.context.enforceReadPolicy(_$alarmsAtom);
    _$alarmsAtom.reportObserved();
    return super.alarms;
  }

  @override
  set alarms(Map<int, AlarmModel> value) {
    _$alarmsAtom.context.conditionallyRunInAction(() {
      super.alarms = value;
      _$alarmsAtom.reportChanged();
    }, _$alarmsAtom, name: '${_$alarmsAtom.name}_set');
  }

  final _$AlarmListBaseActionController =
      ActionController(name: 'AlarmListBase');

  @override
  void loadAlarms() {
    final _$actionInfo = _$AlarmListBaseActionController.startAction();
    try {
      return super.loadAlarms();
    } finally {
      _$AlarmListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAlarms() {
    final _$actionInfo = _$AlarmListBaseActionController.startAction();
    try {
      return super.deleteAlarms();
    } finally {
      _$AlarmListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAlarm(AlarmModel alarmModel) {
    final _$actionInfo = _$AlarmListBaseActionController.startAction();
    try {
      return super.addAlarm(alarmModel);
    } finally {
      _$AlarmListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAlarms() {
    final _$actionInfo = _$AlarmListBaseActionController.startAction();
    try {
      return super.updateAlarms();
    } finally {
      _$AlarmListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'alarms: ${alarms.toString()}';
    return '{$string}';
  }
}
