// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handler_result.dart';

// **************************************************************************
// Generator: sealed_generators
// **************************************************************************

/// [HandlerResult]<[D] extends [Object]?, [E] extends [Object]> {
///
/// ([HandlerResultSuccess] success){[D] data} with data equality
///
/// ([HandlerResultError] error){[E] exception} with data equality
///
/// ([HandlerResultMixed] mixed){[D] data, [E] exception} with data equality
///
/// }
@SealedManifest(_HandlerResult)
abstract class HandlerResult<D extends Object?, E extends Object> {
  const HandlerResult._internal();

  const factory HandlerResult.success({
    required D data,
  }) = HandlerResultSuccess<D, E>;

  const factory HandlerResult.error({
    required E exception,
  }) = HandlerResultError<D, E>;

  const factory HandlerResult.mixed({
    required D data,
    required E exception,
  }) = HandlerResultMixed<D, E>;

  bool get isSuccess => this is HandlerResultSuccess<D, E>;

  bool get isError => this is HandlerResultError<D, E>;

  bool get isMixed => this is HandlerResultMixed<D, E>;

  HandlerResultSuccess<D, E> get asSuccess =>
      this as HandlerResultSuccess<D, E>;

  HandlerResultError<D, E> get asError => this as HandlerResultError<D, E>;

  HandlerResultMixed<D, E> get asMixed => this as HandlerResultMixed<D, E>;

  HandlerResultSuccess<D, E>? get asSuccessOrNull {
    final handlerResult = this;
    return handlerResult is HandlerResultSuccess<D, E> ? handlerResult : null;
  }

  HandlerResultError<D, E>? get asErrorOrNull {
    final handlerResult = this;
    return handlerResult is HandlerResultError<D, E> ? handlerResult : null;
  }

  HandlerResultMixed<D, E>? get asMixedOrNull {
    final handlerResult = this;
    return handlerResult is HandlerResultMixed<D, E> ? handlerResult : null;
  }

  R when<R extends Object?>({
    required R Function(D data) success,
    required R Function(E exception) error,
    required R Function(D data, E exception) mixed,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success(handlerResult.data);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error(handlerResult.exception);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed(handlerResult.data, handlerResult.exception);
    } else {
      throw AssertionError();
    }
  }

