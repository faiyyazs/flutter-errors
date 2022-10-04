import 'package:collection/collection.dart';
import 'package:flutter_errors/src/handler_result.dart';

import '../dispatcher/events_dispatcher.dart';
import '../error_event_listener.dart';
import 'exception_handler_context.dart';
import 'exception_mapper/exception_mapper.dart';

typedef Catcher = bool Function(Exception element);

class ExceptionHandlerContextImpl<T, R> extends ExceptionHandlerContext<R> {
  ExceptionHandlerContextImpl({
    required this.exceptionMapper,
    required this.eventsDispatcher,
    this.onCatch,
    required this.block,
  });

  final _catchers = <MapEntry<bool Function(Exception), Catcher>>[];
  final ExceptionMapper exceptionMapper;
  void Function(Exception element)? onCatch;
  void Function()? finallyBlock;
  final R Function() block;
  final EventsDispatcher<ErrorEventListener<T>> eventsDispatcher;

  @override
  ExceptionHandlerContext<R> condition<E extends Exception>({
    required bool Function(Exception element) condition,
    required bool Function(E element) catcher,
  }) {
    _catchers.add(MapEntry(condition, catcher as Catcher));
    return this;
  }

  @override
  ExceptionHandlerContext<R> finallyIt({required void Function() block}) {
    finallyBlock = block;
    return this;
  }

  @override
  Future<HandlerResult<R, Exception>> execute() async {
    try {
      return HandlerResult.success(
        data: (R == Future) ? await (block() as Future<R>) : block.call(),
      );
    } catch (e) {
      // Don't handle coroutines CancellationException
      //if (e is CancellationException) throw e
      onCatch?.call(e as Exception);
      bool isHandled = _isHandledByCustomCatcher(e as Exception);
      if (!isHandled) {
        // If not handled by a custom catcher

        eventsDispatcher.dispatchEvent((listener) {
          var data =
              exceptionMapper(e, listener.resolvePresenter(e).resolveType());
          listener.showError(e, data);
        });
      }
      return HandlerResult.error(exception: e);
    } finally {
      finallyBlock?.call();
    }
  }

  bool _isHandledByCustomCatcher(Exception cause) {
    /*return catchers
        .firstOrNull { it.first.invoke(cause) } // Finds custom catcher by invoking conditions
        ?.second?.invoke(cause) // If catcher was found then execute it
    ?: false*/
    var first = _catchers.firstOrNull;
    first?.value.call(cause);
    if (first != null) {
      return _catchers.elementAt(1).value.call(cause);
    }
    return false;
  }
}
