import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../context_extensions.dart';
import 'country_info.dart';
import 'country_picker_placement_enum.dart';
import 'phone_country_menu_item.dart';
import 'phone_field_notifier.dart';

class CountriesOverlay extends StatefulWidget {
  const CountriesOverlay({
    super.key,
    required this.buttonRectKey,
    required this.animationController,
    required this.overlayController,
    this.overlayDecoration,
    required this.textStyle,
    required this.phoneFieldNotifier,
    required this.pickerPlacement,
  });

  final GlobalKey buttonRectKey;
  final CountryPickerPlacementEnum pickerPlacement;
  final PhoneFieldNotifier phoneFieldNotifier;
  final AnimationController animationController;
  final BoxDecoration? overlayDecoration;
  final TextStyle? textStyle;
  final OverlayPortalController overlayController;

  @override
  State<CountriesOverlay> createState() => _CountriesOverlayState();
}

class _CountriesOverlayState extends State<CountriesOverlay> {
  final scrollController = ScrollController();
  final thisWidgetKey = GlobalKey();
  double? smallScreenTopRect;
  late Timer timer;

  void resetTopRect() {
    if (smallScreenTopRect != null) {
      smallScreenTopRect = null;
      setState(() {});
    }
  }

  void animationControllerListener() {
    if (thisWidgetKey.currentContext?.findRenderObject() == null) return;
    final overlaySize = thisWidgetKey.getSize;
    final buttonRect = widget.buttonRectKey.globalPaintBounds;
    if (buttonRect == null) return;
    final topRect = buttonRect.top;
    final totalHeight = context.height;
    final totalHeightWithPadding = totalHeight - 50;
    final currentOverlayHeight = overlaySize.height;
    final overlayBottomPoint = currentOverlayHeight + topRect;
    if (overlayBottomPoint > totalHeightWithPadding) {
      smallScreenTopRect = totalHeightWithPadding - currentOverlayHeight;
      setState(() {});
      return;
    }
    resetTopRect();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(milliseconds: 50),
      (timer) => animationControllerListener(),
    );
    widget.animationController.addListener(animationControllerListener);
    widget.animationController.addStatusListener(
      (status) => animationControllerListener(),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    widget.animationController.removeListener(animationControllerListener);
    widget.animationController.removeStatusListener(
      (status) => animationControllerListener(),
    );
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonRect = widget.buttonRectKey.globalPaintBounds;
    final height = context.height;
    animationControllerListener();
    if (buttonRect == null) return const SizedBox();
    final child = Container(
      key: thisWidgetKey,
      decoration: widget.overlayDecoration,
      constraints: BoxConstraints(
        maxHeight: min(height - 60, 600),
        maxWidth: min(context.width, 250),
      ),
      child: FadeTransition(
        opacity: widget.animationController,
        child: SizeTransition(
          sizeFactor: widget.animationController,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: getPopupMenuItems,
              ),
            ),
          ),
        ),
      ),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            widget.animationController.reverse();
            await Future.delayed(
              const Duration(milliseconds: 250),
            );
            widget.overlayController.hide();
          },
        ),
        switch (widget.pickerPlacement) {
          CountryPickerPlacementEnum.outside => Positioned(
              top: smallScreenTopRect ?? buttonRect.top - 2,
              left: buttonRect.left - 2,
              child: child,
            ),
          CountryPickerPlacementEnum.insideSuffix => PositionedDirectional(
              top: smallScreenTopRect ?? buttonRect.top - 2,
              start: context.isArabic ? buttonRect.left - 2 : null,
              end: !context.isArabic
                  ? context.width - buttonRect.right - 2
                  : null,
              child: child,
            ),
          CountryPickerPlacementEnum.insidePrefix => PositionedDirectional(
              top: smallScreenTopRect ?? buttonRect.top - 2,
              end: context.isArabic
                  ? context.width - buttonRect.right - 2
                  : null,
              start: !context.isArabic ? buttonRect.left - 2 : null,
              child: child,
            ),
        }
      ],
    );
  }

  List<Widget> get getPopupMenuItems => CountryInfo.getPhoneCountries
      .map(
        (e) => PhoneCountryCodeMenuItem(
          countryInfo: e,
          textStyle: widget.textStyle,
          phoneFieldNotifier: widget.phoneFieldNotifier,
          animationController: widget.animationController,
          overlayController: widget.overlayController,
        ),
      )
      .toList();
}
