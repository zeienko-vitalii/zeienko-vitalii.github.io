import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minimal_alarm/utils/localization/localization_delegate.dart';
import 'package:minimal_alarm/utils/navigation/navigation.dart';

import 'data/db/db_manager.dart';
import 'ui/screens/alarm_home_screen/alarm_home_screen.dart';
import 'ui/screens/main_clock_screen/alarm_clock_screen.dart';

Future<void> main() async {
  await _init();
  runApp(MinimalAlarmApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbManager().init();
}

class MinimalAlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Clock',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        ROOT_SCREEN: (BuildContext context) => AlarmClockScreen(),
        ALARM_MAIN_SCREEN: (BuildContext context) => AlarmHomeScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ALARM_MAIN_SCREEN:
            return _materialPageRoute(AlarmHomeScreen(), settings.arguments);
          default:
            return _materialPageRoute(AlarmHomeScreen(), settings.arguments);
        }
      },
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ru', ''),
      ],
    );
  }

  MaterialPageRoute<Widget> _materialPageRoute(Widget child, [RouteSettings arguments]) {
    return MaterialPageRoute<Widget>(
      builder: (BuildContext context) {
        return child;
      },
      settings: arguments,
    );
  }
}
