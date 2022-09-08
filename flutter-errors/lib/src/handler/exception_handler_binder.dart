import '../dispatcher/events_dispatcher.dart';
import '../error_event_listener.dart';
import '../presenter/error_presenter.dart';

abstract class ExceptionHandlerBinder {}

abstract class ExceptionHandlerBinderImpl<T> implements ExceptionHandlerBinder {
  final ErrorPresenter<T> errorPresenter;
  final EventsDispatcher<ErrorEventListener<T>> eventsDispatcher;

  ExceptionHandlerBinderImpl(this.errorPresenter, this.eventsDispatcher);
}
