import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/src/core/text_fields/utils/phone_country_name_localizer.dart';

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
                spacing: 8,
                children: [
                  CountryFlag.fromCountryCode(
                    countryInfo.countryCode,
                    height: 20,
                    width: 28,
                    shape: const RoundedRectangle(3),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      countryInfo.phoneCode,
                      style: textStyle ??
                          const MyUtilAppTextStyle.getTextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: 500
                          ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        phoneCountryNameLocalizer(
                          countryInfo.countryName,
                          context.locale.languageCode.toLowerCase(),
                        ),
                        style: MyUtilAppTextStyle.getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
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
