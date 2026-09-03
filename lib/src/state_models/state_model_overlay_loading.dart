import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class StateModelOverlayLoading<T> extends StatefulWidget {
  const StateModelOverlayLoading({
    super.key,
    required this.stateModel,
    this.loadingIndicator,
    this.errorTextColor,
    this.backgroundColor,
    this.modelStateListener,
    this.errorTextStyle,
    this.loadingIndicatorWithProgress,
    this.canPopWhileLoading = false,
    required this.child,
    this.showError = true,
  });

  final Widget? loadingIndicator;
  final Widget Function(double progress)? loadingIndicatorWithProgress;
  final void Function()? modelStateListener;
  final Color? backgroundColor;
  final Color? errorTextColor;
  final TextStyle? errorTextStyle;
  final Widget child;
  final bool canPopWhileLoading;
  final bool showError;
  final StateModelWithListenable<T> stateModel;

  static Widget? defaultLoadingIndicator;
  static TextStyle? globalStateModelErrorTextStyle;

  /// Optional hook to map a raw (possibly server-provided) error message to a
  /// localized, user-friendly string before it is shown. Apps can wire this to
  /// their localization/error-code table so raw backend strings never leak to
  /// users. When null the original message is used unchanged.
  static String Function(String rawMessage)? errorMessageResolver;

  @override
  State<StateModelOverlayLoading<T>> createState() =>
      _StateModelOverlayLoadingState<T>();
}

class _StateModelOverlayLoadingState<T>
    extends State<StateModelOverlayLoading<T>> {
  Widget? get loadingIndicator => widget.loadingIndicator;

  Color? get backgroundColor => widget.backgroundColor;

  Widget get child => widget.child;

  StateModelWithListenable<T> get stateModel => widget.stateModel;
  final overlayController = OverlayPortalController();

  void stateModelListener() {
    setState(() {});
    if (stateModel.isLoading && !overlayController.isShowing) {
      overlayController.show();
      return;
    }
    if (!stateModel.isLoading && overlayController.isShowing) {
      overlayController.hide();
      return;
    }
  }

  @override
  void initState() {
    stateModel.addListener(stateModelListener);
    if (widget.modelStateListener != null) {
      stateModel.addListener(widget.modelStateListener!);
    }
    super.initState();
  }

  @override
  void dispose() {
    stateModel.removeListener(stateModelListener);
    if (widget.modelStateListener != null) {
      stateModel.removeListener(widget.modelStateListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal.targetsRootOverlay(
      controller: overlayController,
      overlayChildBuilder: (context) => PopScope(
        canPop: widget.canPopWhileLoading || !stateModel.isLoading,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: backgroundColor ?? Colors.black26,
            ),
            Center(
              child: ListenableBuilder(
                listenable: stateModel,
                builder: (context, child) {
                  final state = stateModel.currentState;
                  if (state is StateLoading<T> && state.progress != null) {
                    return widget.loadingIndicatorWithProgress?.call(
                          state.progress!,
                        ) ??
                        CircularProgressIndicator(value: state.progress);
                  }
                  return loadingIndicator ??
                      StateModelOverlayLoading.defaultLoadingIndicator ??
                      const CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
      child: Builder(
        builder: (context) {
          if (stateModel.isError && widget.showError) {
            final rawMessage = stateModel.getErrorMessage;
            return ErrorColumn(
              text: StateModelOverlayLoading.errorMessageResolver
                      ?.call(rawMessage) ??
                  rawMessage,
              errorTextColor: widget.errorTextColor,
              errorTextStyle: widget.errorTextStyle ??
                  StateModelOverlayLoading.globalStateModelErrorTextStyle,
              child: child,
            );
          }
          return child;
        },
      ),
    );
  }
}
