import '../../../flutter_errors.dart';

abstract class AlertErrorPresenter implements FlutterErrorPresenter<String> {
  final String alertTitle;
  final String positiveButtonText;

  AlertErrorPresenter({this.alertTitle = "", this.positiveButtonText = ""});
}
