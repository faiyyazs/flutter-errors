import '../../../flutter_errors.dart';

abstract class ToastErrorPresenter<T> extends FlutterErrorPresenter<T> {
  final ToastDuration duration;

  ToastErrorPresenter({this.duration = ToastDuration.short});
}

enum ToastDuration { short, long }
