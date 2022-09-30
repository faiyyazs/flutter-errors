import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:sample/sample/exception/alert_texts.dart';

class FlutterAlertErrorPresenter extends AlertErrorPresenter<AlertTexts> {
  @override
  void show(Exception throwable, BuildContext context, AlertTexts data) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Text("Alert Information ${data.message}");
      },
    );
  }
}
