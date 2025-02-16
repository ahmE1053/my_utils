import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import 'phone_field_notifier.dart';

class CountrySelectorButton extends StatelessWidget {
  const CountrySelectorButton({
    super.key,
    required this.buttonRectKey,
    required this.overlayController,
    required this.animationController,
    required this.phoneValueNotifier,
    required this.codePickerDecoration,
    required this.codePickerArrowColor,
    required this.codePickerTextStyle,
    this.codePadding = EdgeInsets.zero,
    this.enabled = true,
  });

  final GlobalKey<State<StatefulWidget>> buttonRectKey;
  final OverlayPortalController overlayController;
  final AnimationController animationController;
  final PhoneFieldNotifier phoneValueNotifier;
  final BoxDecoration? codePickerDecoration;
  final EdgeInsets codePadding;
  final bool enabled;
  final Color? codePickerArrowColor;
  final TextStyle? codePickerTextStyle;

  @override
  Widget build(BuildContext context) {
    final givenRadius = codePickerDecoration?.borderRadius;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: givenRadius is BorderRadius
            ? givenRadius
            : BorderRadius.circular(12),
        key: buttonRectKey,
        onTap: enabled
            ? () {
                overlayController.show();
                animationController.forward();
              }
            : null,
        child: Ink(
          padding: codePadding,
          decoration: codePickerDecoration,
          child: ListenableBuilder(
            listenable: phoneValueNotifier.countryListener,
            builder: (context, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CountryFlag.fromCountryCode(
                    phoneValueNotifier.country.countryCode,
                    height: 20,
                    width: 28,
                    shape: const RoundedRectangle(4),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    phoneValueNotifier.country.phoneCode,
                    style: codePickerTextStyle,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: codePickerArrowColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
