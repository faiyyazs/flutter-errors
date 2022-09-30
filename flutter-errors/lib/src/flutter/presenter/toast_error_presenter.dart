import '../../../flutter_errors.dart';

abstract class ToastErrorPresenter<T> implements FlutterErrorPresenter<T> {
  final ToastDuration duration;

  ToastErrorPresenter({this.duration = ToastDuration.short});
}

enum ToastDuration { short, long }
