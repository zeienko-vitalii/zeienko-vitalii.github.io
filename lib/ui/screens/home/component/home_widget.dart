import 'dart:ui';

import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:cv_profile/assets/themes/themes.dart';
import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:cv_profile/ui/screens/base/bloc/base_bloc.dart';
import 'package:cv_profile/ui/screens/base/widget/base_state.dart';
import 'package:cv_profile/ui/screens/home/bloc/home_bloc.dart';
import 'package:cv_profile/ui/screens/home/component/skills.dart';
import 'package:cv_profile/ui/screens/home/component/work_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomeWidget> {
  HomeBloc get _bloc => context.bloc<HomeBloc>();
  final double _headerHeight = ScreenUtil.screenHeight;
  final double _avatarSize = 264.w;
  double parallaxOffset = 0;

  @override
  Widget getWidget(BuildContext context) {
    return BlocConsumer<HomeBloc, BaseBlocState>(
      listener: (BuildContext context, BaseBlocState state) {
        // do stuff here based on BlocA's state
      },
      builder: (BuildContext context, BaseBlocState state) {
        ThemeData theme = _bloc.themeDataState;
        if (state is UpdateThemeState) {
          theme = state.theme;
        }
        return Container(
          color: theme.primaryColor,
          child: NotificationListener<ScrollNotification>(
            onNotification: _updateOffsetAccordingToScroll,
            child: Stack(
              children: <Widget>[
                _backgroundParallaxImage(),
                _content(theme),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _backgroundParallaxImage() {
    return Positioned(
      top: -.25 * parallaxOffset,
      child: Container(
        alignment: AlignmentDirectional.topCenter,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
//            image: 'lib/assets/images/i_love_coding.jpg',
            image:
//        _bloc.selectedThemeKey == ThemeKeys.light
//            ? 'lib/assets/images/armenia.jpg':
                'lib/assets/images/rui_silva.jpg',
            fit: BoxFit.fill,
            height: _headerHeight,
            width: ScreenUtil.screenWidth,
          ),
        ),
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

  Widget _content(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
//          Container(
//            height: _headerHeight,
//            child: _header(theme),
//          ),
          Container(
            height: ScreenUtil.screenHeight,
            color: theme.primaryColor,
            child: const WorkExperience(),
          ),
          Container(
            height: ScreenUtil.screenHeight,
            color: theme.primaryColor,
            child: const Skills(),
          ),
        ],
      ),
    );
  }

  Column _header(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 88.w, vertical: 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _avatarWidget(theme),
                    indent(top: 68.h),
                    Text(
                      'Vitalii Zeienko',
                      style: GoogleFonts.cinzel(
                        fontSize: textSize_54,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    indent(top: 12.h),
                    Text(
                      'Mobile developer'.toUpperCase(),
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
//                        Expanded(child: _toggleButton()),
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

  bool _updateOffsetAccordingToScroll(ScrollNotification scroll) {
    setState(() => parallaxOffset = scroll.metrics.pixels);
    return true;
  }
}
