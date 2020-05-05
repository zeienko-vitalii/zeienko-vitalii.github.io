import 'dart:math';

import 'package:flutter/material.dart';

class TimerIconPainter extends CustomPainter {
  TimerIconPainter({
    this.strokeColor = Colors.black,
    this.strokeWidth = 1,
    this.paintingStyle = PaintingStyle.stroke,
  }) : trianglePaint = Paint();

  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final Paint trianglePaint;

  @override
  void paint(Canvas canvas, Size size) {
    trianglePaint
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle
      ..strokeCap = StrokeCap.round
      ..shader = _gradientShaderOfBottomRect(
        Offset(size.width * 0.1, size.height * 0.1),
        size.width * 2,
        size.height * 2,
      );

    canvas.drawPath(getTimerPath(size.width, size.height), trianglePaint);
  }

  Shader _gradientShaderOfBottomRect(Offset center, double width, double height, {List<Color> colors}) {
    final Gradient gradient = RadialGradient(
      colors: colors ??
          const <Color>[
            Color(0xFF5185F9),
            Color(0xFF5EDFE9),
            Color(0xFF5694FA),
            Color(0xFF5FEEE3),
          ],
    );
    final Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    return gradient.createShader(rect);
  }

  Path getTimerPath(double w, double h) {
    final double outerRadius = min(w, h) / 1.8;
    final double circleRadius = min(w, h - h * 0.2) / 2;
    final Offset center = Offset(w / 2, h / 2);
    final Offset innerCenter = center.translate(0, h * 0.06);
    final double coeffFromR = outerRadius * 0.3;
    return Path()
      ..moveTo(outerRadius - coeffFromR, 0)
      ..lineTo(outerRadius + coeffFromR, 0)
      ..moveTo(outerRadius, 0)
      ..lineTo(outerRadius, h * 0.16)
      ..addOval(Rect.fromCircle(
        center: innerCenter,
        radius: circleRadius,
      ))
      ..moveTo(innerCenter.dx, innerCenter.dy)
      ..lineTo(min(w, h - h * 0.22) / 2 * 1.6, min(w, h - h * 0.2) / 2)
      ..moveTo(outerRadius + coeffFromR * 2.2, h * 0.12)
      ..lineTo(min(w, h - h * 0.22) / 2 * 2.1, min(w, h - h * 0.5) / 2);
  }

  @override
  bool shouldRepaint(TimerIconPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
