import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Indent extends StatelessWidget {
  const Indent({
    Key key,
    this.start = 0,
    this.top = 0,
    this.end = 0,
    this.bottom = 0,
    this.all,
  }) : super(key: key);
  final num start, top, end, bottom, all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: ScreenUtil().setWidth(all?.toDouble() ?? start?.toDouble()),
        top: ScreenUtil().setHeight(all?.toDouble() ?? top?.toDouble()),
        end: ScreenUtil().setWidth(all?.toDouble() ?? end?.toDouble()),
        bottom: ScreenUtil().setHeight(all?.toDouble() ?? bottom?.toDouble()),
      ),
    );
  }
}

Widget svg(String name, {double width, double height, double size, Color color}) {
  return WebsafeSvg.asset(
    name,
    height: size ?? height ?? 26.w,
    width: size ?? width ?? 26.w,
    color: color,
  );
}
