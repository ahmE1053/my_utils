import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/exceptions/general_exception.dart';

abstract class StateModelWithListenable<T> extends ChangeNotifier {
  StateModel<T> currentState;
  @protected
  void Function()? _wrappedInPostFrameCallBack;

  void init(void Function()? listener) {
    if (listener != null) {
      _wrappedInPostFrameCallBack = () {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => listener(),
        );
      };
      addListener(_wrappedInPostFrameCallBack!);
    }
  }

  void myDispose(void Function()? listener) {
    if (listener != null) {
      removeListener(_wrappedInPostFrameCallBack!);
    }
    super.dispose();
  }

  @override
  void dispose() {
    if (_wrappedInPostFrameCallBack != null) {
      removeListener(_wrappedInPostFrameCallBack!);
    }
    super.dispose();
  }

  StateModelWithListenable([
    this.currentState = const StateInitial(),
  ]);

  void _changeValue(StateModel<T> model) {
    currentState = model;
    notifyListeners();
  }

  @protected
  void toInit() => _changeValue(const StateInitial());

  @protected
  void toLoading([double? progress]) => _changeValue(StateLoading(progress));

  @protected
  void toSuccess([T? data]) {
    if (isSuccess) return;
    _changeValue(StateSuccess(data));
  }

  @protected
  void toSuccessForce([T? data]) {
    _changeValue(StateSuccess(data));
  }

  @protected
  void toError([String? errorMessage]) =>
      _changeValue(StateError(errorMessage));

  @protected
  void toErrorWithException(Object? exc) => _changeValue(
        StateErrorWithException(exc),
      );

  @protected
  void toErrorFromException(Object? exc) => _changeValue(
        StateError.fromException(exc),
      );

  bool get isError => currentState is StateError;

  bool get isErrorWithException => currentState is StateErrorWithException;

  Object? get getException =>
      (currentState as StateErrorWithException).exception;

  String get getErrorMessage => (currentState as StateError).errorMessage;

  String? get tryGetErrorMessage => currentState is StateError
      ? (currentState as StateError).errorMessage
      : null;

  bool get isSuccess => currentState is StateSuccess;

  bool get isLoading => currentState is StateLoading;

  T get value => (currentState as StateSuccess).data;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class StateError<T> extends StateModel<T> {
  final String errorMessage;

  const StateError([
    String? errorMessage,
  ]) : errorMessage = errorMessage ?? 'errorOccurred';

  factory StateError.fromException(Object? exception) {
    if (kDebugMode) {
      print(exception);
    }
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
  const StateLoading([this.progress]);

  final double? progress;

  @override
  String toString() {
    return 'StateLoading{}';
  }
}
