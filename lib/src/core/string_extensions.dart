import 'package:flutter/material.dart';

extension Validation on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isPhoneValid() {
    return RegExp(r'^(01)[0125]\d{8}$').hasMatch(this);
  }

  bool isPhoneValidWithCountryCodeEgypt() {
    return RegExp(r'^(\+201)[0125]\d{8}$').hasMatch(this);
  }

  bool isPhoneValidWithCountryCodeQatar() {
    return RegExp(r'^(\+974)\d{8}$').hasMatch(this);
  }

  bool isLinkValid() {
    return RegExp(
            r'^[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$')
        .hasMatch(this);
  }

  bool isStrongPassword() {
    return RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8}$')
        // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.!@$%^&*()_+=])[A-Za-z\d.!@$%^&*()_+=]{8,}$')
        .hasMatch(this);
  }

  bool isSaudiPhoneValid() {
    return RegExp(r'^(9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$').hasMatch(this);
  }

  bool isPhoneValidWithCountryCode() {
    return RegExp(r'^(\+201)[0125]\d{8}$').hasMatch(this);
  }

  bool isSaudiPhoneValidWithCountryCode() {
    return RegExp(r'^\+966(9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
        .hasMatch(this);
  }

  bool isQatarPhoneWithCountryCode() {
    return RegExp(r'^\+974\d{8}$').hasMatch(this);
  }

  bool isYemenPhoneWithCountryCode() {
    // return RegExp(r'^(((\+|00)9677|0?7)[01378]\d{7}|((\+|00)967|0)[1-7]\d{6})$').hasMatch(this);
    return true;
  }
}

extension ColorExtractor on String {
  Color get getColor {
    if (length == 6) {
      return Color(int.parse('0xff$this'));
    }
    if (startsWith('#') && length == 7) {
      final newColorCode = substring(1);
      return Color(
        int.parse('0xff$newColorCode'),
      );
    }
    if (length == 10) {
      return Color(
        int.parse(this),
      );
    }
    throw FlutterError(
      'Wrong Color Format',
    );
  }
}
