import 'package:flutter/widgets.dart';

import '../../../flutter_errors.dart';

class SelectorErrorPresenter<T> implements FlutterErrorPresenter<T> {
  final FlutterErrorPresenter<T> Function(Exception) errorPresenterSelector;

  SelectorErrorPresenter(this.errorPresenterSelector);

  @override
  void show(Exception throwable, BuildContext context, T data) {
    errorPresenterSelector(throwable).show(throwable, context, data);
  }
}
