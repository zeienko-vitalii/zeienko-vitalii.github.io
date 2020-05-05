import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClockPainterWithAxis extends CustomPainter {
  AnalogClockPainterWithAxis(this._ms, this._seconds, this._minutes, this._hours);

  static const int _CLOCK_12_H_IN_MS = 43200000, _CLOCK_SEC_MS_IN_DAY = 60000;
  static const double _CLOCK_MIN_MS_IN_DAY = 3.6e+6, _CLOCK_ARROW_ANGLE_MAX_DEGREE = 360;

  final double _ms, _seconds, _minutes, _hours;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 3;
    final Offset center = Offset(size.width / 2, size.height / 2);
    _drawClockArrows(canvas, center, radius);
  }

  void _drawClockArrows(Canvas canvas, Offset center, double radius) {
    final Paint secondsLinePainter = Paint()
      ..color = const Color(0xFFE64C94)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final Paint minutesLinePainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final Paint hoursLinePainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    const double currentTimePartOfDayHours = _CLOCK_ARROW_ANGLE_MAX_DEGREE / _CLOCK_12_H_IN_MS;
    const double currentTimePartOfDaySec = _CLOCK_ARROW_ANGLE_MAX_DEGREE / _CLOCK_SEC_MS_IN_DAY;

    const double currentTimePartOfDayMin = _CLOCK_ARROW_ANGLE_MAX_DEGREE / _CLOCK_MIN_MS_IN_DAY;

    final double _angleSec = radianFromDegree(currentTimePartOfDaySec * (_seconds + _ms));
    final double _angleMin = radianFromDegree(currentTimePartOfDayMin * (_minutes + _seconds));
    final double _angleHours = radianFromDegree(currentTimePartOfDayHours * (_hours + _minutes + _seconds));

    final double radiusSec = radius * 1.8;
    final double radiusMin = radius * 1.5;
    final double radiusHours = radius * 0.8;

    final double xSec = _xPosForClockArrow(radiusSec, _angleSec, center.dx);
    final double ySec = _yPosForClockArrow(radiusSec, _angleSec, center.dy);

    final double xMin = _xPosForClockArrow(radiusMin, _angleMin, center.dx);
    final double yMin = _yPosForClockArrow(radiusMin, _angleMin, center.dy);
    final double xHours = _xPosForClockArrow(radiusHours, _angleHours, center.dx);
    final double yHours = _yPosForClockArrow(radiusHours, _angleHours, center.dy);

    canvas.drawLine(Offset(xSec, ySec), center, secondsLinePainter);
    canvas.drawLine(Offset(xMin, yMin), center, minutesLinePainter);
    canvas.drawLine(Offset(xHours, yHours), center, hoursLinePainter);
  }

  double _xPosForClockArrow(double radius, double angle, double cx) {
    return radius * cos(angle) + cx;
  }

  double _yPosForClockArrow(double radius, double angle, double cx) {
    return radius * sin(angle) + cx;
  }

  double radianFromDegree(double degree) => pi * (2.0 / 360 * degree + 1.5); // 1.5 = 90deg

  double radianFromDegreeWithAddAngle(double degree) => radianFromDegree(degree);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
