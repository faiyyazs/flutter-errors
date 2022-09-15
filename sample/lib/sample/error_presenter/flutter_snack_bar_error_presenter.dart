import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';

class FlutterSnackBarErrorPresenter extends SnackBarErrorPresenter<String> {
  FlutterSnackBarErrorPresenter({super.duration});

  @override
  void show(Exception throwable, BuildContext context, String data) {
    final snackBar = SnackBar(
      content: Text(data),
      duration: super.duration.toFlutter(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

extension on SnackBarDuration {
  Duration toFlutter() {
    switch (this) {
      case SnackBarDuration.short:
        return Duration(milliseconds: 4000);
      case SnackBarDuration.long:
        return Duration(milliseconds: 6000);
    }
  }
}
