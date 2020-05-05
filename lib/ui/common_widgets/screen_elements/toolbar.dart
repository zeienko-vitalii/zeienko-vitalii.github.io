import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/ui/common_widgets/icons/alarm_icon.dart';
import 'package:minimal_alarm/ui/common_widgets/icons/settings_icon.dart';

import 'bouncing_button.dart';

class ToolbarWidget extends StatefulWidget {
  @override
  _ToolbarWidgetState createState() => _ToolbarWidgetState();
}

class _ToolbarWidgetState extends State<ToolbarWidget> with SingleTickerProviderStateMixin {
  double iconSize = 24;
  bool _isAlarmSelected = true;

  @override
  Widget build(BuildContext context) {
    iconSize = 64 * 12 / 13;
    return Container(
      height: ScreenUtil().setHeight(toolbarHeight),
      width: ScreenUtil().scaleWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          BouncingButton(
            Container(
              width: ScreenUtil().setWidth(iconSize),
              height: ScreenUtil().setHeight(iconSize),
              child: _alarmIcon(),
            ),
            onDismiss: () => setState(() {
              _isAlarmSelected = true;
            }),
          ),
          BouncingButton(
            Container(
              width: ScreenUtil().setWidth(iconSize),
              height: ScreenUtil().setHeight(iconSize),
              child: _settingsIcon(),
            ),
            onDismiss: () => setState(() {
              _isAlarmSelected = false;
            }),
          ),
        ],
      ),
    );
  }

  Widget _alarmIcon() => CustomPaint(
        painter: AlarmIcon(isActive: _isAlarmSelected),
      );

  Widget _settingsIcon() => CustomPaint(
        painter: SettingsIcon(isActive: !_isAlarmSelected),
      );
}
