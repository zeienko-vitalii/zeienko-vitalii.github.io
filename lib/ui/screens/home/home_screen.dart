import 'package:cv_profile/ui/screens/home/bloc/home_bloc.dart';
import 'package:cv_profile/ui/screens/home/component/home_widget.dart';
import 'package:cv_profile/utils/ui_utilities/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const String homePath = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: const HomeWidget(),
    );
  }
}
