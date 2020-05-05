import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/data/repository/sembast/alarm_repository/alarm_repository.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/background/alarm_bckrd_mirror.dart';
import 'package:minimal_alarm/ui/screens/alarm_home_screen/tabs/alarm_list_tab/controller/alarm_list.dart';

class AlarmSettingsWidget extends StatefulWidget {
  const AlarmSettingsWidget({Key key}) : super(key: key);

  @override
  _AlarmSettingsWidgetState createState() => _AlarmSettingsWidgetState();
}

class _AlarmSettingsWidgetState extends State<AlarmSettingsWidget> {
  final AlarmList _alarmList = AlarmList(AlarmRepository());

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AlarmBackgroundMirrorCustomPainter(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _alarmList.deleteAlarms();
              },
              color: Colors.redAccent.withOpacity(0.7),
              child: Container(
                height: ScreenUtil().setHeight(24),
                child: const Text('DELETE ALL'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
