import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'consts/text_styles.dart';

//Used when a data source request throws an error to display the error message
class ErrorColumn extends StatelessWidget {
  const ErrorColumn({
    super.key,
    required this.child,
    required this.text,
    this.errorTextColor,
  });

  final Color? errorTextColor;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        const SizedBox(height: 16),
        Text(
          text.tr(),
          style: MyUtilAppTextStyle.getTextStyle(
            fontSize: 16,
            color: errorTextColor ?? Colors.redAccent,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class FormErrorColumn extends StatelessWidget {
  const FormErrorColumn({
    super.key,
    required this.child,
    required this.text,
    this.errorTextColor,
  });

  final Color? errorTextColor;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        const SizedBox(height: 8),
        Text(
          text.tr(),
          style: MyUtilAppTextStyle.getTextStyle(
            fontSize: 12,
            color: errorTextColor ?? Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
