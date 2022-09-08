import '../../presenter/error_presenter.dart';
import '../observer/flutter_widget_binding_observer.dart';

abstract class FlutterErrorPresenter<T> implements ErrorPresenter<T> {
  void show(Exception throwable, FlutterWidgetBindingObserver activity, T data);
}
