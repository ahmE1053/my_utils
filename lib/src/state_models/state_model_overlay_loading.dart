import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class StateModelOverlayLoading<T> extends StatefulWidget {
  const StateModelOverlayLoading({
    super.key,
    required this.stateModel,
    this.loadingIndicator,
    this.errorTextColor,
    this.backgroundColor,
    this.errorTextStyle,
    this.canPopWhileLoading = false,
    required this.child,
    this.showError = true,
  });

  final Widget? loadingIndicator;
  final Color? backgroundColor;
  final Color? errorTextColor;
  final TextStyle? errorTextStyle;
  final Widget child;
  final bool canPopWhileLoading;
  final bool showError;
  final StateModelWithListenable<T> stateModel;

  static Widget? defaultLoadingIndicator;
  static TextStyle? globalStateModelErrorTextStyle;

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
    super.initState();
  }

  @override
  void dispose() {
    stateModel.removeListener(stateModelListener);
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
              child: loadingIndicator ??
                  StateModelOverlayLoading.defaultLoadingIndicator ??
                  const CircularProgressIndicator(),
            )
          ],
        ),
      ),
      child: Builder(
        builder: (context) {
          if (stateModel.isError && widget.showError) {
            return ErrorColumn(
              text: stateModel.getErrorMessage,
              errorTextColor: widget.errorTextColor,
              errorTextStyle:widget.errorTextStyle?? StateModelOverlayLoading.globalStateModelErrorTextStyle,
              child: child,
            );
          }
          return child;
        },
      ),
    );
  }
}
