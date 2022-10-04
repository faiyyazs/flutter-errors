import '../../../flutter_errors.dart';

abstract class SnackBarErrorPresenter<T> extends FlutterErrorPresenter<T> {
  final SnackBarDuration duration;

  SnackBarErrorPresenter({this.duration = SnackBarDuration.short});
}

enum SnackBarDuration { short, long }
