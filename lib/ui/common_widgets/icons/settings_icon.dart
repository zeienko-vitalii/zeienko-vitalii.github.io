import 'dart:math';

import 'package:flutter/material.dart';

class SettingsIcon extends CustomPainter {
  SettingsIcon({this.isActive = true})
      : linePainter = Paint(),
        circlePainter = Paint() {
    linePainter
      ..color = const Color(0xFF6C76A1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    circlePainter
      ..color = const Color(0xFF6C76A1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
  }

  final Paint linePainter;
  final Paint circlePainter;
  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    if (isActive) {
      linePainter.shader = _gradientShaderOfBottomRect(
        Offset(size.width * 0.1, size.height * 0.1),
        size.width * 2,
        size.height * 2,
      );
      circlePainter.shader = _gradientShaderOfBottomRect(
        Offset(size.width * 0.1, size.height * 0.1),
        size.width * 2,
        size.height * 2,
      );
    }

    _drawLineAndCircle(canvas, size, linePainter, circlePainter);
    _drawLineAndCircleReverse(canvas, size, linePainter, circlePainter);
  }

  void _drawLineAndCircle(Canvas canvas, Size size, Paint linePaint, Paint circlePaint, {bool isReverse}) {
    const double yPosCoeff = 4;
    final Offset startPoint = Offset(0, size.height / yPosCoeff);
    final Offset endPoint = Offset(size.width / 5, size.height / yPosCoeff);
    final Offset center = Offset(size.width / 2.2, size.height / yPosCoeff);
    final double radius = min(size.width, size.height) / 9;
    canvas.drawLine(startPoint, endPoint, linePaint);
    canvas.drawCircle(center, radius, circlePaint);
  }

  void _drawLineAndCircleReverse(Canvas canvas, Size size, Paint linePaint, Paint circlePaint, {bool isReverse}) {
    const double yPosCoeff = 1.7;
    final Offset startPoint = Offset(size.width / 1.9, size.height / yPosCoeff);
    final Offset endPoint = Offset(size.width / 3, size.height / yPosCoeff);
    final Offset center = Offset(size.width * 0.09, size.height / yPosCoeff);
    final double radius = min(size.width, size.height) / 9;
    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawLine(startPoint, endPoint, linePaint);
  }

  Shader _gradientShaderOfBottomRect(Offset center, double width, double height, {List<Color> colors}) {
    final Gradient gradient = RadialGradient(
      colors: colors ??
          const <Color>[
            Color(0xFF5EDFE9),
            Color(0xFF5FEEE3),
            Color(0xFF5694FA),
            Color(0xFF5185F9),
          ],
    );
    final Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    return gradient.createShader(rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
