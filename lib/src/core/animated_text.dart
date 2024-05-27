import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText(
    this.text, {
    super.key,
    this.align,
    this.style,
    this.animationDuration,
    this.direction = TextAnimationDirection.downToCenter,
  });

  final String text;
  final TextAnimationDirection direction;
  final TextStyle? style;
  final TextAlign? align;
  final Duration? animationDuration;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Tween<double> _textOpacityTween, _textTransformValueTween;
  late final Animation<double> _textOpacity, _textTransformValue;
  late String _oldText;
  late final void Function(AnimationStatus) _animationControllerListener;
  Timer? timer;
  bool isPressingTooFast = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 250),
    );

    _textTransformValueTween = Tween(begin: 0.0, end: 20.0);
    _textOpacityTween = Tween(begin: 0.0, end: 1.0);
    _textOpacity = _textOpacityTween.animate(_animationController);
    _textTransformValue =
        _textTransformValueTween.animate(_animationController);
    _oldText = widget.text;
    _animationControllerListener = (status) {
      if (status == AnimationStatus.completed) {
        _oldText = widget.text;
      }
    };
    _animationController.addStatusListener(_animationControllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_oldText != widget.text && !isPressingTooFast) {
      _resetAnimationAfterCompletion(_animationController);
    }
    if (isPressingTooFast) {
      _oldText = widget.text;
    }
    return ListenableBuilder(
      listenable: _animationController,
      builder: (context, child) {
        if (!_animationController.isAnimating) {
          return child!;
        }
        return Stack(
          children: [
            Transform.translate(
              offset: _getOffsetForOldText,
              child: Opacity(
                opacity: 1 - _textOpacity.value,
                child: _oldTextWidget,
              ),
            ),
            Transform.translate(
              offset: _getOffsetForNewText,
              child: Opacity(
                opacity: _textOpacity.value,
                child: child,
              ),
            ),
          ],
        );
      },
      child: _baseTextWidget,
    );
  }

  //text widget with the new or provided text
  Widget get _baseTextWidget => Text(
        widget.text,
        style: widget.style,
        textAlign: widget.align,
      );

  Offset get _getOffsetForNewText {
    return switch (widget.direction) {
      TextAnimationDirection.upToCenter =>
        Offset(0, -_textTransformValueTween.end! + _textTransformValue.value),
      TextAnimationDirection.downToCenter =>
        Offset(0, _textTransformValueTween.end! - _textTransformValue.value),
      TextAnimationDirection.leftToCenter =>
        Offset(-_textTransformValueTween.end! + _textTransformValue.value, 0),
      TextAnimationDirection.rightToCenter =>
        Offset(_textTransformValueTween.end! - _textTransformValue.value, 0),
    };
  }

  Offset get _getOffsetForOldText {
    return switch (widget.direction) {
      TextAnimationDirection.upToCenter => Offset(0, _textTransformValue.value),
      TextAnimationDirection.downToCenter =>
        Offset(0, -_textTransformValue.value),
      TextAnimationDirection.leftToCenter =>
        Offset(_textTransformValue.value, 0),
      TextAnimationDirection.rightToCenter =>
        Offset(_textTransformValue.value, 0),
    };
  }

  //text widget with the old or to be changed text
  Widget get _oldTextWidget => Text(
        _oldText,
        style: widget.style,
        textAlign: widget.align,
      );

  void _resetAnimationAfterCompletion(AnimationController controller) async {
    isPressingTooFast = true;
    timer = Timer(
      controller.duration ?? const Duration(milliseconds: 250),
      () {
        isPressingTooFast = false;
      },
    );
    controller.forward();
    await Future.delayed(
      controller.duration ?? const Duration(milliseconds: 250),
    );
    controller.value = 0.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum TextAnimationDirection {
  upToCenter,
  downToCenter,
  leftToCenter,
  rightToCenter,
}
