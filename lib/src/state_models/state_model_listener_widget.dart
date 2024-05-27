import 'package:flutter/material.dart';

import 'state_model.dart';
import 'state_model_widget.dart';

class StateModelListenerWidget<T> extends StatelessWidget {
  const StateModelListenerWidget({
    super.key,
    required this.model,
    required this.child,
    this.onFail,
    this.customError,
    this.customLoading,
    this.showError = true,
  });

  final ValueNotifier<StateModel<T>> model;
  final void Function(String message)? onFail;
  final Widget child;
  final bool showError;
  final Widget? customError;
  final Widget? customLoading;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: model,
      builder: (context, value, child) => StateModelWidget(
        stateModel: value,
        customError: customError,
        customLoading: customLoading,
        onFail: onFail,
        showError: showError,
        child: child!,
      ),
      child: child,
    );
  }
}
