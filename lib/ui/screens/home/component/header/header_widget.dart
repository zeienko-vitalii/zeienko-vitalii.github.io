import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:cv_profile/assets/themes/themes.dart';
import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:cv_profile/ui/screens/base/bloc/base_bloc.dart';
import 'package:cv_profile/ui/screens/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key key, this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _avatarSize = 264.w;

  HomeBloc get _bloc => context.bloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return _header(widget.theme);
  }

  Column _header(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 32.h),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _avatarWidget(theme),
                      ],
                    ),
                    const Indent(top: 68),
                    Text(
                      'Vitalii Zeienko',
                      style: GoogleFonts.cinzel(
                        fontSize: textSize_54,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    const Indent(top: 12),
                    Text(
                      'Mobile developer. Make your ideas real'.toUpperCase(),
//                              style: GoogleFonts.inter(
//                              style: GoogleFonts.raleway(
                      style: GoogleFonts.cairo(
                        fontSize: textSize_24,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 2.5,
                        wordSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: _socials(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Stack _avatarWidget(ThemeData theme) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: _avatarSize * 1.05,
          width: _avatarSize * 1.05,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black45,
                blurRadius: 12,
                spreadRadius: 8,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(184.w),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _bloc.selectedThemeKey == ThemeKeys.light
                    ? 'lib/assets/images/profile_photo.jpg'
                    : 'lib/assets/images/profile_photo_dark.jpg',
                fit: BoxFit.cover,
                height: _avatarSize,
                width: _avatarSize,
              ),
            ),
          ),
        ),
      ],
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
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
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
    );
  }

  Align _toggleButton() {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Switch(
        value: _bloc.selectedThemeKey == ThemeKeys.light,
        onChanged: (bool value) {
          _bloc.add(UpdateThemeEvent(value ? ThemeKeys.light : ThemeKeys.dark));
        },
      ),
    );
  }
}
