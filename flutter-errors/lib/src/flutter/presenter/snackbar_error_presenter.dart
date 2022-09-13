import '../../../flutter_errors.dart';

abstract class SnackBarErrorPresenter implements FlutterErrorPresenter<String> {
  final SnackBarDuration duration;

  SnackBarErrorPresenter({this.duration = SnackBarDuration.short});
}

enum SnackBarDuration { indefinite, short, long }
