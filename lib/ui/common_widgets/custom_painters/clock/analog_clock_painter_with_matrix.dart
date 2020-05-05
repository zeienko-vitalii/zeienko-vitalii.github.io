import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClockPainterWithMatrix extends CustomPainter {
  AnalogClockPainterWithMatrix(this._timeInMs)
      : secondsLinePainter = Paint(),
        minLinePainter = Paint(),
        hoursLinePainter = Paint();

  static const int _CLOCK_ARROW_ANGLE_MAX_DEGREE = 360;

  final num _timeInMs;
  final Paint secondsLinePainter, minLinePainter, hoursLinePainter;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 3;
    final Offset center = Offset(size.width / 2, size.height / 2);
    minLinePainter
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    hoursLinePainter
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    const Offset o = Offset(0, 0);
    canvas.translate(center.dx, center.dy);

    canvas.save();
    canvas.rotate(pi + _calculateMsHandRotation(_timeInMs));
    canvas.drawLine(
        o,
        o.translate(0, radius * 2),
        Paint()
          ..color = Colors.redAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round);
    canvas.restore();

    canvas.save();
    canvas.rotate(pi + _calculateMinHandRotation(_timeInMs));
    canvas.drawLine(o, o.translate(0, radius * 1.5), minLinePainter);
    canvas.restore();

    canvas.save();
    canvas.rotate(pi + _calculateHoursHandRotation(_timeInMs));
    canvas.drawLine(o, o.translate(0, radius), hoursLinePainter);
    canvas.restore();
  }

  double _calculateHoursHandRotation(num millis) {
    final double hours = millis / 3.6e+6, degrees = hours * 30.0;
    return radianFromDegree(degrees);
  }

  double _calculateMinHandRotation(num millis) {
    final double seconds = millis / 1000.0, degrees = (seconds % 3600.0) / 10.0;
    return radianFromDegree(degrees);
  }

//  double _calculateSecondHandRotation(num millis) {
//    final double seconds = millis / 1000.0, degrees = (seconds % _CLOCK_SEC_IN_MIN) * 6.0;
//    return radianFromDegree(degrees);
//  }

  double _calculateMsHandRotation(num millis) {
    final double ms = millis / 1000.0, degrees = (ms % 3600) * 6.0;
    return radianFromDegree(degrees);
  }

  double radianFromDegree(double degree) => pi * (2.0 / _CLOCK_ARROW_ANGLE_MAX_DEGREE * degree);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
