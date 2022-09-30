import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:sample/sample/error_presenter/flutter_snack_bar_error_presenter.dart';
import 'package:sample/sample/exception/no_network_exception.dart';

import 'error_presenter/flutter_alert_presenter.dart';
import 'error_presenter/flutter_toast_presenter.dart';
import 'exception/alert_texts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashState(
        FlutterExceptionHandlerBinderImpl(
          exceptionMapperStorage: ExceptionMapperStorage.instance
              .register<FormatException, String>(
                  (e) => "Format Exception registered error")
              .register<NoNetworkException, AlertTexts>(
                  (e) => AlertTexts(message: "asdasd",title: "asda"))
              .condition<AlertTexts>(
                (e) {
                  return (e is NoNetworkException);
                },
                (Exception e) {
                  print("e as NoNetworkException");
                    /*return (e as NoNetworkException)
                      .mapThrowable();*/
                  return AlertTexts(
                      title: "Network Error",  message: (e as NoNetworkException)
                      .mapThrowable());

                  /*return AlertTexts(
                      title: "Network Error",
                      message: (e as NoNetworkException)
                          .mapThrowable()); //${e.mapThrowable<Exception, AlertTexts>()} "); //${(e as NoNetworkException).mapThrowable()}");*/
                },
              )
              .setFallBackValue<AlertTexts>(
                  AlertTexts(title: "title", message: "fallback message"))
              .setFallBackValue<int>(250)
              .throwableMapper(),
          flutterErrorPresenter: SelectorErrorPresenter((e) {
            switch (e.runtimeType) {
              case FormatException:
                return FlutterSnackBarErrorPresenter();

              case NoNetworkException:
                return FlutterAlertErrorPresenter();

              default:
                return FlutterToastErrorPresenter();
            }
          }),
          flutterEventsDispatcher: FlutterEventsDispatcher(),
          onCatch: (Exception e) {
            debugPrint("print stack trace ${e.toString()}");
          },
        ),
        FlutterWidgetBindingObserverImpl(),
      );
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  final FlutterExceptionHandlerBinder exceptionHandler;

  final FlutterWidgetBindingObserver stateObserver;

  SplashState(this.exceptionHandler, this.stateObserver);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    stateObserver.didChangeAppLifecycleState(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    exceptionHandler.bind(context, stateObserver);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Errors Demo'),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black26,
        alignment: Alignment.center,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    test();
                  },
                  child: const Text("test normal"),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    testFuture();
                  },
                  child: const Text("test future"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void testFuture() {
    exceptionHandler.handle<Future>(block: () async {
      await Future.delayed(
        const Duration(seconds: 2),
        () => throw NoNetworkException("No internet"),
      );
    }).execute();
  }

  void test() {
    exceptionHandler.handle(block: () {
      throw const FormatException("Format Exception");
    }).execute();
  }

  void testFinally() {
    exceptionHandler.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).finallyIt(block: () {
      // Optional finally block
      // Some code
    }).execute();
  }

  void testCatch() {
    exceptionHandler.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).catchIt<FormatException>((e) {
      // Optional finally block
      // Some code
      return false;
    }).execute();
  }
}
