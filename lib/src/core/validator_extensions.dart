extension Validators on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isPhoneValid() {
    return RegExp(r'^(\+2)?01[0125]\d{8}$').hasMatch(this);
  }

  bool isMasterCard() {
    return RegExp(r'^5[1-5]').hasMatch(this);
  }

  bool isVisa() {
    return RegExp(r'^4').hasMatch(this);
  }
}
