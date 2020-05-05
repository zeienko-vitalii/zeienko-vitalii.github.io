import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_alarm_widget.dart';

class CreateAlarmDialog extends ModalRoute<dynamic> {
  @override
  Color get barrierColor => Colors.black.withOpacity(0.01);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return const CreateAlarmWidget();
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation),
      child: child,
    );
  }
}
