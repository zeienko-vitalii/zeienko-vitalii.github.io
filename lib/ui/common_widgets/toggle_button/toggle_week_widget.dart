import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/ui/common_widgets/toggle_button/toggle_button_widget.dart';

class ToggleWeekWidget extends StatefulWidget {
  const ToggleWeekWidget({Key key, this.onWeekDayPressed}) : super(key: key);
  final Function(int) onWeekDayPressed;

  @override
  _ToggleWeekWidgetState createState() => _ToggleWeekWidgetState();
}

class _ToggleWeekWidgetState extends State<ToggleWeekWidget> {
  static final double buttonSize = ScreenUtil().setWidth(42);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _createToggleButton(),
    );
  }

  List<Widget> _createToggleButton() => List<Widget>.generate(
        DateTime.daysPerWeek,
        (int index) => Container(
          width: buttonSize,
          height: buttonSize,
          child: ToggleButtonWidget(
            onItemPressed: (dynamic day) => widget.onWeekDayPressed(day),
            item: index,
            title: describeEnum(WeekDays.values[index]).substring(0, 1).toUpperCase(),
          ),
        ),
      );
}

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
