import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectGalleryDialog extends StatefulWidget {
  const ProjectGalleryDialog({Key key}) : super(key: key);

//  final

  @override
  _ProjectGalleryDialogState createState() => _ProjectGalleryDialogState();
}

class _ProjectGalleryDialogState extends State<ProjectGalleryDialog> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    const List<String> imgs = <String>['phone.jpg', 'armenia.jpg', 'i_love_coding.jpg'];
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: ScreenUtil.screenHeight * 0.8,
        width: ScreenUtil.screenWidth * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      'lib/assets/images/${imgs[selectedImage]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: _navigationButton(imgs, () {
                        if (selectedImage != 0) {
                          selectedImage--;
                        } else {
                          selectedImage = imgs.length - 1;
                        }
                        setState(() {});
                      }, Icons.arrow_back_ios),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: _navigationButton(imgs, () {
                        if (selectedImage != imgs.length - 1) {
                          selectedImage++;
                        } else {
                          selectedImage = 0;
                        }
                        setState(() {});
                      }, Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton _navigationButton(List<String> imgs, Function onPressed, IconData iconData) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.transparent,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, color: Colors.deepOrangeAccent),
          ],
        ),
      ),
    );
  }
}
