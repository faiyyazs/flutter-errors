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

  final List<MapEntry<bool Function(Exception e), Catcher>> _catchers = [];
  final ExceptionMapper exceptionMapper;
  void Function(Exception element)? onCatch;
  void Function()? finallyBlock;
  final R Function() block;
  final EventsDispatcher<ErrorEventListener<T>> eventsDispatcher;

  @override
  ExceptionHandlerContext<R> condition<E extends Exception>({
    required bool Function(E element) condition,
    required bool Function(E element) catcher,
  }) {
    _catchers.add(MapEntry(
        condition as bool Function(Exception element), catcher as Catcher));
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
      // ignore: await_only_futures
      return HandlerResult.success(data: await block.call());
    } catch (e) {
      Exception error;
      //if (e is CancellationException) throw e
      if (e is! Exception) {
        error = Exception("Unknown Exception $e");
      } else {
        error = e;
      }

      onCatch?.call(error);
      bool isHandled = _isHandledByCustomCatcher(error);
      if (!isHandled) {
        // If not handled by a custom catcher
        eventsDispatcher.dispatchEvent((listener) {
          var data =
              exceptionMapper(error, listener.resolvePresenterType(error)) as T;
          listener.showError(error, data);
        });
      }
      return HandlerResult.error(exception: error);
    } finally {
      finallyBlock?.call();
    }
  }

  bool _isHandledByCustomCatcher(Exception cause) {
    return _catchers
            .firstWhereOrNull((element) => element.key
                .call(cause)) // Finds custom catcher by invoking conditions
            ?.value
            .call(cause) // If catcher was found then execute it
        ??
        false;
  }
}
