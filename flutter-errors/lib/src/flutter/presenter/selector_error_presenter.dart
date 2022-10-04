import 'package:flutter/widgets.dart';

import '../../../flutter_errors.dart';

class SelectorErrorPresenter<T extends Object>
    extends FlutterErrorPresenter<T> {
  final FlutterErrorPresenter<T> Function(Exception) errorPresenterSelector;

  SelectorErrorPresenter(this.errorPresenterSelector);

  @override
  FlutterErrorPresenter<T> resolve(Exception throwable) {
    return errorPresenterSelector(throwable);
  }

  @override
  void show(Exception throwable, BuildContext context, dynamic data) {
    errorPresenterSelector(throwable).show(throwable, context, data as T);
  }
}
