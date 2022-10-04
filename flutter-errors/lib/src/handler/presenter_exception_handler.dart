import 'package:flutter_errors/src/handler/exception_handler.dart';
import 'package:flutter_errors/src/handler/exception_handler_context.dart';
import 'package:flutter_errors/src/handler/exception_handler_context_impl.dart';

import '../dispatcher/events_dispatcher.dart';
import '../error_event_listener.dart';
import '../presenter/error_presenter.dart';
import 'exception_handler_binder.dart';
import 'exception_mapper/exception_mapper.dart';

class PresenterExceptionHandler<T> extends ExceptionHandlerBinderImpl<T>
    implements ExceptionHandler {
  final ExceptionMapper exceptionMapper;
  void Function(Exception element)? onCatch;
  final ErrorPresenter errorPresenters;
  final EventsDispatcher<ErrorEventListener<T>> errorEventsDispatcher;

  PresenterExceptionHandler(
    this.exceptionMapper,
    this.errorPresenters,
    this.errorEventsDispatcher,
    this.onCatch,
  ) : super(errorPresenters, errorEventsDispatcher);

  @override
  ExceptionHandlerContext<R> handle<R>({required R Function() block}) {
    return ExceptionHandlerContextImpl<T, R>(
        exceptionMapper: exceptionMapper,
        eventsDispatcher: errorEventsDispatcher,
        onCatch: onCatch,
        block: block);
  }

  @override
  void showError<TC extends Object>(Exception throwable) {
    //TO-DO: Need to check this functionality
    final errorValue = exceptionMapper(throwable, TC.runtimeType) as T;
    errorEventsDispatcher.dispatchEvent((listener) {
      listener.showError(throwable, errorValue);
    });
  }
}
