import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_alarm/ui/common_widgets/custom_painters/clock/timer_icon_painter.dart';
import 'package:minimal_alarm/utils/ui_utilities/custom_painter_helper.dart';

class TimerIndicator extends CustomPainter {
  TimerIndicator(
    this._timerValue, {
    this.shouldChangeColor,
    this.pointerOffsetCallback,
    this.totalValues = 60,
  })  : timerValuePaint = Paint(),
        timerValuePointPaint = Paint(),
        timerValueStablePointPaint = Paint(),
        backgroundLinePaint = Paint(),
        timerIconPath = Path() {
    timerValuePaint
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    timerValuePointPaint
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;
    timerValueStablePointPaint
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;
    backgroundLinePaint
      ..color = Colors.grey[300]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    if (shouldChangeColor != null && shouldChangeColor) {
      timerValuePointPaint.color = Colors.white;
      backgroundLinePaint.color = Colors.orangeAccent;
    }
  }

  final double totalValues, _timerValue;
  final Paint timerValuePaint, timerValuePointPaint, timerValueStablePointPaint, backgroundLinePaint;
  final Path timerIconPath;
  final Function(Offset) pointerOffsetCallback;
  final bool shouldChangeColor;

  /// Angle of the 24 hours
  static const double _START_ANGLE = 3.5;

  /// TIMER_VALUE_ANGLE_MAX is the max angle of the [_timerValue]
  static const double TIMER_VALUE_ANGLE_MAX = 2.0, POINTER_RADIUS = 12, POINTER_SHIFT = 4.72;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double actualCurrentValue = _timerValue * TIMER_VALUE_ANGLE_MAX / totalValues;

    _backgroundLine(canvas, center, radius);
    _currentValueIndicator(canvas, center, radius, actualCurrentValue);
    _pointer(canvas, radius, actualCurrentValue, center);

    const double offsetOfIconWidth = 6.9, offsetOfIconHeight = 7.9;
    canvas.save();
    final Offset iconCenter = CustomPainterHelper.pointOnTheArcFromRAXY(radius, pi * _START_ANGLE, center);
    canvas.translate(iconCenter.dx - offsetOfIconWidth, iconCenter.dy - offsetOfIconHeight);
    TimerIconPainter(
      iconSize: POINTER_RADIUS * 1.2,
    ).paint(canvas, size);
    canvas.restore();
  }

  void _pointer(Canvas canvas, double radius, double actualCurrentValue, Offset center) {
    final double angleOfPos = pi * actualCurrentValue + POINTER_SHIFT;
    final Offset pointCenter = CustomPainterHelper.pointOnTheArcFromRAXY(radius, angleOfPos, center);
    pointerOffsetCallback(pointCenter);
    canvas.drawCircle(
      pointCenter,
      POINTER_RADIUS,
      timerValuePointPaint,
    );
  }

  void _currentValueIndicator(Canvas canvas, Offset center, double radius, double actualCurrentValue) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * _START_ANGLE,
      pi * actualCurrentValue,
      false,
      timerValuePaint,
    );
  }

  void _backgroundLine(Canvas canvas, Offset center, double radius) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * _START_ANGLE,
      pi * TIMER_VALUE_ANGLE_MAX,
      false,
      backgroundLinePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
