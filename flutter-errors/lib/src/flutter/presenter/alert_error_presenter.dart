import '../../../flutter_errors.dart';

abstract class AlertErrorPresenter<T> extends FlutterErrorPresenter<T> {
  final String alertTitle;
  final String positiveButtonText;

  AlertErrorPresenter({this.alertTitle = "", this.positiveButtonText = ""});
}
