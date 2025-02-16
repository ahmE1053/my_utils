import 'package:flutter/cupertino.dart';

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
    this.overlayDecoration,
    required this.textStyle,
    required this.phoneFieldNotifier,
  });

  final GlobalKey buttonRectKey;
  final PhoneFieldNotifier phoneFieldNotifier;
  final AnimationController animationController;
  final BoxDecoration? overlayDecoration;
  final TextStyle? textStyle;
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
          child: Container(
            decoration: overlayDecoration,
            child: FadeTransition(
              opacity: animationController,
              child: SizeTransition(
                sizeFactor: animationController,
                child: Padding(
                  padding: const EdgeInsets.all(8),
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
          textStyle: textStyle,
          phoneFieldNotifier: phoneFieldNotifier,
          animationController: animationController,
          overlayController: overlayController,
        ),
      )
      .toList();
}
