import 'package:flutter_errors/src/flutter/observer/flutter_widget_binding_observer.dart';

import '../../dispatcher/events_dispatcher.dart';

class FlutterEventsDispatcher<Listener> extends EventsDispatcher<Listener> {
  Listener? eventsListener;

  final _blocks = <void Function(Listener listner)>[];

  FlutterEventsDispatcher();

  void bind(FlutterWidgetBindingObserver bindingObserver, Listener listener) {
    bindingObserver.state().listen((event) {
      switch (event) {
        case PageState.attached:
          eventsListener = listener;
          break;

        case PageState.onInActive:
          break;

        case PageState.onResume:
          eventsListener = listener;

          for (var element in _blocks) {
            element(listener);
          }
          _blocks.clear();

          break;

        case PageState.onPause:
        case PageState.onDestroy:
          eventsListener = null;
          break;
      }
    });
  }

  @override
  void dispatchEvent(void Function(Listener listener) block) {
    var eListener = eventsListener;
    print("eListener $eListener");
    if (eListener != null) {
      block(eListener);
    } else {
      _blocks.add(block);
    }
  }
}
