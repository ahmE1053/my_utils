import 'package:flutter/material.dart';

import '../core/error_column.dart';
import '../core/loading_indicator.dart';
import 'state_model.dart';

class StateModelWidget<T> extends StatelessWidget {
  const StateModelWidget({
    super.key,
    required this.stateModel,
    required this.child,
    this.onFail,
    this.customError,
    this.customLoading,
    this.errorTextColor,
    this.showError = true,
  });

  final void Function(String message)? onFail;
  final StateModel<T> stateModel;
  final Widget child;
  final bool showError;
  final Widget? customError;
  final Color? errorTextColor;
  final Widget? customLoading;

  @override
  Widget build(BuildContext context) {
    final state = stateModel;
    if (state is StateError<T>) {
      if (onFail != null) {
        onFail!(state.errorMessage);
      }
    }
    return switch (state) {
      StateInitial<T>() || StateSuccess<T>() => child,
      StateError<T>() =>
      customError ??
          (showError
              ? ErrorColumn(
            text: state.errorMessage,
            child: child,
            errorTextColor: errorTextColor,
          )
              : child),
      StateLoading<T>() => customLoading ?? const MyUtilLoadingIndicator(),
    };
  }
}
