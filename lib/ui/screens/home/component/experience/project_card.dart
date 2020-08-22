import 'dart:ui';

import 'package:cv_profile/ui/screens/base/bloc/base_bloc.dart';
import 'package:cv_profile/ui/screens/home/bloc/home_bloc.dart';
import 'package:cv_profile/ui/screens/home/component/experience/project_gallery_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:websafe_svg/websafe_svg.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({Key key, this.image}) : super(key: key);

  final String image;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  double opacity = 0, x = 0, y = 0, z = 0;
  int durationSeconds = 4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, BaseBlocState>(
      listener: (_, __) {},
      builder: (BuildContext context, BaseBlocState state) {
        if (state is ScrollNotificationState) {
          _updateOpacity(state);
        }
        return AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: durationSeconds),
          curve: Curves.fastOutSlowIn,
          child: Transform(
            transform: Matrix4.identity()
              ..setTranslationRaw(x, y, z)
              ..perspectiveTransform(vector.Vector3(x, y, 1)),
            alignment: FractionalOffset.center,
            child: MouseRegion(
              onHover: (PointerHoverEvent details) {
                setState(() {
                  y = y - details.delta.dx / 100;
                  x = x + details.delta.dy / 100;
                });
              },
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
                onPressed: () {
                  showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) => const ProjectGalleryDialog(),
                  );
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Image.asset(
                          'lib/assets/images/phone.jpg',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      WebsafeSvg.asset(
                        widget.image,
                        height: 64.w,
                        width: 64.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateOpacity(ScrollNotificationState state) {
    if (state.scroll.metrics.pixels >= 0 && state.scroll.metrics.pixels <= 710) {
      opacity = 1;
      durationSeconds = 4;
    } else {
      opacity = 0;
      durationSeconds = 1;
      x = y = 0;
    }
  }
}
