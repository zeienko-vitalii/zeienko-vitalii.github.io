import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({Key key}) : super(key: key);

  @override
  _WorkExperienceState createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  final double _bubbleSize = 18.w;

  double get _lineWidth => _bubbleSize * 0.3;
  final double _lineHeight = 328.h;

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
                'Experience'.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: textSize_32,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                _experienceFlow(),
                Container(),
                _projects(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _projects() {
    return Container(
      height: ScreenUtil.screenHeight - 64.h,
      width: ScreenUtil.screenWidth,
      padding: EdgeInsets.all(84.w),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 10,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => _projectCard(index),
        staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 1 : 2),
        mainAxisSpacing: 40.w,
        crossAxisSpacing: 20.w,
      ),
    );
  }

  Widget _projectCard(int index) {
    return FlatButton(
      onPressed: (){},
      mouseCursor: MaterialStateMouseCursor.clickable,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
        child: Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('$index'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _experienceFlow() {
    return Stack(
      children: <Widget>[
        _line(),
      ],
    );
  }

  Widget _line() {
    return Container(
      width: _bubbleSize,
      height: _lineHeight,
      margin: EdgeInsetsDirectional.only(start: 64.w, top: 64.h),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                height: _bubbleSize,
                width: _bubbleSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                height: _bubbleSize,
                width: _bubbleSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              height: _lineHeight,
              width: _lineWidth,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}