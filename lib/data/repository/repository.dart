import 'package:minimal_alarm/data/models/alarm_model.dart';

abstract class Repository {
  Future<dynamic> addAlarm(AlarmModel alarmModel);

  Future<dynamic> deleteAlarm([int key]);

  Future<dynamic> updateAlarm(int key, AlarmModel alarmModel);

  Future<Map<int, AlarmModel>> getAlarms();
}
