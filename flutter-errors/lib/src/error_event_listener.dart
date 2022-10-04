abstract class ErrorEventListener<T> {
  Type resolvePresenterType(Exception throwable);

  void showError(Exception throwable, T data);
}
