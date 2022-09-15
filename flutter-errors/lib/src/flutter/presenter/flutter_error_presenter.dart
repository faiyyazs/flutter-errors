import 'package:flutter/widgets.dart';

import '../../presenter/error_presenter.dart';

abstract class FlutterErrorPresenter<T> implements ErrorPresenter<T> {
  void show(Exception throwable, BuildContext context, T data);
}
