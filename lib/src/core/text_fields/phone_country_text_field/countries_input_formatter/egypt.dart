
import 'package:flutter/services.dart';

class EgyptianPhoneNumberFormatter extends TextInputFormatter {
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

  // Egyptian phone validation regex
  static final RegExp egyptianPhoneRegex = RegExp(r'^(01)[0125]\d{8}$');

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

    // Handle international format for Egypt: +20, 00, etc.
    if (digitsOnly.startsWith('20') && digitsOnly.length > 10) {
      // Remove country code (20) and ensure the number starts with '01'
      digitsOnly = digitsOnly.substring(2);

      // If after removing country code, the number doesn't start with 01, fix it
      if (!digitsOnly.startsWith('01')) {
        if (digitsOnly.startsWith('1')) {
          digitsOnly = '0$digitsOnly';
        } else {
          digitsOnly =
          '01${digitsOnly.length >= 9 ? digitsOnly.substring(digitsOnly.length - 9) : digitsOnly}';
        }
      }
    }

    // If the number begins with just "1", add a "0" prefix
    if (digitsOnly.startsWith('1') && (digitsOnly.length == 10)) {
      digitsOnly = '0$digitsOnly';
    }

    // Ensure the number starts with "01" if it's long enough
    if (digitsOnly.length > 2 && !digitsOnly.startsWith('01')) {
      // If we have at least 11 digits, trim to ensure proper format
      if (digitsOnly.length >= 11) {
        if (digitsOnly[0] == '1') {
          digitsOnly = '0${digitsOnly.substring(digitsOnly.length - 11)}';
        } else {
          digitsOnly = '01${digitsOnly.substring(digitsOnly.length - 9)}';
        }
      } else {
        if (digitsOnly[0] == '1') {
          digitsOnly = '0${digitsOnly.length > 2 ? digitsOnly : ''}';
        } else {
          // If we have fewer digits but it doesn't start with 01, adjust it
          digitsOnly = '01${digitsOnly.length > 2 ? digitsOnly : ''}';
        }
      }
    }

    // Ensure we don't exceed 11 digits
    if (digitsOnly.length > 11) {
      digitsOnly = digitsOnly.substring(0, 11);
    }

    return digitsOnly;
  }
}

