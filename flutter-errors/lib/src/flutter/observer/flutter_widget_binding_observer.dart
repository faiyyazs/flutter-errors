import 'dart:async';

import 'package:flutter/widgets.dart';


abstract class FlutterWidgetBindingObserver {
  void didChangeAppLifecycleState(AppLifecycleState state);

  Stream<PageState> state();

  PageState getTargetState();
}

class FlutterWidgetBindingObserverImpl extends FlutterWidgetBindingObserver {
  final StreamController<PageState> _subject =
  StreamController();
  AppLifecycleState? _state;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(" didChangeAppLifecycleState $state ");
    _state = state;
    _subject.add(getTargetState());
  }

  @override
  Stream<PageState> state() {
    return _subject.stream;
  }

  @override
  PageState getTargetState() {
    switch (_state) {
      case AppLifecycleState.inactive:
        return PageState.onInActive;
      case AppLifecycleState.paused:
        return PageState.onPause;
      case AppLifecycleState.resumed:
        return PageState.onResume;
      case AppLifecycleState.detached:
        return PageState.onDestroy;
      case null:
        return PageState.attached;
    }
  }
}

enum PageState { attached, onInActive, onResume, onPause, onDestroy }
