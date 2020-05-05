import 'dart:math';

import 'package:flutter/material.dart';

class AlarmIcon extends CustomPainter {
  AlarmIcon({this.isActive = true})
      : clockPainter = Paint(),
        handPainter = Paint(),
        bellPainter = Paint() {
    clockPainter..color = Colors.blue;
    handPainter
      ..color = Colors.white
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    bellPainter
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  final Paint clockPainter;
  final Paint handPainter;
  final Paint bellPainter;
  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 3;
    final Offset center = Offset(size.width / 2, size.height / 2);
    if (isActive) {
      clockPainter.shader = _gradientShaderOfBottomRect(
        Offset(size.width * 0.1, size.height * 0.1),
        size.width * 2,
        size.height * 2,
      );
    } else {
      clockPainter.color = const Color(0xFF6C76A1);
      bellPainter.color = const Color(0xFF71768a);
    }

    canvas.drawOval(Rect.fromCircle(center: center, radius: radius), clockPainter);

    canvas.save();
    canvas.translate(size.width / 1.1, size.height / 5);
    canvas.rotate(radianFromDegree(135));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: radius * 0.7, height: radius * 0.15),
          const Radius.circular(2),
        ),
        bellPainter);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 12, size.height / 5);
    canvas.rotate(radianFromDegree(-45));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center.translate(-0.7, -1), width: radius * 0.15, height: radius * 0.7),
          const Radius.circular(2),
        ),
        bellPainter);
    canvas.restore();

    canvas.drawLine(center, Offset(size.width / 1.7, size.height / 2.6), handPainter);
  }

  void addBell(Canvas canvas, Size size, Offset center, double radius) {
    canvas.drawLine(
        center.translate(-center.dx / 1.7, -center.dy / 2.8), Offset(size.width / 2.4, size.height / 5), bellPainter);
  }

  double radianFromDegree(double degree) => pi * (2.0 / 360 * degree);

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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
