import 'package:flutter/widgets.dart';

import '../error_event_listener.dart';
import '../handler/exception_mapper/exception_mapper.dart';
import '../handler/presenter_exception_handler.dart';
import 'dispatcher/flutter_events_dispatcher.dart';
import 'observer/flutter_widget_binding_observer.dart';
import 'presenter/flutter_error_presenter.dart';

abstract class FlutterExceptionHandlerBinder<T>
    extends PresenterExceptionHandler<T> {
  FlutterExceptionHandlerBinder(super.exceptionMapper, super.errorPresenters,
      super.errorEventsDispatcher, super.onCatch);

  void bind(BuildContext context, FlutterWidgetBindingObserver lifecycleOwner);
}

class FlutterExceptionHandlerBinderImpl<T>
    extends FlutterExceptionHandlerBinder<T> {
  final FlutterErrorPresenter<T> flutterErrorPresenter;
  final FlutterEventsDispatcher<ErrorEventListener<T>> flutterEventsDispatcher;

  FlutterExceptionHandlerBinderImpl(
      ExceptionMapper<T> exceptionMapper,
      this.flutterErrorPresenter,
      this.flutterEventsDispatcher,
      Function(Exception element)? onCatch)
      : super(exceptionMapper, flutterErrorPresenter, flutterEventsDispatcher,
            onCatch);

  @override
  bind(BuildContext context, FlutterWidgetBindingObserver lifecycleOwner) {
    flutterEventsDispatcher.bind(
        lifecycleOwner, EventsListener(context, flutterErrorPresenter));
  }
}

class EventsListener<T> implements ErrorEventListener<T> {
  final BuildContext _context;
  final FlutterErrorPresenter<T> errorPresenter;

  EventsListener(this._context, this.errorPresenter);

  @override
  void showError(Exception throwable, T data) {
    errorPresenter.show(throwable, _context, data);
  }
}
