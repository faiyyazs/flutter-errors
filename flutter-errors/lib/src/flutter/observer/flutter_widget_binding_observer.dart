import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class FlutterWidgetBindingObserver {
  void didChangeAppLifecycleState(AppLifecycleState state);
  Stream<PageState> state();
}

class FlutterWidgetBindingObserverImpl extends FlutterWidgetBindingObserver {
  final StreamController<PageState> _stateController = StreamController();
  AppLifecycleState _state = AppLifecycleState.inactive;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(" didChangeAppLifecycleState $state ");
    _state = state;
    _stateController.add(_getTargetState());
  }

  @override
  Stream<PageState> state() {
    return _stateController.stream;
  }

  PageState _getTargetState() {
    switch (_state) {
      case AppLifecycleState.inactive:
        return PageState.onInActive;
      case AppLifecycleState.paused:
        return PageState.onPause;
      case AppLifecycleState.resumed:
        return PageState.onResume;
      case AppLifecycleState.detached:
        return PageState.onDestroy;
    }
  }
}

enum PageState { onInActive, onResume, onPause, onDestroy }
