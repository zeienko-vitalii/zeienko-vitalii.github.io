import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressCustomPaint extends CustomPainter {
  CircularProgressCustomPaint(
    this._circleCurrentValue, {
    this.totalDots = 60,
  }) : assert(_circleCurrentValue >= 0 && _circleCurrentValue <= totalDots);

  final num totalDots;
  final num _circleCurrentValue;
  static const double _START_ANGLE_MAX = 3.5;
  static const double _CURRENT_ANGLE_MAX = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..shader = _gradientShader(size);
    final double actualCurrentValue = _circleCurrentValue * _CURRENT_ANGLE_MAX / totalDots;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * (_START_ANGLE_MAX - actualCurrentValue),
      pi * actualCurrentValue,
      false,
      paint,
    );
  }

  Shader _gradientShader(Size size) {
    // a fancy rainbow gradient
    const Gradient gradient = RadialGradient(
      colors: <Color>[
        Color(0xFF5EDFE9),
        Color(0xFF5FEEE3),
        Color(0xFF639eff),
        Color(0xFF5185F9),
//        Colors.black12,
//        Colors.black45,
//        Colors.black87,
//        Colors.black,
      ],
    );
    return gradient.createShader(Rect.fromCircle(
      center: Offset(size.width / 1.4, size.height / 2.3),
      radius: min(size.width, size.height),
    ));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
