// ignore_for_file: unnecessary_type_check

import 'package:collection/collection.dart';

import 'condition_pair.dart';
import 'fallback_value_not_found_exception.dart';

typedef ThrowableMapper<T extends Object, E extends Exception> = T Function(E);

class ExceptionMapperStorage {
  ExceptionMapperStorage._();

  static final ExceptionMapperStorage _instance = ExceptionMapperStorage._();

  static ExceptionMapperStorage get instance => _instance;

  final Map<dynamic, dynamic> _fallbackValuesMap = {
    String: "String Unknown error",
    Object: "OBject Error runtime",
  };

  final Map<Object, Map<Type, ThrowableMapper>> _mappersMap = {};
  final Map<Object, List<ConditionPair>> _conditionMappers = {};

  /// Register simple mapper (E) -> T.
  ExceptionMapperStorage
      _registerExceptionAndResult<T extends Object, E extends Exception>(
    Object resultClass,
    Type exceptionClass,
    T Function(Exception) mapper,
  ) {
    if (!_mappersMap.containsKey(T)) {
      _mappersMap[resultClass] = {};
    }
    _mappersMap[resultClass]?.putIfAbsent(exceptionClass, () => mapper);
    print("_mappersMap>>>  ${_mappersMap.toString()} ");
    return this;
  }

  /// Register mapper (E) -> T with condition (Throwable) -> Boolean.
  ExceptionMapperStorage _registerCondition<T extends Object>(
      Object resultClass, ConditionPair conditionPair) {
    if (!_conditionMappers.containsKey(T)) {
      _conditionMappers[resultClass] = [];
    }
    _conditionMappers[resultClass]?.add(conditionPair);
    print("_conditionMappers>>>  ${_conditionMappers.toString()} ");
    return this;
  }

  /// Register simple mapper (E) -> T.
  ExceptionMapperStorage register<E extends Exception, T extends Object>(
      T Function(Exception) mapper) {
    return _registerExceptionAndResult<T, E>(T, E, mapper);
  }

  /// Registers mapper (Exception) -> T with specific condition (Exception) -> Boolean.
  ExceptionMapperStorage condition<T extends Object>(
      bool Function(Exception e) condition, T Function(Exception e) mapper) {
    return _registerCondition<T>(T, ConditionPair(condition, mapper));
  }

  /// Tries to find mapper for [Exception] instance. First, a mapper with condition is
  /// looked for. If mapper with condition was not found, then a simple mapper is looked for. If
  /// the mapper was not found, it will return null.
  /// If there is no mapper for the [Exception] of class [E] and [E] does't inherits
  /// [Exception], then exception will be rethrown.
  T Function(E)? _find<E extends Exception, T>({
    required Object resultClass,
    required E exception,
    required Type exceptionClass,
  }) {
    print(
        "_find resultClass>$resultClass  exception>$exception exceptionClass>$exceptionClass");

    print("_conditionMappers>>>  ${_conditionMappers.toString()} ");

    var condition = _conditionMappers.keys.firstWhereOrNull((element) {
      print("element $element & resultClass $resultClass");
      return (resultClass == element);
    });
    //resultClass = matchedelement;
    print("Condition Matchedelement $condition");

    var mapper = _conditionMappers[condition]?.firstWhereOrNull((elements) {
      print("elements condition pairs> ${elements.condition}");
      return elements.condition(exception);
    })?.mapper;

    /*var mapper = (_conditionMappers[resultClass]
        ?.firstWhereOrNull((element) => element.condition(exception)))?.mapper;*/

    print("mapper $mapper");

    if (mapper == null) {
      print("_mappersMap>>>  ${_mappersMap.toString()} ");
      var item = _mappersMap.keys.firstWhereOrNull((element) {
        print("element $element & resultClass $resultClass");
        return (resultClass == element);
      });
      print("Mapper matchedElement $item");
      Map<dynamic, ThrowableMapper>? resultOutput = _mappersMap[item];
      print("_mappersMap[item] $resultOutput");
      mapper = resultOutput?[exceptionClass];
    }
    print("Mapper result $mapper");

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
  T Function(E)? find<E extends Exception, T>(
    E exception,
  ) {
    return _find(resultClass: T, exception: exception, exceptionClass: E);
  }

  /// Sets fallback (default) value for [T] errors type.
  ExceptionMapperStorage _setFallbackValue<T>(dynamic clazz, T value) {
    _fallbackValuesMap[clazz] = value;
    print("_fallbackValuesMap updated ${_fallbackValuesMap.toString()}");
    return this;
  }

  /// Sets fallback (default) value for [T] errors type.
  ExceptionMapperStorage setFallBackValue<T>(T value) {
    return _setFallbackValue<T>(T, value);
  }

  /// Returns fallback (default) value for [T] errors type.
  /// If there is no default value for the class [T], then [FallbackValueNotFoundException]
  /// exception will be thrown.
  T _getFallbackValue<T>(Type clazz) {
    //clazz = String;
    print(
        " looking ${clazz.runtimeType} FallbackValue in ${_fallbackValuesMap.keys.toString()}");

    var element = _fallbackValuesMap.keys.firstWhereOrNull((element) {
      print("clazz $clazz   element> $element");
      //print("clazz.runtime ${clazz.runtimeType}  element.runtime> ${element.runtimeType}");
      print(
          "clazz.runtime ${clazz.runtimeType}  element> $element match? ${element == clazz.runtimeType}");
      print("Object is $clazz is $element ${clazz == element}");
      return element == clazz;
      // return (clazz.runtimeType == element);
    });

    if (element != null) {
      print(
          "_getFallbackValue ${_fallbackValuesMap[element]} and found <T> $T ${clazz.runtimeType}");
      return _fallbackValuesMap[element] as T;
    } else {
      print("_getFallbackValue not found $clazz");
      return throw FallbackValueNotFoundException(clazz.runtimeType);
    }
  }

  /// Returns fallback (default) value for [T] errors type.
  /// If there is no default value for the class [T], then [FallbackValueNotFoundException]
  /// exception will be thrown.
  T getFallbackValue<T>() => _getFallbackValue<T>(T);

  /// Factory method that creates mappers (Throwable) -> T with a registered fallback value for
  /// class [T].
  T Function<E extends Exception>(E)
      _throwableMapper<E extends Exception, T extends Object>() {
    print("_throwableMapper>>>>>>>>>> $E $T");
    var fallback = _getFallbackValue<T>(T);
    return <E extends Exception>(E e) {
      print("_throwableMapper dynamic $E $T");
      return _find<E, T>(
                  resultClass: T, exception: e, exceptionClass: e.runtimeType)
              ?.call(e) ??
          fallback;
    };
  }

  /// Factory method that creates mappers (Throwable) -> T with a registered fallback value for
  /// class [T].
  T Function(E)
      throwableMapper<E extends Exception, T extends Object>() {
    print("throwableMapper of ");
    return throwableMappers<E, T>();
  }
}

T Function<E extends Exception>(E) throwableMappers<E extends Exception, T extends Object>() {
  return ExceptionMapperStorage.instance._throwableMapper<E, T>();
}

extension ExtException on Exception {
  T mapThrowable<E extends Exception, T extends Object>() {
    return throwableMappers<E, T>()(this);
  }
}
