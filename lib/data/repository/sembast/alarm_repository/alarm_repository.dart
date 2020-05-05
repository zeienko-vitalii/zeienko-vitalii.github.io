import 'package:hive/hive.dart';
import 'package:minimal_alarm/data/db/db_manager.dart';
import 'package:minimal_alarm/data/models/alarm_model.dart';
import 'package:minimal_alarm/data/repository/repository.dart';

class AlarmRepository implements Repository {
  factory AlarmRepository() {
    if (_instance == null) {
      throw Exception('Call init first');
    }
    return _instance;
  }

  AlarmRepository.init(DbManager manager) {
    _manager = manager;
    _instance = this;
  }

  static AlarmRepository _instance;
  static const String alarmsBoxName = 'alarmsBoxName';
  DbManager _manager;

  Future<Box<AlarmModel>> _getAlarmBox() {
    try {
      return _manager.getBox<AlarmModel>(alarmsBoxName);
    } catch (ex) {
      print('Error while openning a box($alarmsBoxName) $ex');
      return null;
    }
  }

  @override
  Future<int> addAlarm(AlarmModel alarmModel) async => (await _getAlarmBox())?.add(alarmModel);

  @override
  Future<dynamic> deleteAlarm([int key]) async => (await _getAlarmBox())?.delete(key);

  @override
  Future<Map<int, AlarmModel>> getAlarms() async => (await _getAlarmBox())?.toMap();

  @override
  Future<dynamic> updateAlarm(int key, AlarmModel alarmModel) async => (await _getAlarmBox())?.put(key, alarmModel);
}
