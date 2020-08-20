import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(context),
    );
  }

  Widget getWidget(BuildContext context);
}
