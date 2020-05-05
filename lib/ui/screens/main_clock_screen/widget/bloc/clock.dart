import 'dart:async';

import 'package:mobx/mobx.dart';

class Clock {
  Clock() {
    _atom = Atom(name: 'ClockAtomic', onObserved: _startTimer, onUnobserved: _stopTimer);
  }

  DateTime get now {
    _atom.reportObserved();
    return DateTime.now();
  }

  Atom _atom;
  Timer _timer;

  void _startTimer() {
    print('Clock started ticking');
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1), _onTick);
  }

  void _stopTimer() {
    _timer?.cancel();
    print('Clock stopped ticking');
  }

  void _onTick(Timer _) {
    _atom.reportChanged();
  }
}
