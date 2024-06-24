import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_utils/src/core/consts/app_localization_keys.g.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    this.goBack,
    this.goBackText,
  });

  final String title;
  final void Function()? goBack;
  final String? goBackText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: Lottie.asset(
            'assets/lottie/empty.json',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        if (goBack != null) ...[
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: goBack,
              child: Text(
                goBackText?.tr() ?? LocaleKeys.goBack.tr(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
