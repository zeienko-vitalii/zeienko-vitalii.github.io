import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_alarm_card.dart';

class CreateAlarmWidget extends StatefulWidget {
  const CreateAlarmWidget({Key key, this.onAddPressed}) : super(key: key);

  final Function(int, int, Map<int, bool>) onAddPressed;

  @override
  _CreateAlarmWidgetState createState() => _CreateAlarmWidgetState();
}

class _CreateAlarmWidgetState extends State<CreateAlarmWidget> {
  bool _isAddAlarmDragging = false;
  double _translationY = 0, _dragPositionDy = 0;
  static const int topPaddingConst = 150;
  final double _maximumCardHeight = ScreenUtil.screenHeightDp - topPaddingConst;

  @override
  Widget build(BuildContext context) {
    return _createAlarmWidget();
  }

  GestureDetector _createAlarmWidget() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: _maximumCardHeight,
          transform: Matrix4.translationValues(0, _translationY, 0),
          child: CreateAlarmCardWidget(
            onVerticalDragStart: (DragStartDetails details) {
              if (!_isAddAlarmDragging) {
                setState(() => _isAddAlarmDragging = true);
              }
            },
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: (DragEndDetails details) => _onVerticalEnd(context, details),
            onAddPressed: (int min, int hour, Map<int, bool> occurrence) {},
          ),
        ),
      ),
    );
  }

  void _onVerticalEnd(BuildContext context, DragEndDetails details) {
    if (_dragPositionDy >= ScreenUtil.screenHeightDp / 2) {
      setState(() => _translationY = 0);
    } else if (_isAddAlarmDragging) {
      Navigator.pop(context);
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _dragPositionDy = details.globalPosition.dy;
    if (_isAddAlarmDragging && details.globalPosition.dy <= 130) {
      setState(() => _translationY = 0);
    } else if (_isAddAlarmDragging && _translationY <= _maximumCardHeight) {
      setState(() => _translationY = details.globalPosition.dy - topPaddingConst);
    }
  }
}
