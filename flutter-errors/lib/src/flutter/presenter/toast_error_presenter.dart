import '../../../flutter_errors.dart';

abstract class ToastErrorPresenter implements FlutterErrorPresenter<String> {
  final ToastDuration duration;

  ToastErrorPresenter({this.duration = ToastDuration.short});
}

enum ToastDuration { short, long }
