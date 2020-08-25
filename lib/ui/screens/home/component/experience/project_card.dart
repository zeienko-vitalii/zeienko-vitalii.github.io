import 'dart:ui';

import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:cv_profile/ui/screens/home/component/experience/project_gallery_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ProjectCard extends StatefulWidget {
  const ProjectCard({Key key, this.image}) : super(key: key);

  final String image;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  double  _offsetX = 0, _offsetY = 0;
//  static const int _durationSeconds = 4;

  @override
  void initState() {
    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      setState(() {
//        _opacity = 1;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setTranslationRaw(_offsetX, _offsetY, 0)
        ..perspectiveTransform(vector.Vector3(_offsetX, _offsetY, 1)),
      alignment: FractionalOffset.center,
      child: MouseRegion(
        onHover: (PointerHoverEvent details) {
          setState(() {
            _offsetY = _offsetY - details.delta.dx / 100;
            _offsetX = _offsetX + details.delta.dy / 100;
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
                svg(widget.image, size: 64.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
