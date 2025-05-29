import 'package:flutter/material.dart';
import 'package:my_utils/src/translator.dart';

import 'consts/text_styles.dart';

class ErrorTextWithAnimation extends StatefulWidget {
  const ErrorTextWithAnimation({
    super.key,
    required this.errorText,
    this.useTopPadding = true,
    this.useBottomPadding = true,
  });

  final String errorText;
  final bool useTopPadding, useBottomPadding;

  @override
  State<ErrorTextWithAnimation> createState() => _ErrorTextWithAnimationState();
}

class _ErrorTextWithAnimationState extends State<ErrorTextWithAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SizeTransition(
          sizeFactor: animationController,
          child: Opacity(
            opacity: animationController.value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          if (widget.useTopPadding) const SizedBox(height: 8),
          Text(
            widget.errorText.translate(context),
            style: const MyUtilAppTextStyle.getTextStyle(
              color: Colors.redAccent,
              fontSize: 13,
              fontWeight: 300,
            ),
          ),
          if (widget.useBottomPadding) const SizedBox(height: 8),
        ],
      ),
    );
  }
}
