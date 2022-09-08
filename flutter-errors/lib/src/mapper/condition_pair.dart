import 'exception_mappers_storage.dart';

class ConditionPair {
  final bool Function(Exception element) condition;

  final ThrowableMapper mapper;

  ConditionPair(
    this.condition,
    this.mapper,
  );
}
