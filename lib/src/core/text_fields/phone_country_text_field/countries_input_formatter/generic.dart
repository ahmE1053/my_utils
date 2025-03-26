import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  final String countryCode;

  // Map of Arabic digits to English digits
  static const Map<String, String> arabicToEnglishDigits = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  const PhoneNumberFormatter(this.countryCode);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Detect if this is potentially a paste operation
    bool isPotentialPaste = newValue.text.length != oldValue.text.length + 1;

    String formattedText = newValue.text;

    // Convert Arabic digits to English digits
    formattedText = _convertArabicToEnglishDigits(formattedText);

    // For paste operations or any multi-character changes, we always format
    if (isPotentialPaste || formattedText.length > 2) {
      formattedText = _formatPhoneNumber(formattedText);
    }
    // For single character input (manual typing)
    else {
      // Check if the last character is a valid digit
      final lastChar = formattedText[formattedText.length - 1];
      if (!RegExp(r'[0-9]').hasMatch(lastChar)) {
        // If the last character is not a digit, reject it
        return oldValue;
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  // Convert Arabic digits to English digits
  String _convertArabicToEnglishDigits(String input) {
    String result = input;
    arabicToEnglishDigits.forEach((arabic, english) {
      result = result.replaceAll(arabic, english);
    });
    return result;
  }

  // Format phone number according to Egyptian format
  String _formatPhoneNumber(String input) {
    // Remove all non-digit characters
    String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.startsWith(countryCode) &&
        digitsOnly.length > countryCode.length) {
      digitsOnly = digitsOnly.substring(countryCode.length);
    }
    return digitsOnly;
  }
}
