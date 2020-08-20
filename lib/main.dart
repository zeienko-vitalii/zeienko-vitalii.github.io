import 'package:cv_profile/utils/localization/localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'ui/screens/home/home_screen.dart';

Future<void> main() async {
  await _init();
  runApp(MinimalAlarmApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class MinimalAlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My CV',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        HomeScreen.homePath: (BuildContext context) => const HomeScreen(),
      },
      builder: (BuildContext contex, Widget child) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child),
          maxWidth: 3840,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const <ResponsiveBreakpoint>[
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2880, name: 'laptop'),
            ResponsiveBreakpoint.autoScale(2048, name: '2K'),
            ResponsiveBreakpoint.autoScale(3840, name: '4K'),
          ],
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          default:
            return _materialPageRoute(Container(color: Colors.red), settings.arguments);
        }
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        LocalizationDelegate(),
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
