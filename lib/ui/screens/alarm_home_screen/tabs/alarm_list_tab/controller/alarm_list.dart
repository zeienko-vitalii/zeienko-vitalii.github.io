import 'package:minimal_alarm/data/models/alarm_model.dart';
import 'package:minimal_alarm/data/repository/repository.dart';
import 'package:mobx/mobx.dart';

part 'alarm_list.g.dart';

class AlarmList = AlarmListBase with _$AlarmList;

abstract class AlarmListBase with Store {
  AlarmListBase(this._repository) : assert(_repository != null);

  final Repository _repository;

  @observable
  Map<int, AlarmModel> alarms = <int, AlarmModel>{};

  @action
  void loadAlarms() {
    try {
      _repository.getAlarms().then((Map<int, AlarmModel> alarms) {
        _updateAlarmList(alarms);
      }).catchError((Object error) {
        _updateAlarmList(null);
      });
    } catch (e) {
      print(e);
    }
  }

  @action
  void deleteAlarms() {
    try {
      _repository.deleteAlarm().then((dynamic key) {
        alarms.clear();
      });
    } catch (e) {
      print(e);
    }
  }

  @action
  void addAlarm(AlarmModel alarmModel) {
    try {
      _repository.addAlarm(alarmModel).then((dynamic key) {
        print('AddAlarm Key: $key');
        alarms[key] = alarmModel;
        _updateAlarmList(Map<int, AlarmModel>.from(alarms));
      });
    } catch (e) {
      print(e);
    }
  }

  @action
  void updateAlarms() {
    throw UnimplementedError();
  }

  void _updateAlarmList(Map<int, AlarmModel> newAlarms) {
    alarms.clear();
    if (newAlarms == null) {
      return;
    }
    alarms = Map<int, AlarmModel>.from(newAlarms);
//    alarms.addAll(newAlarms);
  }
}
