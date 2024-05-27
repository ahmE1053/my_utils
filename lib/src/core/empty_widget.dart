import 'package:easy_localization/easy_localization.dart';
import 'consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyShopWidget extends StatelessWidget {
  const EmptyShopWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: MyUtilAppTextStyle.getTextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
