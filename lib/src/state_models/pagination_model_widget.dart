import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/base_shimmer.dart';
import '../core/consts/app_localization_keys.g.dart';
import '../core/exceptions/general_exception.dart';
import '../core/full_screen_error_widget.dart';
import '../core/loading_indicator.dart';
import 'pagination_state_model.dart';

class PaginationStateModelWidget<T> extends StatefulWidget {
  const PaginationStateModelWidget({
    super.key,
    required this.stateModel,
    required this.onRequestNewData,
    required this.onErrorRetry,
    required this.onError,
    required this.child,
    this.shimmerPadding,
    this.initialCall,
    this.isLastPage,
    this.bottomInset,
    this.topInset,
    this.scrollablePadding,
    this.upperScrollController,
    this.initialLoadingWidget,
    this.initialErrorPadding,
    this.emptyState,
    this.shimmerExtent,
    this.useItemExtent = false,
    this.sliverGridDelegate,
    this.initialErrorWidget,
    this.pageStorageKey,
    this.scrollDirection = Axis.vertical,
  }) : assert(sliverGridDelegate != null || shimmerExtent != null);

  ///a notifier to stop this widget from making new requests
  final ValueNotifier<bool>? isLastPage;

  ///the model that data and states will come from
  final PaginationStateModel<T> stateModel;

  ///What the actual child will be
  final Widget Function(T item) child;

  //when no items are available
  final Widget? emptyState;

  ///Initial error widget
  final Widget? initialErrorWidget;

  ///Initial error widget
  final Widget? initialLoadingWidget;

  ///scroll direction that will be used in either
  ///[ListView] or [GridView]
  final Axis scrollDirection;

  ///send if you want to offset from the bottom by this value
  final double? bottomInset;

  ///send if you want to use a custom padding for shimmer
  final EdgeInsets? shimmerPadding;

  ///Padding for initial error widget
  final EdgeInsets? initialErrorPadding;

  ///Padding for scrollables
  final EdgeInsets? scrollablePadding;

  ///send if you want to offset from the top by this value
  final double? topInset;

  ///limit [child] size by shimmer extent + bottom padding or not
  final bool useItemExtent;

  ///what to do when scrolling to the bottom
  final void Function(List<T> oldData) onRequestNewData;

  ///what to do when having an error when paginating
  final void Function(List<T> oldData) onErrorRetry;

  ///will be called in init state
  ///maybe used to make the api call
  final void Function()? initialCall;

  ///what to do in case of initial error
  final void Function() onError;

  ///send to make it part of an already scrollable widget
  ///null if you want to create its own scrollable widget
  final ScrollController? upperScrollController;

  ///make null if you want to use [ListView]
  ///send value if you want to use [GridView]
  final SliverGridDelegate? sliverGridDelegate;

  ///The extent for the [BaseShimmer] widget in the given axis
  final double? shimmerExtent;

  ///Page Storage key for the scrollable
  final PageStorageKey? pageStorageKey;

  @override
  State<PaginationStateModelWidget<T>> createState() =>
      _PaginationStateModelWidgetState<T>();
}

