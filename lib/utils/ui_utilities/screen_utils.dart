import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void initScreenUtil(BuildContext context) {
  final double devicePixelRatio = ui.window.devicePixelRatio;
  final Size windowLogicalSize = ui.window.physicalSize / ((devicePixelRatio < 2) ? 1 : devicePixelRatio);
  final double screenWidth = windowLogicalSize.width;
  final double screenHeight = windowLogicalSize.height;
  ScreenUtil.init(context, width: screenWidth, height: screenHeight);
}
