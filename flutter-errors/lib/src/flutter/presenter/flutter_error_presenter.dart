import 'package:flutter/widgets.dart';

import '../../presenter/error_presenter.dart';

abstract class FlutterErrorPresenter<T> implements ErrorPresenter<T> {

  FlutterErrorPresenter<T> resolvePresenter(Exception throwable) {
    return this;
  }

  Type resolveType() {
    return T;
  }

  void show(Exception throwable, BuildContext context, T data);
}
