import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/data/db/db_manager.dart';
import 'package:minimal_alarm/ui/screens/base/base_theme_widget.dart';
import 'package:minimal_alarm/utils/navigation/navigation.dart';

import 'clock_widget.dart';

class AlarmClock extends StatefulWidget {
  @override
  _AlarmClockState createState() => _AlarmClockState();
}

class _AlarmClockState extends State<AlarmClock> with SingleTickerProviderStateMixin {
  @override
  Future<void> dispose() async {
    await DbManager().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseThemeWidget(
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClockWidget(),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                child: Text(
                  'Smart-i Clock',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize_24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                  padding: const EdgeInsets.all(18),
                  shape: const CircleBorder(),
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                  color: const Color(0x0fffff),
                  onPressed: () => NavigatorHelper.navigateToAlarmPage(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
