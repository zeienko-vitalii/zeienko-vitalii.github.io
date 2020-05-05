import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/ui/common_widgets/common_widgets.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/background/alarm_create_bckrd.dart';
import 'package:minimal_alarm/ui/common_widgets/toggle_button/toggle_week_widget.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateAlarmCardWidget extends StatefulWidget {
  const CreateAlarmCardWidget({
    Key key,
    @required this.onAddPressed,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
  }) : super(key: key);

  final Function(int, int, Map<int, bool>) onAddPressed;
  final Function(DragStartDetails details) onVerticalDragStart;
  final Function(DragUpdateDetails details) onVerticalDragUpdate;
  final Function(DragEndDetails details) onVerticalDragEnd;

  @override
  _CreateAlarmCardWidgetState createState() => _CreateAlarmCardWidgetState();
}

class _CreateAlarmCardWidgetState extends State<CreateAlarmCardWidget> {
  final Map<int, bool> occurrenceDaysMap = Map<int, bool>.fromIterable(
    List<int>.generate(
      DateTime.daysPerWeek,
      (int index) => index,
    ),
    value: (dynamic item) => false,
  );
  int _initialValueH = 0, _initialValueMin = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.screenHeightDp - 150,
      child: Stack(
        children: <Widget>[
          _backgroundCard(),
          Column(
            children: <Widget>[
              GestureDetector(
                onVerticalDragStart: widget.onVerticalDragStart,
                onVerticalDragUpdate: widget.onVerticalDragUpdate,
                onVerticalDragEnd: widget.onVerticalDragEnd,
                child: const _CardHorizontalLine(),
              ),
              Expanded(child: _cardContent()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardContent() {
    return Container(
      height: ScreenUtil.screenHeightDp - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Spacer(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Spacer(),
                _selectTime(
                  initialVal: _initialValueH,
                  max: 24,
                  onChanged: (num val) => setState(() => _initialValueH = val),
                ),
                const Spacer(),
                _selectTime(
                  initialVal: _initialValueMin,
                  max: 59,
                  onChanged: (num val) => setState(() => _initialValueMin = val),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(child: _selectWeek()),
          _plusIcon(),
        ],
      ),
    );
  }

  Container _backgroundCard() {
    return Container(
      width: ScreenUtil.screenWidthDp,
      height: ScreenUtil.screenHeightDp - 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: CustomPaint(painter: AlarmCreateBackgroundCustomPainter()),
    );
  }

  Widget _plusIcon() {
    return Container(
      width: ScreenUtil().setWidth(94),
      height: ScreenUtil().setHeight(94),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(14),
      ),
      child: plusButton(
        onPressed: _createNewAlarm,
        colors: const <Color>[Color(0xFFa8ff78), Color(0xFF78ffd6)],
      ),
    );
  }

  Widget _selectTime({int initialVal, int min = 0, int max, Function(num) onChanged}) {
    final ThemeData theme = Theme.of(context);
    final TextStyle body = theme.textTheme.bodyText2.copyWith(color: Colors.white);
    final TextTheme textTheme =
        theme.textTheme.copyWith(bodyText2: body, headline5: body.copyWith(fontSize: textSize_44));
    return Theme(
      data: theme.copyWith(textTheme: textTheme, accentColor: Colors.orangeAccent),
      child: NumberPicker.integer(
        initialValue: initialVal,
        minValue: min,
        maxValue: max,
        zeroPad: true,
        highlightSelectedValue: true,
        infiniteLoop: true,
        onChanged: onChanged,
      ),
    );
  }

  Widget _selectWeek() {
    return ToggleWeekWidget(
      onWeekDayPressed: (int day) {
        _updateOccurrenceDay(day);
        print('Week Day: ${WeekDays.values[day]}');
      },
    );
  }

  void _updateOccurrenceDay(int day) {
    if (occurrenceDaysMap[day] == null) {
      occurrenceDaysMap[day] = true;
    } else {
      occurrenceDaysMap[day] = !occurrenceDaysMap[day];
    }
  }

  void _createNewAlarm() {
    widget.onAddPressed(_initialValueMin, _initialValueH, occurrenceDaysMap);
  }
}

/// Floating horizontal line
class _CardHorizontalLine extends StatefulWidget {
  const _CardHorizontalLine({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardHorizontalLineState();
}

class _CardHorizontalLineState extends State<_CardHorizontalLine> {
  bool _isRestart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _isRestart = !_isRestart));
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 20,
        child: Center(
          child: AnimatedPadding(
            padding: EdgeInsets.only(top: _isRestart ? 10 : 6),
            duration: const Duration(seconds: 1),
            onEnd: () => setState(() => _isRestart = !_isRestart),
            child: Container(
              height: 8,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF20BBF0),
                gradient: const LinearGradient(
                  transform: GradientRotation(10),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFFa8ff78),
                    Color(0xFF78ffd6),
                  ],
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.lightGreenAccent[700].withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
