import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterHelper {
  static const int HALF_RIGHT_ANGLE = 45;
  static const int RIGHT_ANGLE = 90;
  static const double RIGHT_ANGLE_RADS = 1.5;

  static double getRadius(Size size, {double divider = 2}) => min(size.width, size.height) / divider;

  static Offset getCenter(Size size, {double widthDivider = 2, double heightDivider = 2}) =>
      Offset(size.width / widthDivider, size.height / heightDivider);

  static List<Rect> dotOfChanges(
      Size dotSize, int valuesSize, double dotRadius, double timerValueAngleMax, double dotPointerShift) {
    final Offset center = getCenter(dotSize);
    final double radius = getRadius(dotSize);
    final double angleOfSingleVal = timerValueAngleMax / valuesSize;
    final List<Rect> rects = <Rect>[];
    for (double i = 0; i <= valuesSize; i++) {
      final double actualCurrentValue = i * angleOfSingleVal;
      final double angleOfPos = pi * actualCurrentValue + dotPointerShift;
      final Offset dotCenter = pointOnTheArcFromRAXY(radius, angleOfPos, center);
      rects.add(
        Rect.fromCircle(
          center: dotCenter,
          radius: dotRadius * 0.6,
        ),
      );
    }
    return rects;
  }

  static Offset pointOnTheArcFromRAXY(double radius, double angle, Offset center) => Offset(
        xPosFromRACx(radius, angle, center.dx),
        yPosFromRACy(radius, angle, center.dy),
      );

  static double xPosFromRACx(double radius, double angle, double cx) {
    return radius * cos(angle) + cx;
  }

  static double yPosFromRACy(double radius, double angle, double cy) {
    return radius * sin(angle) + cy;
  }

  /// Returns angle in range [0;360] between [point1] and [point2]
  static double angleFromPointers(Offset point1, Offset point2) {
    final double x1 = point1.dx, y1 = point1.dy;
    final double x2 = point2.dx, y2 = point2.dy;
    final double angleRadWithOffset = atan2(y1 - y2, x1 - x2);
    final double angle = degreeFromRadians(angleRadWithOffset+ RIGHT_ANGLE_RADS);
    return (angle < 0) ? angle + 360 : angle;
  }

  static double degreeFromRadians(double rad) => rad * 180 / pi;
}
