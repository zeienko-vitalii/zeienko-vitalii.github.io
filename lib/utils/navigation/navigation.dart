import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String ROOT_SCREEN = '/';
const String ALARM_MAIN_SCREEN = '/ALARM_MAIN_SCREEN';
const String CREATE_ALARM_SCREEN = '/CREATE_ALARM_SCREEN';

class NavigatorHelper {
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  static void navigateToAlarmPage(BuildContext context) {
    Navigator.pushNamed(context, ALARM_MAIN_SCREEN);
  }

  static void navigateToCreateAlarmPage(BuildContext context) {
    Navigator.pushNamed(context, CREATE_ALARM_SCREEN);
  }
}
