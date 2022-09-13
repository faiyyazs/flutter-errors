import '../../../flutter_errors.dart';

abstract class SelectorErrorPresenter<T> implements FlutterErrorPresenter<T> {
  final FlutterErrorPresenter<T> Function(Exception) errorPresenterSelector;

  SelectorErrorPresenter(this.errorPresenterSelector);
}
