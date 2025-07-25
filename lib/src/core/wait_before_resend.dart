import 'dart:async';

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

class FullWaitBeforeResend extends StatefulWidget {
  const FullWaitBeforeResend({
    super.key,
    required this.childAfter,
    required this.childWaiting,
    required this.durationToWait,
    required this.isShowingTimer,
    required this.onWaitingEnded,
  });

  final Duration durationToWait;
  final bool isShowingTimer;
  final void Function() onWaitingEnded;
  final Widget Function(Duration remainingDuration) childWaiting;
  final Widget childAfter;

  @override
  State<FullWaitBeforeResend> createState() => _FullWaitBeforeResendState();
}

class _FullWaitBeforeResendState extends State<FullWaitBeforeResend> {
  late Timer timer;
  late Duration remainingDuration;

  Timer get createTimer => Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          remainingDuration = remainingDuration - Duration(seconds: 1);
          setState(() {});
          if (remainingDuration == Duration.zero) {
            timer.cancel();
            widget.onWaitingEnded();
          }
        },
      );

  @override
  void initState() {
    super.initState();
    remainingDuration = widget.durationToWait;
    timer = createTimer;
  }

  @override
  void didUpdateWidget(covariant FullWaitBeforeResend oldWidget) {
    if (!oldWidget.isShowingTimer && widget.isShowingTimer) {
      remainingDuration = widget.durationToWait;
      timer.cancel();
      timer = createTimer;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (remainingDuration == Duration.zero) {
      return widget.childAfter;
    }
    return widget.childWaiting(remainingDuration);
  }
}
