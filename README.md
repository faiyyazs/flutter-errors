# flutter-errors
Automated Exceptions handler for Flutter development.

# Welcome to Flutter errors

**See the [project's website](https://faiyyazs.github.io/flutter-errors/) for the full documentation.**

Flutter Errors provides a neat way to handle exceptions for your flutter applications inspired by the [Moko errors library](https://github.com/icerockdev/moko-errors).
It comes with automatic mapping between globally registered exceptions and exceptions raised while performing some actions or use cases.
This library provides automatic exception handling and automatic error displaying to a screen.

- null-safe
- typesafe
- reactive
- lifecycle aware
- lightweight
- iOS, Android, Linux, macOS, Web, Windows

!!! important
The library is open to contributions!
Refer to [GitHub Discussions](https://github.com/faiyyazs/flutter-errors/discussions) for questions, ideas, and discussions.

[![pub package](https://img.shields.io/pub/v/flutter-errors.svg)](https://pub.dartlang.org/packages/flutter-errors) [![build status](https://github.com/faiyyazs/flutter-errors/actions/workflows/ci.yml/badge.svg)](https://github.com/faiyyazs/flutter-errors/actions/workflows/ci.yml)

## Setup Dependencies

Add the runtime dependency `flutter-errors` to your `pubspec.yaml`.

- `flutter-errors` holds all the code you are going to use in your application.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter-errors: ^1.0.0
```
## Features

- `ExceptionMappers` singleton object, storage that stores a set of exception converters to error classes required for `ErrorPresenter` objects.
- `ExceptionHandler` implements safe code execution and automatic exception display using `ErrorPresenter`.
- `ErrorPresenter` classes implements a strategy for displaying exceptions in a user-friendly form on the platforms. Converts the exception class to an error object to display.

There are several `ErrorPresenter` implementations:

1. `AlertErrorPresenter` - displays errors text in alert dialogs.
2. `ToastErrorPresenter` - displays errors text in toasts
3. `SnackBarErrorPresenter` - displays errors text in snackbar.
4. `SelectorErrorPresenter` - for selecting error presenter by some custom condition.

## Usage

#### ExceptionMappers

Register a simple custom exceptions mapper in the singleton storage:

```dart
ExceptionMappers.instance
    .register<NetworkError, String>( // Will map all NetworkError instances to String
        (e) => "NetworkError registered error")
    .register<HttpException, String>( // Will map all HttpException instances to String
        (e) => "Format Exception registered error");
```

Registration of custom exception mapper with condition:


```dart
ExceptionMappers.instance
    .condition<NetworkError>(  // Registers exception mapper Exception -> String
        (e) => e is NetworkError && e.error.code == 1, // Condition that maps Exception -> Boolean
        (e) => "My Custom Error from mapper"); // Mapper for Exception that matches to the condition
```

For every error type you should to set fallback (default) value using method `setFallbackValue`

```dart
ExceptionMappers.instance
    .setFallbackValue<Int>(250); // Sets for Int error type default value as 250
```

```
// Creates new mapper that for any unregistered exception will return the fallback value - 250
val throwableToStringMapper: (Exception) -> String = ExceptionMappers.instance.throwableMapper()
```

Using factory method `throwableMapper` you can create exception mappers automaticlly:

```dart
String Function(Exception) throwableToIntMapper = ExceptionMappers.throwableMapper();
```

If a default value is not found when creating a mapper using factory method `throwableMapper`, an exception will be thrown `FallbackValueNotFoundException`

The registration can be done in the form of an endless chain:

```dart
ExceptionMappers.instance
    .condition<String>(
        (e) => e is NetworkError && e.error.code == 1,
        (e) => "My custom error from mapper")
    .register<NetworkError, String>(
        (e) => "NetworkError registered error")
    .register<FormatException, String>(
        (e) => "Format Exception registered error")
    .register<HttpException, Int>(
        (e) => e.error.code,)
    .setFallbackValue<Int>(250);
```

#### ExceptionHandler

1. Declare `ExceptionHandler` property in some `ViewModel` class:

```dart
class SimpleViewModel extends ViewModel {
  final FlutterExceptionHandlerBinder exceptionHandler;
  
  SimpleViewModel(this.exceptionHandler,) 
    // ...
}
```

2. Bind `ExceptionHandler` in the platform code.


On Base page or Page State register `WidgetsBindingObserver` & FlutterWidgetBindingObserver
```dart
class Page extends State with WidgetsBindingObserver{
    final FlutterWidgetBindingObserver stateObserver =
          FlutterWidgetBindingObserverImpl();

    @override
    void initState() {
      WidgetsBinding.instance.addObserver(this);
      super.initState();
    }
    
    @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      stateObserver.didChangeAppLifecycleState(state);
      super.didChangeAppLifecycleState(state);
    }
}

```
then in `initState` of `StatefulWidget` or `onModel` ready of `viewmodel` bind the observer:

```kotlin
viewModel.exceptionHandler.bind(
   super.stateObserver
);
```
3.Creating instances of `ExceptionHandler` class which uses `(Exception) -> String` mappers:

```dart
 FlutterExceptionHandlerBinderImpl<String>(
       ExceptionMappers.instance.throwableMapper(), // Create mapper (Exception) -> String from ExceptionMappers
       errorsPresenterInstance,                    // Concrete ErrorPresenter implementation
       FlutterEventsDispatcher(),
       (e){                                                  // Optional global catcher
           println("Got exception: $e");                           // E.g. here we can log all exceptions that are handled by ExceptionHandler
       }
 );
```
4. And use it to safe requests in `ViewModel`:

```dart
 void onMakeRequest() {
          exceptionHandlerBinder.handle(block: (){
             serverRequest();     // Some dangerous code that can throw an exception
          }).finallyIt(block: (){ // Optional finally block
             // Some code  
          }).execute();           // Starts code execution 
       
 }
```

5. Also you can add some custom `catch` handlers for `ExceptionHandler` that work as a catch in the try/catch operator:

```dart
void onMakeRequest() {
          exceptionHandlerBinder.handle(block: (){
             serverRequest();     // Some dangerous code that can throw an exception
          }).catchIt<FormatException>((FormatException e){   // Specifying exception class
            // Some custom handler code
              return false;       // true - cancels ErrorPresenter; false - allows execution of ErrorsPresenter
          }).execute();           // Starts code execution 
       
}
```

#### ErrorPresenter

There are `ErrorPresenter` interface implementations:
* `AlertErrorPresenter` - displays errors text in alert dialogs;
* `ToastErrorPresenter` - displays errors text in toasts;
* `SnackBarErrorPresenter` - displays errors text in snackbar;
* `SelectorErrorPresenter` - for selecting error presenter by some custom condition.

You need to pass some `ErrorPresenter` to `ErrorHandler` instance. E.g. creation of error presenters
in common code:

...


## Samples
Please see more examples in the [sample directory](https://github.com/faiyyazs/flutter-errors/tree/main/sample).



## License

    Copyright 2022 Faiyyaz S.
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
       http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
