import 'package:flutter/material.dart';

class WaitBeforeResend extends StatelessWidget {
  const WaitBeforeResend({
    super.key,
    required this.childAfter,
    required this.childWaiting,
    required this.durationToWait,
  });

  final ValueNotifier<Duration> durationToWait;
  final Widget Function(Duration duration) childWaiting;
  final Widget childAfter;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: durationToWait,
      builder: (context, value, child) {
        if (value == Duration.zero) {
          return child!;
        }
        return childWaiting(value);
      },
      child: childAfter,
    );
  }
}
