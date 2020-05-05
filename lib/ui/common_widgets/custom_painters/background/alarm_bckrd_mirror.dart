import 'package:flutter/material.dart';

class AlarmBackgroundMirrorCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF171A28)
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final Paint bPaint = Paint()
      // ..color = Color(0xFF24283F)
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = _gradientShaderOfBottomRect(Offset(size.width / 2, size.height / 1.7), size.width, size.height);

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        topRight: const Radius.circular(160),
      ),
      paint,
    );

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(size.width / 6, size.height / 1.1),
          width: size.width / 3,
          height: size.height / 3,
        ),
        topRight: const Radius.circular(190),
      ),
      bPaint,
    );
  }

  Shader _gradientShaderOfBottomRect(Offset center, double width, double height, {List<Color> colors}) {
    // a fancy rainbow gradient
    final Gradient gradient = RadialGradient(
      colors: colors ??
          const <Color>[
            Color(0xFF3B456A),
            Color(0xFF343c5c),
          ],
    );
    final Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    return gradient.createShader(rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
