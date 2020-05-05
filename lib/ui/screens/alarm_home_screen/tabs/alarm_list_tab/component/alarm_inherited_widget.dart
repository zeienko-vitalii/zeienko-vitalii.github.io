import 'package:flutter/material.dart';
import 'package:minimal_alarm/ui/screens/alarm_home_screen/tabs/alarm_list_tab/controller/alarm_list.dart';

class AlarmInheritedWidget extends InheritedWidget {
  const AlarmInheritedWidget({
    Key key,
    @required this.alarmList,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final AlarmList alarmList;

  static AlarmInheritedWidget of(BuildContext context) => context.findAncestorWidgetOfExactType();

  @override
  bool updateShouldNotify(AlarmInheritedWidget oldWidget) => alarmList != oldWidget.alarmList;
}
