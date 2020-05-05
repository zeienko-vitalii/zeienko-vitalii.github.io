import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/clock/analog_clock_painter_with_matrix.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/progress/circular_progress.dart';
import 'package:minimal_alarm/utils/time_utility/time_utility.dart';

import 'bloc/clock.dart';

const double _OUT_CIRCLE_SIZE = 325,
    _INNER_CIRCLE_SIZE = _OUT_CIRCLE_SIZE * 0.8,
    _INNER_CIRCLE_TIME_SIZE = _OUT_CIRCLE_SIZE * 0.56,
    _INNER_CIRCLE_TIME_CENTER_SIZE = _OUT_CIRCLE_SIZE * 0.17;

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  final Clock _clock = Clock();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        ClockDecoration(),
        SizedBox(
          width: ScreenUtil().setWidth(_INNER_CIRCLE_TIME_SIZE),
          height: ScreenUtil().setHeight(_INNER_CIRCLE_TIME_SIZE),
          child: _clocks(),
        ),
      ],
    );
  }

  Widget _clocks() {
    return Observer(
      builder: (_) {
        final DateTime now = _clock.now;
        return CustomPaint(
          painter: CircularProgressCustomPaint(
            TimeUtility.MIN_IN_HOURS - now.second,
            totalDots: TimeUtility.MIN_IN_HOURS,
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(38.0)),
            child: CustomPaint(painter: AnalogClockPainterWithMatrix(now.millisecondsSinceEpoch)),
          ),
        );
      },
    );
  }
}

class ClockDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        _clockDecorationWidget(_OUT_CIRCLE_SIZE, _boxDecorationOuterCircle()),
        _clockDecorationWidget(_INNER_CIRCLE_SIZE, _boxDecorationInnerCircle()),
        _clockDecorationWidget(_INNER_CIRCLE_TIME_CENTER_SIZE, _boxDecorationOfCenterCircle()),
      ],
    );
  }

  Container _clockDecorationWidget(double size, Decoration decoration) {
    return Container(
      width: ScreenUtil().setWidth(size),
      height: ScreenUtil().setHeight(size),
      decoration: decoration,
    );
  }

  BoxDecoration _boxDecorationOuterCircle() {
    return BoxDecoration(
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x606D7695),
          blurRadius: 20,
          offset: Offset(2.0, -10.0),
        ),
        BoxShadow(
          color: Color(0xFF171A28),
          blurRadius: 20,
          offset: Offset(8.0, 15.0),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[Color(0xFF484F73), Color(0xFF161924)],
      ),
      shape: BoxShape.circle,
    );
  }

  BoxDecoration _boxDecorationInnerCircle() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[
          Color(0xFF1B212F),
          Color(0xFF323a54),
          Color(0xFF3f4969),
        ],
      ),
      shape: BoxShape.circle,
    );
  }

  BoxDecoration _boxDecorationOfCenterCircle() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[
          Color(0xFF3f4969),
          Color(0xFF323a54),
          Color(0xFF1B212F),
        ],
      ),
      shape: BoxShape.circle,
    );
  }
}
