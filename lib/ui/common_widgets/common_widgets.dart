import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/ui/common_widgets/screen_elements/bouncing_button.dart';

import 'icons/plus_icon.dart';

Widget indent({
  int left = 0,
  int top = 0,
  int right = 0,
  int bottom = 0,
  int all,
}) =>
    Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(all?.toDouble() ?? left?.toDouble()),
        top: ScreenUtil().setHeight(all?.toDouble() ?? top?.toDouble()),
        right: ScreenUtil().setWidth(all?.toDouble() ?? right?.toDouble()),
        bottom: ScreenUtil().setHeight(all?.toDouble() ?? bottom?.toDouble()),
      ),
    );

Widget plusButton({
  VoidCallback onPressed,
  double size = 48,
  List<Color> colors,
}) =>
    BouncingButton(
      Center(
        child: Container(
          width: ScreenUtil().setWidth(size),
          height: ScreenUtil().setHeight(size),
          child: CustomPaint(painter: PlusIcon(colors: colors)),
        ),
      ),
      onDismiss: onPressed,
    );
