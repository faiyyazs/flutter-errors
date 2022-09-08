class FallbackValueNotFoundException implements Exception {
  final Type clazz;

  FallbackValueNotFoundException(this.clazz);

  String? get message => "There is no fallback value for class [$clazz]";

  @override
  String toString() => "FallbackValueNotFoundException";
}
