import 'dart:ui';

import 'package:cv_profile/ui/screens/base/bloc/base_bloc.dart';
import 'package:cv_profile/ui/screens/base/widget/base_state.dart';
import 'package:cv_profile/ui/screens/home/bloc/home_bloc.dart';
import 'package:cv_profile/ui/screens/home/component/skills/skills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import 'about_me/about_me.dart';
import 'experience/work_experience.dart';
import 'header/header_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomeWidget> {
  HomeBloc get _bloc => context.bloc<HomeBloc>();
  final double _headerHeight = ScreenUtil.screenHeight;
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

  Widget _content(ThemeData theme) {
    //            color: theme.primaryColor,
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: _headerHeight,
            child: HeaderWidget(theme: theme),
          ),
          Container(
            height: ScreenUtil.screenHeight,
            color: Colors.white,
            child: const AboutMe(),
          ),
          Container(
            height: ScreenUtil.screenHeight,
            color: Colors.white,
            child: const WorkExperience(),
          ),
          Container(
            height: ScreenUtil.screenHeight,
            color: Colors.white,
            child: const Skills(),
          ),
        ],
      ),
    );
  }

  bool _updateOffsetAccordingToScroll(ScrollNotification scroll) {
    print('${scroll.metrics.pixels}');
    _bloc.add(ScrollNotificationEvent(scroll));
    setState(() => parallaxOffset = scroll.metrics.pixels);
    return true;
  }
}
