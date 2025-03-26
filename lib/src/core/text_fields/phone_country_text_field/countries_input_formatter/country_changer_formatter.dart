import 'package:flutter/services.dart';

import '../../../../../my_utils.dart';

class CountryChangerFormatter extends TextInputFormatter {
  final PhoneFieldNotifier phoneFieldNotifier;

  const CountryChangerFormatter(this.phoneFieldNotifier);

  String? checkForOtherCountry(String newValue) {
    String cleanedValue = newValue.replaceFirst(RegExp(r'^0+'), '');
    for (var e in CountryInfo.getPhoneCountries) {
      final phoneCode=e.phoneCode.replaceAll('+', '');
      if (cleanedValue.startsWith(phoneCode)) {
        final newText = cleanedValue.replaceFirst(phoneCode, '');
        phoneFieldNotifier.country = e;
        return newText;
      }
    }
    return null;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = checkForOtherCountry(newValue.text);
    if (value != null) {
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
    return newValue;
  }
}
