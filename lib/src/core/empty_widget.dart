import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_utils/src/core/consts/app_localization_keys.g.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.goBack,
    this.goBackText,
    this.titleStyle,
    this.subtitleStyle, this.imageWidget,
  });

  final String title;
  final void Function()? goBack;
  final String? goBackText;
  final String? subtitle;
  final Widget? imageWidget;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child:imageWidget?? Lottie.asset(
            'assets/lottie/empty.json',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.tr(),
          textAlign: TextAlign.center,
          style: titleStyle ?? const TextStyle(
            fontSize: 14,
          ),
        ),
        if(subtitle != null)...[
          const SizedBox(height: 8),
          Text(
            subtitle!.tr(),
            textAlign: TextAlign.center,
            style: subtitleStyle ?? const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
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

class EmptyFlexibleWidget extends StatelessWidget {
  const EmptyFlexibleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.goBack,
    this.goBackText,
    this.titleStyle,
    this.subtitleStyle, this.imageWidget,
  });

  final String title;
  final void Function()? goBack;
  final String? goBackText;
  final String? subtitle;
  final Widget? imageWidget;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        Flexible(
          child: SizedBox(
            height: 300,
            child:imageWidget?? Lottie.asset(
              'assets/lottie/empty.json',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.tr(),
          textAlign: TextAlign.center,
          style: titleStyle ?? const TextStyle(
            fontSize: 14,
          ),
        ),
        if(subtitle != null)...[
          const SizedBox(height: 8),
          Text(
            subtitle!.tr(),
            textAlign: TextAlign.center,
            style: subtitleStyle ?? const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
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
