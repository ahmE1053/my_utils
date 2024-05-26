import 'package:flutter/widgets.dart' show TextEditingController, ValueNotifier;

import '../../consts/app_localization_keys.g.dart';
import 'country_info.dart';

class PhoneFieldNotifier {
  final TextEditingController controller;
  final ValueNotifier<CountryInfo> _country;

  PhoneFieldNotifier._(this.controller, this._country);

  factory PhoneFieldNotifier(CountryInfo? country) => PhoneFieldNotifier._(
        TextEditingController(),
        ValueNotifier(
          country ?? CountryInfo.saudiArabia(),
        ),
      );

  void dispose() {
    controller.dispose();
    _country.dispose();
  }

  String get numberWithCountryCode =>
      '${_country.value.phonePrefix}${controller.text}';

  ValueNotifier<CountryInfo> get countryListener => _country;

  CountryInfo get country => _country.value;

  set country(CountryInfo value) {
    _country.value = value;
  }

  String? get validator {
    if (controller.text.isEmpty) {
      return LocaleKeys.emptyPhone;
    }
    if (country.validator(numberWithCountryCode)) {
      return LocaleKeys.wrongPhone;
    }
    return null;
  }
}
