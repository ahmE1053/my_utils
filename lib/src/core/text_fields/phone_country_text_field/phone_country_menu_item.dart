import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../../../my_utils.dart';

class PhoneCountryCodeMenuItem extends StatelessWidget {
  const PhoneCountryCodeMenuItem({
    super.key,
    required this.countryInfo,
    required this.phoneFieldNotifier,
    required this.animationController,
    required this.overlayController,
    required this.textStyle,
  });

  final CountryInfo countryInfo;
  final PhoneFieldNotifier phoneFieldNotifier;
  final AnimationController animationController;
  final OverlayPortalController overlayController;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            phoneFieldNotifier.country = countryInfo;
            await animationController.reverse();
            overlayController.hide();
          },
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    countryInfo.countryCode,
                    height: 20,
                    width: 28,
                    shape: const RoundedRectangle(3),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        countryInfo.phoneCode,
                        style: textStyle ??
                            const MyUtilAppTextStyle.getTextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
