import 'package:sealed_annotations/sealed_annotations.dart';

part 'handler_result.sealed.dart';

@Sealed()
// ignore: unused_element
abstract class _HandlerResult<D, E extends Object> {
  void success(D data);

  void error(E exception);

  void mixed(D data, E exception);
}