class _PaginationStateModelWidgetState<T>
    extends State<PaginationStateModelWidget<T>> {
  bool isLoading = false;
  late final ScrollController scrollController;
  late final void Function() scrollListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(
          () => widget.initialCall?.call(),
    );
    scrollController = ScrollController();
    scrollListener = () {
      final scroll = widget.upperScrollController ?? scrollController;
      if (widget.isLastPage?.value ?? false) return;
      if (scroll.position.maxScrollExtent - scroll.offset < 120) {
        final state = widget.stateModel;
        if (state is PaginationStateSuccess<T>) {
          widget.onRequestNewData(state.data);
        }
      }
    };
    if (widget.upperScrollController != null) {
      widget.upperScrollController!.addListener(scrollListener);
    } else {
      scrollController.addListener(scrollListener);
    }
  }

  @override
  void dispose() {
    if (widget.upperScrollController != null) {
      widget.upperScrollController!.removeListener(scrollListener);
    } else {
      scrollController.removeListener(scrollListener);
    }
    scrollController.dispose();
    super.dispose();
  }

  void checkIfNotScrollable(_) {
    final state = widget.stateModel;

    try {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent == 0.0) {
        if (state is PaginationStateSuccess<T>) {
          widget.onRequestNewData(state.data);
        }
      }
    }
    catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.stateModel;
    WidgetsBinding.instance.addPostFrameCallback(checkIfNotScrollable);
    final thisWidget = switch (state) {
      PaginationStateInitial<T>() ||
      PaginationStateLoading<T>() =>
          getLoadingCards(),
      PaginationStateSuccess<T>(data: var data) => getChildWidget(data, false),
      PaginationStateError<T>() =>
          Padding(
            padding: widget.initialErrorPadding ?? EdgeInsets.zero,
            child: widget.initialErrorWidget ??
                FullScreenError(
                  onTap: widget.onError,
                  exception: GeneralException(state.errorMessage),
                ),
          ),
      PaginationStateLoadingWithData<T>(oldData: var data) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getChildWidget(data, true),
              const SizedBox(height: 8),
              const MyUtilLoadingIndicator(),
              SizedBox(height: widget.bottomInset),
            ],
          ),
      PaginationStateErrorWithData<T>(
      oldData: var data,
      errorMessage: var error
      ) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getChildWidget(data, true),
              const SizedBox(height: 8),
              Text(
                error.tr(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => widget.onErrorRetry(data),
                  child: Text(
                    LocaleKeys.retry.tr(),
                  ),
                ),
              ),
              SizedBox(height: widget.bottomInset),
            ],
          ),
    };
    if (widget.upperScrollController != null) {
      return thisWidget;
    }
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: widget.scrollDirection,
      child: thisWidget,
    );
  }

  Widget getLoadingCards() {
    if (widget.sliverGridDelegate == null) {
      return ListView.builder(
        itemExtent: widget.shimmerExtent! + 8,
        itemBuilder: (context, index) =>
        widget.shimmerPadding == null
            ? Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: widget.initialLoadingWidget ?? const BaseShimmer(),
        )
            : Padding(
          padding: widget.shimmerPadding!,
          child: widget.initialLoadingWidget ?? const BaseShimmer(),
        ),
        itemCount: 10,
        shrinkWrap: true,
        padding: widget.scrollablePadding ?? EdgeInsets.only(
          top: widget.topInset ?? 0.0,
          bottom: widget.bottomInset ?? 0.0,
        ),
        scrollDirection: widget.scrollDirection,
        physics: const NeverScrollableScrollPhysics(),
      );
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) =>
      widget.initialLoadingWidget ?? const BaseShimmer(),
      gridDelegate: widget.sliverGridDelegate!,
      padding: widget.scrollablePadding ?? EdgeInsets.only(
        top: widget.topInset ?? 0.0,
        bottom: widget.bottomInset ?? 0.0,
      ),
      shrinkWrap: true,
    );
  }

  Widget getChildWidget(List<T> data,
      bool disableBottomInsets,) {
    if (data.isEmpty) {
      return widget.emptyState ??
          const Text(
            'No Data',
          );
    }
    if (widget.sliverGridDelegate == null) {
      return ListView.builder(
        key: widget.pageStorageKey,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) => widget.child(data[index]),
        itemExtent: widget.useItemExtent ? widget.shimmerExtent! + 8 : null,
        padding: widget.scrollablePadding ??
            EdgeInsets.only(
              top: widget.topInset ?? 0.0,
              bottom: disableBottomInsets ? 0.0 : widget.bottomInset ?? 0.0,
            ),
        scrollDirection: widget.scrollDirection,
        shrinkWrap: true,
      );
    }
    return GridView.builder(
      key: widget.pageStorageKey,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      padding: widget.scrollablePadding ??
          EdgeInsets.only(
            top: widget.topInset ?? 0.0,
            bottom: widget.bottomInset ?? 0.0,
          ),
      scrollDirection: widget.scrollDirection,
      itemBuilder: (context, index) => widget.child(data[index]),
      gridDelegate: widget.sliverGridDelegate!,
      shrinkWrap: true,
    );
  }
}
