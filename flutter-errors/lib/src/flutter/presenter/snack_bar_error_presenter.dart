import '../../../flutter_errors.dart';

abstract class SnackBarErrorPresenter<T> implements FlutterErrorPresenter<T> {
  final SnackBarDuration duration;

  SnackBarErrorPresenter({this.duration = SnackBarDuration.short});
}

enum SnackBarDuration { indefinite, short, long }
