import 'package:flutter/material.dart' show AnimationController, BorderRadius, BuildContext, ClipRRect, ColoredBox, Colors, Column, FadeTransition, FocusScope, GestureDetector, GlobalKey, OverlayPortalController, Positioned, SizeTransition, SizedBox, Stack, StackFit, StatelessWidget, Widget;

import '../../context_extensions.dart';
import 'country_info.dart';
import 'phone_country_menu_item.dart';
import 'phone_field_notifier.dart';

class CountriesOverlay extends StatelessWidget {
  const CountriesOverlay({
    super.key,
    required this.buttonRectKey,
    required this.animationController,
    required this.overlayController,
    required this.phoneFieldNotifier,
  });

  final GlobalKey buttonRectKey;
  final PhoneFieldNotifier phoneFieldNotifier;
  final AnimationController animationController;
  final OverlayPortalController overlayController;

  @override
  Widget build(BuildContext context) {
    final buttonRect = buttonRectKey.globalPaintBounds;
    if (buttonRect == null) return const SizedBox();
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            animationController.reverse();
            await Future.delayed(
              const Duration(milliseconds: 250),
            );
            overlayController.hide();
          },
        ),
        Positioned(
          top: buttonRect.top - 2,
          left: buttonRect.left - 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeTransition(
              opacity: animationController,
              child: SizeTransition(
                sizeFactor: animationController,
                child: ColoredBox(
                  color: Colors.white,
                  child: Column(
                    children: getPopupMenuItems,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get getPopupMenuItems => CountryInfo.getPhoneCountries
      .map(
        (e) => PhoneCountryCodeMenuItem(
          countryInfo: e,
          phoneFieldNotifier: phoneFieldNotifier,
          animationController: animationController,
          overlayController: overlayController,
        ),
      )
      .toList();
}
