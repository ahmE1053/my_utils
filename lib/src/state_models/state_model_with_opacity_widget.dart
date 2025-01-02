import 'package:flutter/material.dart';

import '../../my_utils.dart';

class StateModelWithOpacityWidget<T> extends StatelessWidget {
  const StateModelWithOpacityWidget({
    super.key,
    required this.state,
    required this.onData,
    required this.onError,
    required this.onLoading,
    this.customKeyOnSuccess,
    this.alignment,
  });

  final StateModelWithListenable<T> state;
  final Widget Function(T data) onData;
  final Widget Function(String errorMessage) onError;
  final Widget onLoading;
  final AlignmentGeometry? alignment;
  final dynamic Function(T? data)? customKeyOnSuccess;

  ValueKey getKey(StateModel<T> state) {
    if (state is StateSuccess<T> && customKeyOnSuccess != null) {
      return ValueKey(
        customKeyOnSuccess!(state.data) ?? state,
      );
    }
    return ValueKey(state);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, child) {
        final currentState = state.currentState;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          layoutBuilder: (currentChild, previousChildren) =>
              Stack(
                alignment: alignment ?? Alignment.center,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
          child: Builder(
            key: getKey(currentState),
            builder: (context) {
              return switch (currentState) {
                StateInitial<T>() || StateLoading<T>() => onLoading,
                StateSuccess<T>() => onData(state.value),
                StateError<T>() => onError(currentState.errorMessage),
                StateErrorWithException<T>() =>
                    onError(
                      currentState.exception is GeneralException
                          ? (currentState.exception as GeneralException).message
                          : 'errorOccurred',
                    ),
              };
            },
          ),
        );
      },
    );
  }
}
