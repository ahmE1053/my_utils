import 'package:flutter/material.dart';

import '../../my_utils.dart';

class StateModelWithOpacityWidget<T> extends StatelessWidget {
  const StateModelWithOpacityWidget({
    super.key,
    required this.state,
    required this.onData,
    required this.onError,
    required this.onLoading,
  });

  final StateModelWithListenable<T> state;
  final Widget Function(T data) onData;
  final Widget Function(String errorMessage) onError;
  final Widget onLoading;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, child) {
        final currentState = state.currentState;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Builder(
            key: ValueKey(
              state.currentState,
            ),
            builder: (context) {
              return switch (currentState) {
                StateInitial<T>() || StateLoading<T>() => onLoading,
                StateSuccess<T>() => onData(state.value),
                StateError<T>() => onError(currentState.errorMessage),
                StateErrorWithException<T>() => onError(
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
