import 'error_presenter.dart';

abstract class SnackBarErrorPresenter implements ErrorPresenter<String> {
  final SnackBarDuration duration;

  SnackBarErrorPresenter({this.duration = SnackBarDuration.short});
}

enum SnackBarDuration { indefinite, short, long }
