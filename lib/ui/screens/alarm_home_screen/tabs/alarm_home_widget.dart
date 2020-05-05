import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:minimal_alarm/assets/themes/dimens.dart';
import 'package:minimal_alarm/ui/common_widgets/icons/alarm_icon.dart';
import 'package:minimal_alarm/ui/common_widgets/icons/settings_icon.dart';
import 'package:minimal_alarm/ui/common_widgets/screen_elements/bouncing_button.dart';
import 'package:minimal_alarm/ui/screens/base/base_theme_widget.dart';
import 'package:minimal_alarm/utils/ui_utilities/scroll_behavior.dart';

import 'alarm_list_tab/component/alarm_list/alarm_list_widget.dart';
import 'alarm_settings_tab/alarm_settings_widget.dart';

class AlarmHomeWidget extends StatefulWidget {
  const AlarmHomeWidget({Key key}) : super(key: key);

  @override
  _AlarmHomeWidgetState createState() => _AlarmHomeWidgetState();
}

class _AlarmHomeWidgetState extends State<AlarmHomeWidget> with SingleTickerProviderStateMixin {
  static const int TABS_LENGTH = 2;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: TABS_LENGTH, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BaseThemeWidget(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 28),
            child: _Toolbar(tabController: _tabController),
          ),
          Expanded(child: _content(context)),
        ],
      ),
      padding: EdgeInsets.zero,
    );
  }

  Container _content(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - ScreenUtil().setHeight(toolbarHeight * 2),
      child: ScrollConfiguration(
        behavior: DisableOverScrollBehavior(),
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            AlarmListWidget(),
            AlarmSettingsWidget(),
          ],
        ),
      ),
    );
  }
}

class _Toolbar extends StatefulWidget {
  const _Toolbar({Key key, this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<StatefulWidget> createState() => _ToolbarState();
}

class _ToolbarState extends State<_Toolbar> {
  double iconSize = 24;
  bool _isAlarmSelected = true;
  Alignment _alarmAlignment = Alignment.center, _settingsAlignment = Alignment.center;

  TabController get _tabController => widget.tabController;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      setState(() => _isAlarmSelected = !_isAlarmSelected);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateAnimationOnTap();
    });
  }

  void _updateAnimationOnTap() {
    if (_isAlarmSelected) {
      _alarmAlignment = Alignment.topCenter;
      _settingsAlignment = Alignment.center;
    } else {
      _settingsAlignment = Alignment.topCenter;
      _alarmAlignment = Alignment.center;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    iconSize = 64 * 12 / 13;
    return SafeArea(
      child: Container(
        width: ScreenUtil().scaleWidth,
        height: toolbarHeight * 1.01,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _animationButtonWrapper(
              _alarmIcon(),
              alignment: _alarmAlignment,
              onEnd: _onEndAnimAlarmIcon,
              onPressed: _onAlarmTap,
            ),
            _animationButtonWrapper(
              _settingsIcon(),
              alignment: _settingsAlignment,
              onEnd: _onEndAnimSettingsIcon,
              onPressed: _onSettingsTap,
            ),
          ],
        ),
      ),
    );
  }

  void _onEndAnimSettingsIcon() {
    if (!_isAlarmSelected) {
      setState(
        () => _settingsAlignment =
            _settingsAlignment == Alignment.topCenter ? Alignment.bottomCenter : Alignment.topCenter,
      );
    }
  }

  void _onEndAnimAlarmIcon() {
    if (_isAlarmSelected) {
      setState(
        () => _alarmAlignment = _alarmAlignment == Alignment.topCenter ? Alignment.bottomCenter : Alignment.topCenter,
      );
    }
  }

  Widget _animationButtonWrapper(Widget child, {Alignment alignment, Function onEnd, Function onPressed}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      alignment: alignment,
      child: BouncingButton(
        Container(
          width: ScreenUtil().setWidth(iconSize),
          height: ScreenUtil().setHeight(iconSize),
          child: child,
        ),
        onDismiss: onPressed,
      ),
      onEnd: onEnd,
    );
  }

  void _onSettingsTap() {
    if (_tabController.index != 1) {
      _isAlarmSelected = false;
      _tabController.animateTo(1);
      _updateAnimationOnTap();
    }
  }

  void _onAlarmTap() {
    if (_tabController.index != 0) {
      _isAlarmSelected = true;
      _tabController.animateTo(0);
      _updateAnimationOnTap();
    }
  }

  Widget _alarmIcon() => CustomPaint(
        painter: AlarmIcon(isActive: _isAlarmSelected),
      );

  Widget _settingsIcon() => CustomPaint(
        painter: SettingsIcon(isActive: !_isAlarmSelected),
      );
}
