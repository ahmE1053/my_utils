import 'dart:async';

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
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.shimmerBorderRadius = 12,
    this.animatedSwitcherAlignment = Alignment.topCenter,
  }) : assert(sliverGridDelegate != null || shimmerExtent != null);

  ///a notifier to stop this widget from making new requests
  final ValueNotifier<bool>? isLastPage;
  final ScrollPhysics? physics;

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

  ///The circular border radius for the shimemr cards
  final double shimmerBorderRadius;

  ///Page Storage key for the scrollable
  final PageStorageKey? pageStorageKey;

  /// Alignment for the [AnimatedSwitcher] the transitions between the states of the model
  ///
  /// Defaults to [Alignment.topCenter]
  final AlignmentGeometry? animatedSwitcherAlignment;

  @override
  State<PaginationStateModelWidget<T>> createState() =>
      _PaginationStateModelWidgetState<T>();
}

class _PaginationStateModelWidgetState<T>
    extends State<PaginationStateModelWidget<T>> {
  bool isLoading = false;
  ScrollController? _scrollController;
  Timer? timer;

  ScrollController get scrollController =>
      widget.upperScrollController ?? _scrollController!;

  Timer removeTimer() {
    return Timer(
      const Duration(milliseconds: 750),
      () {
        timer = null;
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => scrollListener(),
        );
      },
    );
  }

  void scrollListener() {
    if (widget.isLastPage?.value ?? false) return;
    if (!scrollController.hasClients) return;
    if (scrollController.position.maxScrollExtent - scrollController.offset <
        120) {
      final state = widget.stateModel;
      if (state is PaginationStateSuccess<T> && timer == null) {
        timer = removeTimer();
        widget.onRequestNewData(state.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future(
      () => widget.initialCall?.call(),
    );
    if (widget.upperScrollController == null) {
      _scrollController = ScrollController();
    }
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  void checkIfNotScrollable(_) {
    final state = widget.stateModel;
    try {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent == 0.0) {
        if (state is PaginationStateSuccess<T> && timer == null) {
          widget.onRequestNewData(state.data);
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.stateModel;
    WidgetsBinding.instance.addPostFrameCallback(checkIfNotScrollable);
    final thisWidget = switch (state) {
      PaginationStateInitial<T>() ||
      PaginationStateLoading<T>() =>
        getLoadingCards(),
      PaginationStateError<T>() => Padding(
          padding: widget.initialErrorPadding ?? EdgeInsets.zero,
          child: widget.initialErrorWidget ??
              FullScreenError(
                onTap: widget.onError,
                exception: GeneralException(state.errorMessage),
              ),
        ),
      PaginationStateSuccess<T>(data: var data) => getChildWidget(
          data: data,
          disableBottomInsets: false,
        ),
      PaginationStateLoadingWithData<T>(oldData: var data) => getChildWidget(
          data: data,
          disableBottomInsets: true,
          additionalWidgets: [
            const SizedBox(height: 8),
            const MyUtilLoadingIndicator(),
          ],
        ),
      PaginationStateErrorWithData<T>(
        oldData: var data,
        errorMessage: var error
      ) =>
        getChildWidget(
          data: data,
          disableBottomInsets: false,
          additionalWidgets: [
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
          ],
        ),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: thisWidget,
    );
  }

  EdgeInsets getScrollablePadding(disableBottomInsets) =>
      widget.scrollablePadding ??
      EdgeInsets.only(
        top: widget.topInset ?? 0.0,
        bottom: disableBottomInsets ? 0.0 : widget.bottomInset ?? 0.0,
      );

  Widget getChildWidget({
    required List<T> data,
    required bool disableBottomInsets,
    List<Widget>? additionalWidgets,
  }) {
    if (data.isEmpty) {
      return widget.emptyState ??
          const Text(
            key: ValueKey('No Data Text'),
            'No Data',
          );
    }
    if (widget.sliverGridDelegate == null) {
      final list = ListView.builder(
        key: additionalWidgets != null ? null : widget.pageStorageKey,
        controller: additionalWidgets != null ? null : _scrollController,
        physics: additionalWidgets != null || _scrollController == null
            ? const NeverScrollableScrollPhysics()
            : widget.physics,
        shrinkWrap: additionalWidgets != null || shrinkWrap,
        itemCount: data.length,
        itemBuilder: (context, index) => widget.child(data[index]),
        itemExtent: widget.useItemExtent ? widget.shimmerExtent! + 8 : null,
        padding: additionalWidgets != null
            ? EdgeInsets.zero
            : getScrollablePadding(disableBottomInsets),
        scrollDirection: widget.scrollDirection,
      );
      if (additionalWidgets == null) return list;
      return ListView(
        key: widget.pageStorageKey,
        controller: _scrollController,
        shrinkWrap: shrinkWrap,
        scrollDirection: widget.scrollDirection,
        physics: _scrollController == null
            ? const NeverScrollableScrollPhysics()
            : widget.physics,
        padding: getScrollablePadding(disableBottomInsets),
        children: [
          list,
          ...additionalWidgets,
        ],
      );
    }
    final grid = GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: widget.scrollDirection,
      itemCount: data.length,
      padding: getScrollablePadding(disableBottomInsets),
      itemBuilder: (context, index) => widget.child(data[index]),
      gridDelegate: widget.sliverGridDelegate!,
    );
    return ListView(
      key: widget.pageStorageKey,
      controller: _scrollController,
      physics: _scrollController == null
          ? const NeverScrollableScrollPhysics()
          : widget.physics,
      shrinkWrap: shrinkWrap,
      padding: getScrollablePadding(disableBottomInsets),
      scrollDirection: widget.scrollDirection,
      children: [
        grid,
        ...?additionalWidgets,
      ],
    );
  }

  Widget getLoadingCards() {
    if (widget.sliverGridDelegate == null) {
      return ListView.builder(
        key: const ValueKey('LoadingCards'),
        itemExtent: widget.shimmerExtent! + 8,
        shrinkWrap: shrinkWrap,
        physics: _scrollController == null
            ? const NeverScrollableScrollPhysics()
            : null,
        itemBuilder: (context, index) => widget.shimmerPadding == null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: widget.initialLoadingWidget ??
                    BaseShimmer(
                      borderRadius: widget.shimmerBorderRadius,
                    ),
              )
            : Padding(
                padding: widget.shimmerPadding!,
                child: widget.initialLoadingWidget ??
                    BaseShimmer(
                      borderRadius: widget.shimmerBorderRadius,
                    ),
              ),
        itemCount: 10,
        padding: widget.scrollablePadding ??
            EdgeInsets.only(
              top: widget.topInset ?? 0.0,
              bottom: widget.bottomInset ?? 0.0,
            ),
        scrollDirection: widget.scrollDirection,
      );
    }
    return GridView.builder(
      key: const ValueKey('LoadingCards'),
      itemCount: 10,
      shrinkWrap: shrinkWrap,
      physics: _scrollController == null
          ? const NeverScrollableScrollPhysics()
          : null,
      itemBuilder: (context, index) =>
          widget.initialLoadingWidget ??
          BaseShimmer(
            borderRadius: widget.shimmerBorderRadius,
          ),
      gridDelegate: widget.sliverGridDelegate!,
      padding: widget.scrollablePadding ??
          EdgeInsets.only(
            top: widget.topInset ?? 0.0,
            bottom: widget.bottomInset ?? 0.0,
          ),
    );
  }

  bool get shrinkWrap => _scrollController == null ? true : false;
}
