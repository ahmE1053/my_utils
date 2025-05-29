import 'package:flutter/material.dart';
import 'package:my_utils/src/translator.dart';

import 'consts/text_styles.dart';

//Used when a data source request throws an error to display the error message
class ErrorColumn extends StatelessWidget {
  const ErrorColumn({
    super.key,
    required this.text,
    this.errorTextColor,
    this.errorTextStyle,
    required this.child,
  });

  final Color? errorTextColor;
  final Widget child;
  final String text;
  final TextStyle? errorTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        const SizedBox(height: 16),
        Text(
          text.translate(context),
          style: errorTextStyle ??
              MyUtilAppTextStyle.getTextStyle(
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
    required this.text,
    this.errorTextColor,
    this.errorPadding,
    this.height = 8,
    required this.child,
  });

  final Widget child;
  final String text;
  final double height;
  final Color? errorTextColor;
  final EdgeInsetsGeometry? errorPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        SizedBox(height: height),
        Builder(
          builder: (context) {
            final child = Text(
              text.translate(context),
              style: MyUtilAppTextStyle.getTextStyle(
                fontSize: 12,
                color: errorTextColor ?? Colors.redAccent,
              ),
            );
            if (errorPadding == null) return child;
            return Padding(
              padding: errorPadding!,
              child: child,
            );
          },
        ),
      ],
    );
  }
}
