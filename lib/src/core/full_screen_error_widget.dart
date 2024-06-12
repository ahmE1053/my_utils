import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_utils/src/core/exceptions/general_exception.dart';

import 'context_extensions.dart';
import 'consts/app_localization_keys.g.dart';
import 'consts/text_styles.dart';

class FullScreenError extends StatelessWidget {
  const FullScreenError({
    super.key,
    required this.exception,
    required this.onTap,
    this.stackTrace,
  });

  final Object exception;
  final StackTrace? stackTrace;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            height: context.height * 0.25,
            child: Lottie.asset(
              'assets/lottie/error.json',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exception is GeneralException
              ? (exception as GeneralException).message.tr()
              : LocaleKeys.errorOccurred.tr(),
          textAlign: TextAlign.center,
          style: MyUtilAppTextStyle.getTextStyle(
            fontSize: 14,
            fontWeight: 500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
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
