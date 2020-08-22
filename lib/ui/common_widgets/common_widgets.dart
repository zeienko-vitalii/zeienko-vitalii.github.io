import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget indent({
  num left = 0,
  num top = 0,
  num right = 0,
  num bottom = 0,
  num all,
}) =>
    Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(all?.toDouble() ?? left?.toDouble()),
        top: ScreenUtil().setHeight(all?.toDouble() ?? top?.toDouble()),
        right: ScreenUtil().setWidth(all?.toDouble() ?? right?.toDouble()),
        bottom: ScreenUtil().setHeight(all?.toDouble() ?? bottom?.toDouble()),
      ),
    );
