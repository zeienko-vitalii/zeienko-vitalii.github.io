import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_alarm/ui/screens/base/bloc/theme_bloc.dart';

abstract class BaseThemedState<T extends StatefulWidget> extends State<T> {
  ThemeBloc get bloc => BlocProvider.of<ThemeBloc>(context);
  ScreenUtil get screenUtil => BlocProvider.of<ThemeBloc>(context).screenUtil;

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget();
}
