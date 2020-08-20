import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectGalleryDialog extends StatefulWidget {
  const ProjectGalleryDialog({Key key}) : super(key: key);

  @override
  _ProjectGalleryDialogState createState() => _ProjectGalleryDialogState();
}

class _ProjectGalleryDialogState extends State<ProjectGalleryDialog> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    List<String> imgs = ['phone.jpg', 'armenia.jpg', 'i_love_coding.jpg'];
    return AlertDialog(
      content: Container(
        height: ScreenUtil.screenHeight * 0.8,
        width: ScreenUtil.screenWidth * 0.8,
        child: Column(
          children: <Widget>[
            Image.asset(
              'lib/assets/images/${imgs[selectedImage]}',
              fit: BoxFit.fitWidth,
              height: (ScreenUtil.screenHeight * 0.8) * 0.6,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    if(selectedImage != 0){
                      selectedImage--;
                    } else {
                      selectedImage = imgs.length - 1;
                    }
                    setState(() {});
                  },
                  child: Icon(Icons.arrow_back),
                ),
                RaisedButton(
                  onPressed: (){
                    if(selectedImage != imgs.length - 1){
                      selectedImage++;
                    } else {
                      selectedImage = 0;
                    }
                    setState(() {});
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}