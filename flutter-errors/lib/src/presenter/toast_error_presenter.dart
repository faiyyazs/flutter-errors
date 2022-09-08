import 'error_presenter.dart';

abstract class ToastErrorPresenter implements ErrorPresenter<String> {
  final ToastDuration duration;
  ToastErrorPresenter({this.duration = ToastDuration.short});
}

enum ToastDuration { short, long }
