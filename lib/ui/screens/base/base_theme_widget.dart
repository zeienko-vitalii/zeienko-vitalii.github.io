import 'package:flutter/material.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';

class BaseThemeWidget extends StatelessWidget {
  const BaseThemeWidget(
    this._child, {
    Key key,
    this.padding,
    this.appBar,
  }) : super(key: key);

  final Widget _child;
  final EdgeInsets padding;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: padding ?? EdgeInsets.only(top: toolbarHeight),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const <Color>[
              Color(0xFF3B456A),
              Color(0xFF171A28),
            ],
          ),
        ),
        child: _child,
      ),
    );
  }
}
