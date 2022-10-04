import 'package:flutter/widgets.dart';

import '../../../flutter_errors.dart';

class SelectorErrorPresenter extends FlutterErrorPresenter {
  final FlutterErrorPresenter Function(Exception) errorPresenterSelector;

  SelectorErrorPresenter(this.errorPresenterSelector);

  @override
  FlutterErrorPresenter resolvePresenter(Exception throwable) {
    return errorPresenterSelector(throwable);
  }

  @override
  void show(Exception throwable, BuildContext context, dynamic data) {
    errorPresenterSelector(throwable).show(throwable, context, data);
  }
}
