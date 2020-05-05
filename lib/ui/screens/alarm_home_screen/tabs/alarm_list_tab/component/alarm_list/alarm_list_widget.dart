import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/data/db/db_manager.dart';
import 'package:minimal_alarm/data/models/alarm_model.dart';
import 'package:minimal_alarm/data/repository/sembast/alarm_repository/alarm_repository.dart';
import 'package:minimal_alarm/ui/common_widgets/alarm_card/alarm_card_widget.dart';
import 'package:minimal_alarm/ui/common_widgets/common_widgets.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/background/alarm_bckrd.dart';
import 'package:minimal_alarm/ui/screens/alarm_home_screen/tabs/alarm_list_tab/component/create_alarm/create_alarm_dialog.dart';
import 'package:minimal_alarm/ui/screens/alarm_home_screen/tabs/alarm_list_tab/controller/alarm_list.dart';

import '../alarm_inherited_widget.dart';

class AlarmListWidget extends StatefulWidget {
  const AlarmListWidget({Key key}) : super(key: key);

  @override
  _AlarmListWidgetState createState() => _AlarmListWidgetState();
}

class _AlarmListWidgetState extends State<AlarmListWidget> {
  AlarmList _alarmList;

  @override
  void initState() {
    super.initState();
    _alarmList = AlarmList(AlarmRepository.init(DbManager()));
    _alarmList.loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlarmInheritedWidget(
        alarmList: _alarmList,
        child: CustomPaint(
          painter: AlarmBackgroundCustomPainter(),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _alarmMessageObserver(),
                  Expanded(child: _alarmsContent()),
                  Container(
                    child: plusButton(
                      onPressed: () async {
                        final dynamic value = await Navigator.of(context).push<dynamic>(CreateAlarmDialog());
                        print(value);
                      },
                    ),
                  ),
                  indent(bottom: 50),
                ],
              ),
              /*
              final AlarmModel alarmModel = AlarmModel(
                alarmTime: AlarmTimeOfDay(hour: min, minute: hour),
                occurrenceDaysMap:
                occurrence.map((int key, bool value) => MapEntry<String, bool>(key.toString(), value)),
              );
              print('Adding: $alarmModel');
              _alarmList.addAlarm(alarmModel);
              setState(() => _isAddingAlarm = false);
               */
            ],
          ),
        ),
      ),
    );
  }

  Observer _alarmMessageObserver() {
    return Observer(
      builder: (BuildContext context) {
        final List<AlarmModel> alarms = List<AlarmModel>.from(_alarmList.alarms.values);
        String msg;
        if (alarms.isNotEmpty) {
          alarms.sort(
            (AlarmModel obj1, AlarmModel obj2) => obj1.alarmTime.toDouble().compareTo(obj2.alarmTime?.toDouble()),
          );
          final AlarmModel model = alarms.first;
          final DateTime now = DateTime.now();
          final DateTime alarmTime =
              DateTime(now.year, now.month, now.day, model.alarmTime.hour, model.alarmTime.minute);
          final DateTime diff = DateTime.now()..difference(alarmTime);
          msg = '${diff.hour} hrs and ${diff.minute} mins left for alarm';
        }
        return _alarmMessage(msg);
      },
    );
  }

  Container _alarmMessage([String text]) {
    return Container(
      width: ScreenUtil().setWidth(170),
      height: ScreenUtil().setHeight(110),
      padding: const EdgeInsets.only(top: 21),
      child: Text(
        text ?? '',
        softWrap: true,
        style: GoogleFonts.notoSans(
          fontSize: textSize_22,
          color: Colors.white,
        ),
      ),
    );
  }

  Observer _alarmsContent() => Observer(
        builder: (BuildContext context) {
          return _alarmList.alarms.keys.isEmpty ? _noAlarmsMessage() : _alarmListWidget();
        },
      );

  ListView _alarmListWidget() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _alarmList.alarms.values.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              padding: const EdgeInsets.only(top: 70, bottom: 85, right: 21),
              child: AlarmCardWidget(alarmEntity: _alarmList.alarms.values.toList()[index]),
            ),
          );
        },
      );

  Center _noAlarmsMessage() {
    return Center(
      child: Text(
        'No alarms',
        style: GoogleFonts.lato(
          fontSize: textSize_30,
          color: const Color(0xFF039eff),
        ),
      ),
    );
  }
//
//  Future<bool> _onWillPop() async {
//    if (_isAddingAlarm) {
//      setState(() => _isAddingAlarm = false);
//      return false;
//    }
//    return true;
//  }
}
