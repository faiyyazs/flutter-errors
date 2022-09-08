// ignore_for_file: unnecessary_type_check

import 'package:collection/collection.dart';

import 'condition_pair.dart';
import 'fallback_value_not_found_exception.dart';

typedef ThrowableMapper = Function(Exception);

class ExceptionMappersStorage {
  final Map<Type, dynamic> _fallbackValuesMap = {String: ""};

  final Map<Type, Map<Type, ThrowableMapper>> _mappersMap = {};
  final Map<Type, List<ConditionPair>> _conditionMappers = {};

  /// Register simple mapper (E) -> T.
  ExceptionMappersStorage _register<T, E extends Exception>(
    Type resultClass,
    Type exceptionClass,
    T Function(Exception) mapper,
  ) {
    if (!_mappersMap.containsKey(T)) {
      _mappersMap[resultClass] = {};
    }
    _mappersMap[resultClass]?.putIfAbsent(exceptionClass, () => mapper);

    return this;
  }

  /// Register mapper (E) -> T with condition (Throwable) -> Boolean.
  ExceptionMappersStorage _registerCondition<T>(
      Type resultClass, ConditionPair conditionPair) {
    if (!_conditionMappers.containsKey(T)) {
      _conditionMappers[resultClass] = [];
    }
    _conditionMappers[resultClass]?.add(conditionPair);
    return this;
  }

  /// Register simple mapper (E) -> T.
  ExceptionMappersStorage registerSimpleMapper<E extends Exception, T>(
      T Function(Exception) mapper) {
    return _register<T, E>(T, E, mapper);
  }

  /// Registers mapper (Exception) -> T with specific condition (Exception) -> Boolean.
  ExceptionMappersStorage registerConditionAndMapper<T>(
      bool Function(Exception e) condition, T Function(Exception e) mapper) {
    return _registerCondition(T, ConditionPair(condition, mapper));
  }

  /// Tries to find mapper for [Exception] instance. First, a mapper with condition is
  /// looked for. If mapper with condition was not found, then a simple mapper is looked for. If
  /// the mapper was not found, it will return null.
  /// If there is no mapper for the [Exception] of class [E] and [E] does't inherits
  /// [Exception], then exception will be rethrown.
  T Function(E)? _find<E extends Exception, T>({
    required Type resultClass,
    required E exception,
    required Type exceptionClass,
  }) {
    var mapper = (_conditionMappers[resultClass]
        ?.firstWhereOrNull((element) => element.condition(exception)))?.mapper;

    if (mapper == null) {
      Map<Type, ThrowableMapper>? result = _mappersMap[resultClass];
      mapper = result?[exceptionClass];
    }

    if (mapper == null && (exception is! Exception)) {
      throw exception;
    } else {
      return mapper as T Function(E)?;
    }
  }

  /// Tries to find mapper (E) -> T by [throwable] instance. First, a mapper with condition is
  /// looked for. If mapper with condition was not found, then a simple mapper is looked for. If
  /// the mapper was not found, it will return null.
  /// If there is no mapper for the [throwable] of class [E] and [E] does't inherits
  /// [kotlin.Exception], then exception will be rethrown.
  T Function(Exception)? findMapper<E extends Exception, T extends Type>(
    Exception exception,
  ) {
    return _find(
        resultClass: T.runtimeType,
        exception: exception,
        exceptionClass: E.runtimeType);
  }

  /// Sets fallback (default) value for [T] errors type.
  ExceptionMappersStorage _setFallbackValue<T>(Type clazz, T value) {
    _fallbackValuesMap[clazz] = value;
    return this;
  }

  /// Sets fallback (default) value for [T] errors type.
  ExceptionMappersStorage setDefaultFallBackValue<T>(T value) {
    return _setFallbackValue(T.runtimeType, value);
  }

  /// Returns fallback (default) value for [T] errors type.
  /// If there is no default value for the class [T], then [FallbackValueNotFoundException]
  /// exception will be thrown.
  T _getFallbackValue<T>(Type clazz) {
    var result = _fallbackValuesMap[clazz] as T;
    //result ??= throw  FallbackValueNotFoundException(clazz);
    return result;
  }

  /// Returns fallback (default) value for [T] errors type.
  /// If there is no default value for the class [T], then [FallbackValueNotFoundException]
  /// exception will be thrown.
  T getDefaultFallbackValue<T>() => _getFallbackValue(T.runtimeType);

  /// Factory method that creates mappers (Throwable) -> T with a registered fallback value for
  /// class [T].
  T Function(Exception) _throwableMapper<E extends Exception, T>(Type clazz) {
    var fallback = _getFallbackValue(clazz);
    return (e) =>
        _find(resultClass: clazz, exception: e, exceptionClass: e.runtimeType)
            ?.call(e) ??
        fallback;
  }

  /// Factory method that creates mappers (Throwable) -> T with a registered fallback value for
  /// class [T].
  T Function(Exception) defaultThrowableMapper<E extends Exception, T>() {
    return _throwableMapper(String);
  }
}
