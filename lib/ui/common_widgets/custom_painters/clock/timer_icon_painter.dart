import 'dart:math';

import 'package:flutter/material.dart';

class TimerIconPainter extends CustomPainter {
  TimerIconPainter({
    this.iconSize,
    this.strokeColor = Colors.white,
    this.strokeWidth = 2,
    this.paintingStyle = PaintingStyle.stroke,
  })
      : trianglePaint = Paint(),
        timerIconPath = Path();

  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final Paint trianglePaint;
  final Path timerIconPath;
  double iconSize;

  static const double _ICON_SCALE_COEFF = 12 / 13;

  @override
  void paint(Canvas canvas, Size size) {
    trianglePaint
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle
      ..strokeCap = StrokeCap.round;

    double width = size.width * _ICON_SCALE_COEFF;
    double height = size.height * _ICON_SCALE_COEFF;
    if (iconSize != null) {
      width = iconSize;
      height = iconSize;
    }
    canvas.drawPath(getTimerPath(width, height), trianglePaint);
  }

  Path getTimerPath(double width, double height) {
    final double outerRadius = min(width, height) / 2;
    final double circleRadius = min(width, height - height * 0.12) / 2;
    final Offset center = Offset(width / 2, height / 2);
    final Offset innerCenter = center.translate(0, height * 0.06);
    final double coeffFromR = outerRadius * 0.3;
    return timerIconPath
      ..moveTo(outerRadius - coeffFromR, 0)
      ..lineTo(outerRadius + coeffFromR, 0)
      ..moveTo(outerRadius, 0)
      ..lineTo(outerRadius, height * 0.12)
      ..addOval(Rect.fromCircle(
        center: innerCenter,
        radius: circleRadius,
      ))
      ..moveTo(innerCenter.dx, innerCenter.dy)
      ..lineTo(min(width, height - height * 0.22) / 2 * 1.6, min(width, height - height * 0.2) / 2)
      ..moveTo(outerRadius + coeffFromR * 2.2, height * 0.12)
      ..lineTo(min(width, height - height * 0.22) / 2 * 1.99, min(width, height - height * 0.59) / 2);
  }

  @override
  bool shouldRepaint(TimerIconPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.timerIconPath != timerIconPath;
  }
}
