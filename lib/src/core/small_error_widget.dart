import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'consts/app_localization_keys.g.dart';
import 'consts/text_styles.dart';

class SmallErrorWidget extends StatelessWidget {
  const SmallErrorWidget({
    super.key,
    this.errorMessage,
    this.buttonMessage,
    this.errorTextStyle,
    this.buttonTextStyle,
    this.elevatedErrorButtonStyle,
    required this.onTap,
  });

  final String? errorMessage;
  final String? buttonMessage;
  final TextStyle? errorTextStyle;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? elevatedErrorButtonStyle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final canShowErrorMessage = errorMessage != null &&
        errorMessage!.length < 200;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            canShowErrorMessage ? (errorMessage?.tr() ??
                LocaleKeys.errorOccurred.tr()) : LocaleKeys.errorOccurred.tr(),
            textAlign: TextAlign.center,
            style: errorTextStyle ??
                const MyUtilAppTextStyle.getTextStyle(
                  fontSize: 14,
                  fontWeight: 500,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: elevatedErrorButtonStyle,
              onPressed: onTap,
              child: Text(
                (buttonMessage ?? LocaleKeys.retry).tr(),
                style: buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
