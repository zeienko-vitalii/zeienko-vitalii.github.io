import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';

class ToggleButtonWidget extends StatefulWidget {
  const ToggleButtonWidget({
    Key key,
    @required this.onItemPressed,
    @required this.item,
    @required this.title,
  }) : super(key: key);

  final Function(dynamic) onItemPressed;
  final dynamic item;
  final String title;

  @override
  _ToggleButtonWidgetState createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPressed,
      shape: const CircleBorder(),
      color: isSelected ? Colors.lightBlueAccent : Colors.white,
      disabledColor: Colors.grey[400],
      disabledElevation: 0,
      elevation: 12,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text(
        widget.title ?? '',
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          fontSize: textSize_16,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  void _onPressed() {
      widget.onItemPressed(widget.item);
      setState(() => isSelected = !isSelected);
    }
}
