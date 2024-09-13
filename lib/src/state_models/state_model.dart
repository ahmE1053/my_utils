import 'package:flutter/material.dart';

import '../core/exceptions/general_exception.dart';

abstract class StateModelWithListenable<T> extends ChangeNotifier {
  StateModel<T> currentState;
  void Function()? wrappedInPostFrameCallBack;

  void init(void Function()? listener) {
    if (listener != null) {
      wrappedInPostFrameCallBack = () {
        WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) => listener(),
        );
      };
      addListener(wrappedInPostFrameCallBack!);
    }
  }

  void myDispose(void Function()? listener) {
    if (listener != null) {
      removeListener(wrappedInPostFrameCallBack!);
    }
    super.dispose();
  }

  @override
  void dispose() {
    if (wrappedInPostFrameCallBack != null) {
      removeListener(wrappedInPostFrameCallBack!);
    }
    super.dispose();
  }

  StateModelWithListenable([this.currentState = const StateInitial(),]);

  void changeValue(StateModel<T> model) {
    currentState = model;
    notifyListeners();
  }

  void toLoading() => changeValue(const StateLoading());

  void toSuccess([T? data]) => changeValue(StateSuccess(data));

  void toError([String? errorMessage]) => changeValue(StateError(errorMessage));

  void toErrorWithException(Object? exc) =>
      changeValue(
        StateErrorWithException(exc),
      );

  void toErrorFromException(Object? exc) =>
      changeValue(
        StateError.fromException(exc),
      );

  bool get isError => currentState is StateError;

  bool get isErrorWithException => currentState is StateErrorWithException;

  Object? get getException =>
      (currentState as StateErrorWithException).exception;

  String get getErrorMessage => (currentState as StateError).errorMessage;

  String? get tryGetErrorMessage =>
      currentState is StateError
          ? (currentState as StateError).errorMessage
          : null;

  bool get isSuccess => currentState is StateSuccess;

  bool get isLoading => currentState is StateLoading;

  T get value => (currentState as StateSuccess).data!;

  T? get tryGetValue =>
      currentState is StateSuccess ? (currentState as StateSuccess).data : null;
}

@immutable
sealed class StateModel<T> {
  const StateModel();

  @override
  String toString() {
    return 'StateModel';
  }
}

class StateInitial<T> extends StateModel<T> {
  const StateInitial();

  @override
  String toString() {
    return 'StateInitial';
  }
}

class StateSuccess<T> extends StateModel<T> {
  final T? data;

  const StateSuccess([this.data]);

  @override
  String toString() {
    return 'StateSuccess{ data: $data }';
  }
}

class StateError<T> extends StateModel<T> {
  final String errorMessage;

  const StateError([
    String? errorMessage,
  ]) : errorMessage = errorMessage ?? 'errorOccurred';

  factory StateError.fromException(Object? exception) {
    print(exception);
    return StateError(
      exception is GeneralException ? exception.message : 'errorOccurred',
    );
  }

  @override
  String toString() {
    return 'StateError{errorMessage: $errorMessage}';
  }
}

class StateErrorWithException<T> extends StateModel<T> {
  final Object? exception;

  const StateErrorWithException(this.exception);

  @override
  String toString() {
    return 'StateErrorWithException{errorMessage: ${exception.toString()}}';
  }
}

class StateLoading<T> extends StateModel<T> {
  const StateLoading();

  @override
  String toString() {
    return 'StateLoading{}';
  }
}
