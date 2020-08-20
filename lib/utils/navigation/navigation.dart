import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String rootScreen = '/';
const String alarmMainScreen = '/ALARM_MAIN_SCREEN';
const String createAlarmScreen = '/CREATE_ALARM_SCREEN';

class NavigatorHelper {
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  static void navigateToAlarmPage(BuildContext context) {
    Navigator.pushNamed(context, alarmMainScreen);
  }

  static void navigateToCreateAlarmPage(BuildContext context) {
    Navigator.pushNamed(context, createAlarmScreen);
  }
}
