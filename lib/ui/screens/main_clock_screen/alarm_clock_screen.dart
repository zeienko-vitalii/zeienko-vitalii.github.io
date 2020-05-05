import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_alarm/utils/ui_utilities/screen_utils.dart';

import 'widget/alarm_clock_widget.dart';

class AlarmClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[SystemUiOverlay.bottom]);
    initScreenUtil(context);
    return AlarmClock();
  }
}
