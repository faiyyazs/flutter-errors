import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';

class FlutterAlertErrorPresenter extends AlertErrorPresenter<String> {
  @override
  void show(Exception throwable, BuildContext context, String data) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Text("Alert Information ${data}");
      },
    );
  }
}
