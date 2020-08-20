import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
