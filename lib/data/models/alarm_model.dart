import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType()
class AlarmModel {
  AlarmModel({
    this.alarmTime,
    this.occurrenceDaysMap = const <String, bool>{},
    this.note,
    this.isOn = true,
    this.soundTrackPath,
  });

  AlarmModel.fromJson(Map<String, dynamic> json)
      : soundTrackPath = json['soundTrackPath'],
        note = json['note'],
        alarmTime = AlarmTimeOfDay(hour: json['hour'], minute: json['minute']),
        isOn = json['isOn'],
        occurrenceDaysMap = Map<String, bool>.from(json['occurrenceDaysMap']);

  @HiveField(0)
  final String soundTrackPath;
  @HiveField(1)
  final String note;
  @HiveField(3)
  final AlarmTimeOfDay alarmTime;
  @HiveField(4)
  final bool isOn;
  @HiveField(5)
  final Map<String, bool> occurrenceDaysMap;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'soundTrackPath': soundTrackPath,
        'note': note,
        'hour': alarmTime.hour,
        'minute': alarmTime.minute,
        'isOn': isOn,
        'occurrenceDaysMap': occurrenceDaysMap,
      };

  @override
  String toString() => toJson().toString();
}

@HiveType()
class AlarmTimeOfDay {
  const AlarmTimeOfDay({@required this.hour, @required this.minute});

  @HiveField(0)
  final int hour;
  @HiveField(1)
  final int minute;

  @override
  String toString() => 'TimeOfDay{hour: $hour, minute: $minute}';
}

extension TimeOfDayExt on AlarmTimeOfDay {
  double toDouble() => hour + minute / 60.0;
}
