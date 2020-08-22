import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:cv_profile/utils/localization/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key key}) : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 64.h,
            color: Colors.white,
            child: Center(
              child: Text(
                'About me'.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: textSize_32,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: _aboutMeDescription()),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 62.w, vertical: 64.h),
                  height: 0.1.h,
                  color: Colors.black,
                ),
                _statistics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutMeDescription() {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 34.w, top: 34.h, end: 34.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: 12,
            blurRadius: 12,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Text(
          context.locale()['about_me'],
          softWrap: true,
          overflow: TextOverflow.fade,
          style: GoogleFonts.cairo(
            fontSize: textSize_13,
            fontWeight: FontWeight.w200,
            letterSpacing: 2.5,
            wordSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _statistics() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 44.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _statisticsItem('HOURS OF WORK', '1927', 'time'),
          _statisticsItem('CUPS OF COFFEE', '850', 'coffee_cup'),
          _statisticsItem('TOTAL CLIENTS', '12', 'conversation'),
          _statisticsItem('HAPPY CLIENTS', '100%', 'emoji'),
        ],
      ),
    );
  }

  Widget _statisticsItem(String title, String data, String path) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              data ?? '',
              style: GoogleFonts.cairo(
                fontSize: textSize_20,
                fontWeight: FontWeight.w200,
                letterSpacing: 2.5,
                wordSpacing: 1.5,
              ),
            ),
            const Indent(top: 8),
            svg('lib/assets/images/$path.svg'),
            const Indent(top: 2),
            Text(
              title ?? '',
              style: GoogleFonts.cairo(
                fontSize: textSize_16,
                fontWeight: FontWeight.w200,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
