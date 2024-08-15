import 'package:flutter/foundation.dart';

import '../core/exceptions/general_exception.dart';

abstract class StateModelWithListenable<T> extends ChangeNotifier {
  StateModel<T> currentModel;

  void init(void Function()? listener) {
    if (listener != null) {
      addListener(listener);
    }
  }

  void myDispose(void Function()? listener) {
    if (listener != null) {
      removeListener(listener);
    }
    super.dispose();
  }

  StateModelWithListenable({
    this.currentModel = const StateInitial(),
  });

  void changeValue(StateModel<T> model) {
    currentModel = model;
    notifyListeners();
  }

  void toLoading() => changeValue(const StateLoading());

  void toSuccess([T? data]) => changeValue(StateSuccess(data));

  void toError([String? errorMessage]) => changeValue(StateError(errorMessage));

  void toErrorFromException(Object exc) =>
      changeValue(
        StateError.fromException(exc),
      );

  bool get isError => currentModel is StateError;

  String get getErrorMessage => (currentModel as StateError).errorMessage;

  bool get isSuccess => currentModel is StateSuccess;

  bool get isLoading => currentModel is StateLoading;

  T get value => (currentModel as StateSuccess).data!;

  T? get tryGetValue => (currentModel as StateSuccess).data;
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

  factory StateError.fromException(Object exception) {
    return StateError(
      exception is GeneralException ? exception.message : 'errorOccurred',
    );
  }

  @override
  String toString() {
    return 'StateError{errorMessage: $errorMessage}';
  }
}

class StateLoading<T> extends StateModel<T> {
  const StateLoading();

  @override
  String toString() {
    return 'StateLoading{}';
  }
}
