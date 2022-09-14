import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';

import '../error_presenter/flutter_toast_presenter.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  FlutterExceptionHandlerBinder exceptionHandler =
      FlutterExceptionHandlerBinderImpl<String>(
          ExceptionMappers()
              .register<FormatException, String>(
                  (e) => "Format Exception registered error")
              .setFallBackValue<int>(250)
              .throwableMapper(),
          FlutterToastErrorPresenter(),
          FlutterEventsDispatcher(),
          (Exception e) {});
  final FlutterWidgetBindingObserver stateObserver =
      FlutterWidgetBindingObserverImpl();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    stateObserver.didChangeAppLifecycleState(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    exceptionHandler.bind(stateObserver);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.red,
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              test();
            },
            child: const Text("test me"),
          ),
        ),
      ),
    );
  }

  void test() {
    exceptionHandler.handle(block: () {
      debugPrint("exceptionHandlerBinder start");
      // throw const FormatException("Something is wrong");
      throw const FormatException("Format Exception");
      /*var name = await Future.delayed(
        const Duration(seconds: 2),
        () => //"my name",
            throw const FormatException("sad"),
      );*/
      //print("name >> $name");
    }).execute();

/*
    exceptionHandlerBinder.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).finallyIt(block: () {
      // Optional finally block
      // Some code
    }).execute();
*/

    /* exceptionHandlerBinder.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).catchIt<FormatException>((e) {
      // Optional finally block
      // Some code
      return false;
    }).execute();*/
  }
}
