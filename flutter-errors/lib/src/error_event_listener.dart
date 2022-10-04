import 'package:flutter_errors/flutter_errors.dart';

abstract class ErrorEventListener<T> {
  FlutterErrorPresenter resolvePresenter(Exception throwable);

  void showError(Exception throwable, T data);
}
