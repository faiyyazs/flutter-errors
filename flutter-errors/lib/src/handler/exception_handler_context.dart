import 'package:flutter_errors/src/handler_result.dart';

abstract class ExceptionHandlerContext<R> {
  Future<HandlerResult<R, Exception>> execute();

  ExceptionHandlerContext<R> catchIt<E extends Exception>({
    required bool Function(Exception element) condition,
    required bool Function(E element) catcher,
  });

  ExceptionHandlerContext<R> finallyIt({
    required void Function() block,
  });

/*  ExceptionHandlerContext<R> _catchIt<E extends Exception>(
      bool Function(E element) catcher) {
    return catchIt(
      catcher: catcher,
      //condition: this is E,
      condition: (Exception element) {
        return true;
      },
    );
  }*/
}
