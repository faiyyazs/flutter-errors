import 'exception_mappers.dart';

class ConditionPair {
  final bool Function(Exception element) condition;

  final ThrowableMapper mapper;

  ConditionPair(
    this.condition,
    this.mapper,
  );
}
