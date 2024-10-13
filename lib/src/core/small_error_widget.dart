import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'consts/app_localization_keys.g.dart';
import 'consts/text_styles.dart';

class SmallErrorWidget extends StatelessWidget {
  const SmallErrorWidget({
    super.key,
    this.errorMessage,
    this.errorTextStyle,
    required this.onTap,
  });

  final String? errorMessage;
  final TextStyle? errorTextStyle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMessage ?? LocaleKeys.errorOccurred.tr(),
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
            onPressed: onTap,
            child: Text(
              LocaleKeys.retry.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
