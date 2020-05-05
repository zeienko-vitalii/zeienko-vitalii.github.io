import 'package:flutter/material.dart';

class AlarmCreateBackgroundCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = _backgroundGradient(
        Offset(size.width / 2, size.height / 1.7),
        size.width,
        size.height,
      );

    final Paint bPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = _gradientShaderOfBottomRect(
        Offset(size.width / 2, size.height / 1.7),
        size.width,
        size.height,
      );

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
        topLeft: const Radius.circular(54),
        topRight: const Radius.circular(54),
      ),
      paint,
    );

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 1.11),
          width: size.width / 2,
          height: size.height / 5,
        ),
        topLeft: const Radius.circular(190),
        topRight: const Radius.circular(190),
      ),
      bPaint,
    );
  }

  Shader _gradientShaderOfBottomRect(Offset center, double width, double height, {List<Color> colors}) {
    final Gradient gradient = RadialGradient(
      colors: colors ??
          const <Color>[
            Color(0xFF16222A),
            Color(0x9016222A),
          ],
    );
    final Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    return gradient.createShader(rect);
  }

  Shader _backgroundGradient(Offset center, double width, double height, {List<Color> colors}) {
    final LinearGradient linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors ??
          const <Color>[
            Color(0xFF2CD5DF),
            Color(0xF01F5FFF),
          ],
    );
    final Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    return linearGradient.createShader(rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
