import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';

class FlutterSnackBarErrorPresenter extends SnackBarErrorPresenter<String> {
  FlutterSnackBarErrorPresenter({super.duration});

  @override
  void show(Exception throwable, BuildContext context, String data) {
    final snackBar = SnackBar(
      content: Text(data),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
