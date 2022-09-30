import 'package:flutter_errors/flutter_errors.dart';
import 'package:test/test.dart';

class FlutterCustomException implements Exception {
  final int code;

  FlutterCustomException(this.code);
}

class AlertInformation {
  final String title;
  final String message;

  AlertInformation({required this.title, required this.message});
}

void main() {
  group('A group of tests', () {
    test('Fallback value', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      exceptionMapper.setFallBackValue<int>(10);
      expect(exceptionMapper.getFallbackValue<int>(), 10);
    });

    test('fallback value when no type', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      exceptionMapper.setFallBackValue(10);

      expect(exceptionMapper.getFallbackValue<int>(), 10);
    });

    test('Registered exception & message', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FormatException exception = FormatException("FE registed Exception");
      exceptionMapper
          .register<FormatException, String>((e) => exception.message);

      expect(
          exceptionMapper
              .find<FormatException, String>(exception)
              ?.call(exception),
          exception.message);
    });

    test('conditional exception & message', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);
      var alertInformation = AlertInformation(
          title: "Alert Information Error", message: "${exception.code}");
      exceptionMapper.condition<AlertInformation>(
        (e) {
          return (e is FlutterCustomException);
        },
        (Exception e) {
          return alertInformation;
        },
      );

      expect(
          exceptionMapper
              .find<FlutterCustomException, AlertInformation>(exception)
              ?.call(exception),
          alertInformation);
    });

    test('Negative Registered condition & fallback Condition exception & message', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);
      var alertInformation = AlertInformation(
          title: "Alert Information Error", message: "${exception.code}");
      var alertFallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      exceptionMapper.condition<AlertInformation>(
        (e) {
          return (e is FlutterCustomException) && (e.code == 2);
        },
        (Exception e) {
          return alertInformation;
        },
      ).setFallBackValue<AlertInformation>(alertFallBack);

      expect(
          exceptionMapper
              .throwableMapper<Exception, AlertInformation>()
              .call(exception),
          alertFallBack);
    });


    test('Positive Registered condition & fallback Condition exception & message', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);
      var alertInformation = AlertInformation(
          title: "Alert Information Error", message: "${exception.code}");
      var alertFallBack =
      AlertInformation(title: "AIE fallBack", message: "fallBack");
      exceptionMapper.condition<AlertInformation>(
            (e) {
          return (e is FlutterCustomException) && (e.code == 1);
        },
            (Exception e) {
          return alertInformation;
        },
      ).setFallBackValue<AlertInformation>(alertFallBack);

      expect(
          exceptionMapper
              .throwableMapper<Exception, AlertInformation>()
              .call(exception),
          alertInformation);
    });

    test('exception mapper string fallback', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);
      FormatException formatException =
          FormatException("FE registed Exception");
      var alertInformation = AlertInformation(
          title: "Alert Information Error", message: "${exception.code}");
      var fallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      var stringFallBack = "String fallback";
      exceptionMapper
          .condition<AlertInformation>(
            (e) {
              return (e is FlutterCustomException) && (e.code == 2);
            },
            (Exception e) {
              return alertInformation;
            },
          )
          .setFallBackValue<AlertInformation>(fallBack)
          .setFallBackValue(stringFallBack);

      expect(
          exceptionMapper
              .throwableMapper<Exception, String>()
              .call(formatException),
          stringFallBack);
    });

    test('exceptions mapThrowable', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);

      late AlertInformation alertInformation;
      var fallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      var stringFallBack = "String fallback";
      exceptionMapper
          .condition<AlertInformation>(
            (e) {
              return (e is FlutterCustomException) && (e.code == 1);
            },
            (Exception e) {
              return alertInformation = AlertInformation(
                  title: "Alert Information Error",
                  message: exception.mapThrowable());
            },
          )
          .setFallBackValue<AlertInformation>(fallBack)
          .setFallBackValue(stringFallBack);

      print(
          " my custome message ${exceptionMapper.throwableMapper<Exception, AlertInformation>().call(exception).message}");

      expect(
          exceptionMapper
              .throwableMapper<Exception, AlertInformation>()
              .call(exception),
          alertInformation);
    });

    test('exceptions MapperThrowable condition', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException exception = FlutterCustomException(1);
      late AlertInformation alertInformation;
      var fallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      var stringFallBack = "String fallback";
      exceptionMapper
          .register<FlutterCustomException, String>(
              (e) => "code ${(exception).code}")
          .condition<AlertInformation>(
            (e) {
              return (e is FlutterCustomException) && (e.code == 1);
            },
            (Exception e) {
              return alertInformation = AlertInformation(
                  title: "Alert Information Error",
                  message:
                      exception.mapThrowable<FlutterCustomException, String>());
            },
          )
          .setFallBackValue<AlertInformation>(fallBack)
          .setFallBackValue(stringFallBack);

      print(
          " my custome message ${exceptionMapper.throwableMapper<Exception, AlertInformation>().call(exception).message}");

      expect(
          exceptionMapper
              .throwableMapper<Exception, AlertInformation>()
              .call(exception),
          alertInformation);
    });

    test('exceptions mapper throwable', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException flutterCustomException = FlutterCustomException(1);
      late AlertInformation alertInformation;
      var fallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      var stringFallBack = "String fallback";
      exceptionMapper
          .register<FlutterCustomException, AlertInformation>((e) {
            return alertInformation = AlertInformation(
                title: 'Custom Exception',
                message: '${(e as FlutterCustomException).code}');
          })
          .condition<AlertInformation>(
            (e) {
              return (e is FlutterCustomException) && (e.code == 2);
            },
            (Exception e) {
              return alertInformation = AlertInformation(
                  title: "Alert Information Error",
                  message: flutterCustomException
                      .mapThrowable<FlutterCustomException, String>());
            },
          )
          .setFallBackValue<AlertInformation>(fallBack)
          .setFallBackValue(stringFallBack);

      print(
          "expected result ${exceptionMapper.throwableMapper<Exception, AlertInformation>().call(flutterCustomException)}");

      expect(
          exceptionMapper
              .throwableMapper<Exception, AlertInformation>()
              .call(flutterCustomException),
          alertInformation);
    });

    test('exceptions mapper dynamic', () {
      final exceptionMapper = ExceptionMapperStorage.instance;
      FlutterCustomException flutterCustomException = FlutterCustomException(1);
      FormatException formatException =
          FormatException("FE registed Exception");
      // ignore: unused_local_variable
      late AlertInformation alertInformation;
      var fallBack =
          AlertInformation(title: "AIE fallBack", message: "fallBack");
      var stringFallBack = "String fallback";
      exceptionMapper
          .register<FlutterCustomException, AlertInformation>((e) {
            return alertInformation = AlertInformation(
                title: 'Custom Exception',
                message: '${(e as FlutterCustomException).code}');
          })
          .condition<AlertInformation>(
            (e) {
              return (e is FlutterCustomException) && (e.code == 2);
            },
            (Exception e) {
              return alertInformation = AlertInformation(
                  title: "Alert Information Error",
                  message: flutterCustomException
                      .mapThrowable<FlutterCustomException, String>());
            },
          )
          .setFallBackValue<AlertInformation>(fallBack)
          .setFallBackValue(dynamic)
          .setFallBackValue(stringFallBack);

      expect(
          exceptionMapper
              .throwableMapper<Exception, String>()
              .call(formatException),
          stringFallBack);
    });
  });

  test('Object Checks', () {
    Object object = AlertInformation(
      title: '',
      message: '',
    );
    print("object is String ${object.runtimeType == String}");
    print("object is int ${object.runtimeType == int}");
    print("object is AlertInformation ${object.runtimeType == AlertInformation}");
  });

  test('dynamic Checks', () {
    dynamic dynamo = AlertInformation(
      title: '',
      message: '',
    );
    print("object is String ${dynamo is String}");
    print("object == String ${dynamo.runtimeType == String}");
    print("object is String ${dynamo.runtimeType == int}");
    print("object == String ${dynamo.runtimeType == AlertInformation}");
    print("object is String ${dynamo is AlertInformation}");
  });
}
