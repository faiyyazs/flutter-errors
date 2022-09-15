import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastErrorPresenter extends ToastErrorPresenter<String> {
  @override
  void show(Exception throwable, BuildContext context, String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
