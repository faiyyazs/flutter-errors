import 'exception_handler_binder.dart';
import 'exception_handler_context.dart';

abstract class ExceptionHandler implements ExceptionHandlerBinder {
  ExceptionHandlerContext<R> handle<R>({required R Function() block});

  /// Directly launches the error-presenter to display the error for exception [throwable].
  void showError<R>(Exception throwable);
}
