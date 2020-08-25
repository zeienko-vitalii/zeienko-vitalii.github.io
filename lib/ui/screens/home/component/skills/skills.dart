import 'package:cv_profile/assets/themes/dimens.dart';
import 'package:cv_profile/ui/common_widgets/circlular_progress.dart';
import 'package:cv_profile/ui/common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cv_profile/utils/localization/localization_manager.dart';

class Skills extends StatefulWidget {
  const Skills({Key key}) : super(key: key);

  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
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
                'Skills'.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: textSize_32,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Expanded(child: _skills()),
        ],
      ),
    );
  }

  Widget _skills() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _hardSkills()),
          _softSkills(),
        ],
      ),
    );
  }

  Widget _hardSkills() {
    const List<MapEntry<String, int>> skills = <MapEntry<String, int>>[
      MapEntry<String, int>('flutter', 95),
      MapEntry<String, int>('dart', 95),
      MapEntry<String, int>('reactivex', 93),
      MapEntry<String, int>('google_maps', 90),
      MapEntry<String, int>('java', 90),
      MapEntry<String, int>('firebase', 85),
      MapEntry<String, int>('android', 80),
      MapEntry<String, int>('kotlin', 80),
      MapEntry<String, int>('ios_apple', 65),
      MapEntry<String, int>('swift_1', 35),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Hard Skills',
          style: GoogleFonts.cairo(
            fontSize: textSize_16,
            fontWeight: FontWeight.w200,
            letterSpacing: 2.5,
            wordSpacing: 1.5,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 12,
              itemCount: skills.length,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(start: 16.w, top: 14.w, end: 16.w, bottom: 8.w),
              itemBuilder: (BuildContext context, int index) => _circularProgress(
                name: skills[index].key,
                progress: skills[index].value,
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.extent(3, 100.w),
              mainAxisSpacing: 20.w,
              crossAxisSpacing: 20.w,
            ),
          ),
        ),
      ],
    );
  }

  Container _circularProgress({String name, int progress}) {
    final Function path = (String name) => 'lib/assets/images/$name.svg';
    return Container(
//      height: 84.w,
//      width: 84.w,
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomPaint(
              painter: CircularProgressCustomPaint(progress, totalDots: 100),
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[100].withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: -1,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(child: svg(path(name))),
                    Flexible(
                      child: Text(
                        '$progress%',
                        style: GoogleFonts.cairo(
                          fontSize: textSize_12,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            context.locale[name],
            style: GoogleFonts.cairo(
              fontSize: textSize_12,
              fontWeight: FontWeight.w200,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _softSkills() {
    const Widget indent = Indent(top: 24);
    return Container(
      margin: EdgeInsets.only(top: 24.h, bottom: 12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Soft Skills',
            style: GoogleFonts.cairo(
              fontSize: textSize_16,
              fontWeight: FontWeight.w200,
              letterSpacing: 2.5,
              wordSpacing: 1.5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const <Widget>[
              SkillsProgressBar(title: 'Communication', percentage: 95),
              indent,
              SkillsProgressBar(title: 'Time Management', percentage: 93),
              indent,
              SkillsProgressBar(title: 'System Thinking', percentage: 95),
              indent,
              SkillsProgressBar(title: 'Self Development', percentage: 98),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillsProgressBar extends StatefulWidget {
  const SkillsProgressBar({Key key, this.title, this.percentage}) : super(key: key);

  final String title;
  final int percentage;

  @override
  _SkillsProgressBarState createState() => _SkillsProgressBarState();
}

class _SkillsProgressBarState extends State<SkillsProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            _dataContent(),
            _progressBar(),
          ],
        ),
      ),
    );
  }

  Widget _progressBar() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double progress = (widget.percentage / 100) * constraints.maxWidth;
        return Container(
          alignment: AlignmentDirectional.centerStart,
          width: constraints.maxWidth,
          height: 2.h,
          color: Colors.grey[300],
          child: Container(
            width: progress,
            height: 2.h,
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget _dataContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title?.toUpperCase() ?? '',
          style: GoogleFonts.cairo(
            fontSize: textSize_13,
            fontWeight: FontWeight.w200,
            letterSpacing: 2.5,
            wordSpacing: 1.5,
          ),
        ),
        Text(
          '${widget.percentage}%',
          style: GoogleFonts.cairo(
            fontSize: textSize_13,
            fontWeight: FontWeight.w200,
            letterSpacing: 1.5,
            wordSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
