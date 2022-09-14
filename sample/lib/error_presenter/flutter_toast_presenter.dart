import 'package:flutter/foundation.dart';
import 'package:flutter_errors/flutter_errors.dart';

class FlutterToastErrorPresenter extends ToastErrorPresenter<String> {
  @override
  void show(Exception throwable, FlutterWidgetBindingObserver activity,
      String data) {
    debugPrint("Toast>>>");
  }
}
