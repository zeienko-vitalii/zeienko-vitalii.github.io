import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:cv_profile/utils/localization/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Expanded(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 34.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: _aboutMeDescription()),
                        Expanded(
                          child: Image.asset(
                            'lib/assets/images/profile_photo.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
//                    Expanded(child: _socials()),
                      ],
                    ),
                  ),
                ),
//                Container(
//                  margin: EdgeInsets.symmetric(horizontal: 62.w, vertical: 64.h),
//                  height: 0.1.h,
//                  color: Colors.black,
//                ),
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
      margin: EdgeInsetsDirectional.only(start: 34.w,  end: 34.w),
      padding: EdgeInsets.all(12.w),
      width: ScreenUtil.screenWidth / 2,
      alignment: AlignmentDirectional.centerStart,
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
          context.locale['about_me'],
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

  Future<void> _launchURL([String url]) async {
    String urlToOpen = url;
    urlToOpen ??= 'https://flutter.dev';
    if (await canLaunch(urlToOpen)) {
      await launch(urlToOpen);
    } else {
      throw 'Could not launch $urlToOpen';
    }
  }

  Widget _socials() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(''),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () => _launchURL('https://www.upwork.com/o/profiles/users/~01fa2e59975803a44f/'),
                child: svg('lib/assets/images/upwork_tile.svg'),
              ),
              const Indent(top: 12),
              InkWell(
                onTap: () => _launchURL('www.linkedin.com/in/vitalii-zeienko'),
                child: svg('lib/assets/images/linkedin.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
