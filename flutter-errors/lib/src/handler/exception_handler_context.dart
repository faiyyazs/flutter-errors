import 'package:flutter_errors/src/handler_result.dart';

abstract class ExceptionHandlerContext<R> {
  Future<HandlerResult<R, Exception>> execute();

  ExceptionHandlerContext<R> condition<E extends Exception>({
    required bool Function(Exception element) condition,
    required bool Function(E element) catcher,
  });

  ExceptionHandlerContext<R> finallyIt({
    required void Function() block,
  });

  ExceptionHandlerContext<R> catchIt<E extends Exception>(
      bool Function(E element) catcher) {
    return condition(condition: (e){
      return false;
    }, catcher: catcher);


  }
}
