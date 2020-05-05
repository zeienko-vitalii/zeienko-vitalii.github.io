import 'dart:math';

import 'package:flutter/material.dart';

class PlusIcon extends CustomPainter {
  PlusIcon({this.colors})
      : path = Path(),
        painter = Paint();

  final Path path;
  final Paint painter;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 3;
    final Offset center = Offset(size.width / 2, size.height / 2);
    const int sizeCoeff = 3;
    const double strokeWidth = 1.6;
    painter.shader = _gradientShaderOfBottomRect(
        Offset(size.width * 0.1, size.height * 0.1), size.width * 2, size.height * 2,
        colors: colors);
    path.moveTo(size.width * 0, size.height * 0.5);
    path.lineTo(size.width * 1.2, size.height * 1.2);
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: radius / strokeWidth,
          height: radius * sizeCoeff,
        ),
        const Radius.circular(10),
      ),
    );
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: radius * sizeCoeff,
          height: radius / strokeWidth,
        ),
        const Radius.circular(10),
      ),
    );
    path.close();
    canvas.drawPath(path, painter);
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