  R maybeWhen<R extends Object?>({
    R Function(D data)? success,
    R Function(E exception)? error,
    R Function(D data, E exception)? mixed,
    required R Function(HandlerResult<D, E> handlerResult) orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success != null
          ? success(handlerResult.data)
          : orElse(handlerResult);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error != null
          ? error(handlerResult.exception)
          : orElse(handlerResult);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed != null
          ? mixed(handlerResult.data, handlerResult.exception)
          : orElse(handlerResult);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `whenOrNull` instead. Will be removed by next release.')
  void partialWhen({
    void Function(D data)? success,
    void Function(E exception)? error,
    void Function(D data, E exception)? mixed,
    void Function(HandlerResult<D, E> handlerResult)? orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      if (success != null) {
        success(handlerResult.data);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else if (handlerResult is HandlerResultError<D, E>) {
      if (error != null) {
        error(handlerResult.exception);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      if (mixed != null) {
        mixed(handlerResult.data, handlerResult.exception);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else {
      throw AssertionError();
    }
  }

  R? whenOrNull<R extends Object?>({
    R Function(D data)? success,
    R Function(E exception)? error,
    R Function(D data, E exception)? mixed,
    R Function(HandlerResult<D, E> handlerResult)? orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success != null
          ? success(handlerResult.data)
          : orElse?.call(handlerResult);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error != null
          ? error(handlerResult.exception)
          : orElse?.call(handlerResult);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed != null
          ? mixed(handlerResult.data, handlerResult.exception)
          : orElse?.call(handlerResult);
    } else {
      throw AssertionError();
    }
  }

  R map<R extends Object?>({
    required R Function(HandlerResultSuccess<D, E> success) success,
    required R Function(HandlerResultError<D, E> error) error,
    required R Function(HandlerResultMixed<D, E> mixed) mixed,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success(handlerResult);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error(handlerResult);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed(handlerResult);
    } else {
      throw AssertionError();
    }
  }

  R maybeMap<R extends Object?>({
    R Function(HandlerResultSuccess<D, E> success)? success,
    R Function(HandlerResultError<D, E> error)? error,
    R Function(HandlerResultMixed<D, E> mixed)? mixed,
    required R Function(HandlerResult<D, E> handlerResult) orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success != null ? success(handlerResult) : orElse(handlerResult);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error != null ? error(handlerResult) : orElse(handlerResult);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed != null ? mixed(handlerResult) : orElse(handlerResult);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `mapOrNull` instead. Will be removed by next release.')
  void partialMap({
    void Function(HandlerResultSuccess<D, E> success)? success,
    void Function(HandlerResultError<D, E> error)? error,
    void Function(HandlerResultMixed<D, E> mixed)? mixed,
    void Function(HandlerResult<D, E> handlerResult)? orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      if (success != null) {
        success(handlerResult);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else if (handlerResult is HandlerResultError<D, E>) {
      if (error != null) {
        error(handlerResult);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      if (mixed != null) {
        mixed(handlerResult);
      } else if (orElse != null) {
        orElse(handlerResult);
      }
    } else {
      throw AssertionError();
    }
  }

  R? mapOrNull<R extends Object?>({
    R Function(HandlerResultSuccess<D, E> success)? success,
    R Function(HandlerResultError<D, E> error)? error,
    R Function(HandlerResultMixed<D, E> mixed)? mixed,
    R Function(HandlerResult<D, E> handlerResult)? orElse,
  }) {
    final handlerResult = this;
    if (handlerResult is HandlerResultSuccess<D, E>) {
      return success != null
          ? success(handlerResult)
          : orElse?.call(handlerResult);
    } else if (handlerResult is HandlerResultError<D, E>) {
      return error != null ? error(handlerResult) : orElse?.call(handlerResult);
    } else if (handlerResult is HandlerResultMixed<D, E>) {
      return mixed != null ? mixed(handlerResult) : orElse?.call(handlerResult);
    } else {
      throw AssertionError();
    }
  }
}

/// (([HandlerResultSuccess] : [HandlerResult])<[D] extends [Object]?, [E] extends [Object]> success){[D] data}
///
/// with data equality
class HandlerResultSuccess<D extends Object?, E extends Object>
    extends HandlerResult<D, E> with EquatableMixin {
  const HandlerResultSuccess({
    required this.data,
  }) : super._internal();

  final D data;

  @override
  String toString() => 'HandlerResult.success(data: $data)';

  @override
  List<Object?> get props => [
        data,
      ];
}

/// (([HandlerResultError] : [HandlerResult])<[D] extends [Object]?, [E] extends [Object]> error){[E] exception}
///
/// with data equality
class HandlerResultError<D extends Object?, E extends Object>
    extends HandlerResult<D, E> with EquatableMixin {
  const HandlerResultError({
    required this.exception,
  }) : super._internal();

  final E exception;

  @override
  String toString() => 'HandlerResult.error(exception: $exception)';

  @override
  List<Object?> get props => [
        exception,
      ];
}

/// (([HandlerResultMixed] : [HandlerResult])<[D] extends [Object]?, [E] extends [Object]> mixed){[D] data, [E] exception}
///
/// with data equality
class HandlerResultMixed<D extends Object?, E extends Object>
    extends HandlerResult<D, E> with EquatableMixin {
  const HandlerResultMixed({
    required this.data,
    required this.exception,
  }) : super._internal();

  final D data;
  final E exception;

  @override
  String toString() =>
      'HandlerResult.mixed(data: $data, exception: $exception)';

  @override
  List<Object?> get props => [
        data,
        exception,
      ];
}
