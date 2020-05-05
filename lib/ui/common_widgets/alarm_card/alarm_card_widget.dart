import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/data/models/alarm_model.dart';
import 'package:minimal_alarm/utils/localization/localization_manager.dart';
import 'package:minimal_alarm/utils/time_utility/time_utility.dart';
import 'package:minimal_alarm/utils/time_utility/weekday_utility.dart';

class AlarmCardWidget extends StatefulWidget {
  const AlarmCardWidget({Key key, @required this.alarmEntity}) : super(key: key);

  final AlarmModel alarmEntity;

  @override
  _AlarmCardWidgetState createState() => _AlarmCardWidgetState();
}

class _AlarmCardWidgetState extends State<AlarmCardWidget> {
  double _opacity = 0.0;

  LocalizationManager get loc => LocalizationManager.of(context);

  AlarmModel get alarmEntity => widget.alarmEntity;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 200), () => setState(() => _opacity = 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1200),
      child: _glowCard(widget.alarmEntity.isOn),
    );
  }

  Widget _glowCard(bool isGlowing) {
    final DateTime now = DateTime.now();
    final DateTime alarmTime =
        DateTime(now.year, now.month, now.day, alarmEntity.alarmTime.hour, alarmEntity.alarmTime.minute);
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
      width: ScreenUtil().setWidth(220),
      child: Container(
        decoration: isGlowing ? _boxDecorationGlowing() : _boxDecorationNotGlowing(),
        child: Stack(
          children: <Widget>[
            _dayAmPm(TimeUtility.format(
              alarmTime,
              pattern: TimeUtility.AM_PM_MARKER_PATTERN,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: _scheduleDates()),
                Expanded(
                  child: _alarmTime(
                    TimeUtility.format(
                      alarmTime,
                      pattern: TimeUtility.ZERO_PAD_24HOUR_MIN_PATTERN,
                    ),
                  ),
                ),
                Expanded(
                  child: _notesWidget(alarmEntity.note),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dayAmPm(String moon) {
    return Positioned.fill(
      child: Container(
        padding: EdgeInsets.zero,
        child: FittedBox(
          child: Text(
            moon,
            style: TextStyle(
              color: const Color(0x5080c3ff),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _scheduleDates() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: !(alarmEntity.isOn ?? false)
            ? <Widget>[
                const Text('Off'),
              ]
            : <Widget>[
                const Spacer(),
                _alarmDaysOn(),
                const Spacer(),
              ],
      ),
    );
  }

  BoxDecoration _boxDecorationGlowing() {
    return BoxDecoration(
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x502C7BFA),
          blurRadius: 25,
          offset: Offset(10, 10),
        )
      ],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(55)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[
          Color(0xFF2CD5DF),
          Color(0xFF1F5FFF),
        ],
      ),
    );
  }

  BoxDecoration _boxDecorationNotGlowing() {
    return BoxDecoration(
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x402d3c54),
          blurRadius: 30,
          offset: Offset(10, 10),
        )
      ],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(55)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[
          Color(0xFF2F3959),
          Color(0xFF191C2B),
        ],
      ),
    );
  }

  Widget _alarmTime(String time) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
        child: Text(time),
      ),
    );
  }

  Widget _notesWidget(String notes) {
    return Container(
      child: Text(
        notes ?? '',
        style: TextStyle(
          fontSize: textSize_28,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _alarmDaysOn() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: alarmEntity.occurrenceDaysMap.keys.map(
        (String dayStr) {
          final int day = int.parse(dayStr);
          return _dayItem(
            loc[WeekdayUtility.getWeekdayKeyByIndex(day)].substring(0, 1).toUpperCase(),
            alarmEntity.occurrenceDaysMap[dayStr],
          );
        },
      ).toList(),
    );
  }

  Widget _dayItem(String day, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            day ?? '',
            style: TextStyle(
              fontSize: textSize_23,
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(12),
            height: ScreenUtil().setHeight(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ?? false ? Colors.lightGreenAccent : Colors.blueGrey[400],
            ),
          ),
        ],
      ),
    );
  }
}
