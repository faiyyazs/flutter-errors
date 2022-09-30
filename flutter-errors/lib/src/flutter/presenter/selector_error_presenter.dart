import 'package:flutter/widgets.dart';

import '../../../flutter_errors.dart';

class SelectorErrorPresenter implements FlutterErrorPresenter<dynamic> {
  final FlutterErrorPresenter Function(Exception) errorPresenterSelector;

  SelectorErrorPresenter(this.errorPresenterSelector);

  @override
  void show(Exception throwable, BuildContext context, dynamic data) {
    errorPresenterSelector(throwable).show(throwable, context, data);
  }
}
