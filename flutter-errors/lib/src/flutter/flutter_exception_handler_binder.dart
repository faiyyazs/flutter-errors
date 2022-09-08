import '../error_event_listener.dart';
import '../handler/presenter_exception_handler.dart';
import 'dispatcher/flutter_events_dispatcher.dart';
import 'observer/flutter_widget_binding_observer.dart';
import 'presenter/flutter_error_presenter.dart';

abstract class FlutterExceptionHandlerBinder<T>
    extends PresenterExceptionHandler {
  FlutterExceptionHandlerBinder(super.exceptionMapper, super.errorPresenters,
      super.errorEventsDispatcher, super.onCatch);

  bind(FlutterWidgetBindingObserver lifecycleOwner);
}

class FlutterExceptionHandlerBinderImpl<T>
    extends FlutterExceptionHandlerBinder<T> {
  final FlutterErrorPresenter<T> flutterErrorPresenter;
  final FlutterEventsDispatcher<ErrorEventListener<T>> flutterEventsDispatcher;

  FlutterExceptionHandlerBinderImpl(exceptionMapper, this.flutterErrorPresenter,
      this.flutterEventsDispatcher, onCatch)
      : super(exceptionMapper, flutterErrorPresenter, flutterEventsDispatcher,
            onCatch);

  @override
  bind(FlutterWidgetBindingObserver lifecycleOwner) {
    flutterEventsDispatcher.bind(
        lifecycleOwner, EventsListener(lifecycleOwner, flutterErrorPresenter));
  }
}

class EventsListener<T> implements ErrorEventListener<T> {
  final FlutterWidgetBindingObserver _bindingObserver;
  final FlutterErrorPresenter<T> errorPresenter;

  EventsListener(this._bindingObserver, this.errorPresenter);

  @override
  void showError(Exception throwable, T data) {
    errorPresenter.show(throwable, _bindingObserver, data);
  }
}
