import 'package:flutter/foundation.dart' show immutable;

import '../core/exceptions/general_exception.dart';

@immutable
sealed class StateModel<T> {
  const StateModel();

  @override
  String toString() {
    return 'StateModel{}';
  }
}

class StateInitial<T> extends StateModel<T> {
  const StateInitial();

  @override
  String toString() {
    return 'StateInitial{}';
  }
}

class StateSuccess<T> extends StateModel<T> {
  final T? data;

  const StateSuccess([this.data]);

  @override
  String toString() {
    return 'StateSuccess{data: $data}';
  }
}

class StateError<T> extends StateModel<T> {
  final String errorMessage;

  const StateError([
    String? errorMessage,
  ]) : errorMessage = errorMessage ?? 'errorOccurred';

  factory StateError.fromException(Exception exception) {
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
