import 'package:flutter/cupertino.dart';

extension DoubleAnimationExtensions on Animation<double> {
  Animation<Offset> getOffsetPageLikeAnimation(MovementDirection direction) {
    late Offset usedOffset;
    late Offset tempOffset;
    if (direction == MovementDirection.rightToLeft) {
      usedOffset = const Offset(1.0, 0.0);
      tempOffset = const Offset(-1.0, 0.0);
    } else {
      usedOffset = const Offset(-1.0, 0.0);
      tempOffset = const Offset(1.0, 0.0);
    }
    final usedOffsetAnimation = Tween(
      begin: usedOffset,
      end: const Offset(0.0, 0.0),
    ).animate(this);
    final tempOffsetAnimation = Tween(
      begin: tempOffset,
      end: const Offset(0.0, 0.0),
    ).animate(this);
    return isForwardOrCompleted ? usedOffsetAnimation : tempOffsetAnimation;
  }

  Widget wrapWithOpacityAndPageLikeMovement(
    MovementDirection direction,
    Widget child,
  ) {
    return SlideTransition(
      position: getOffsetPageLikeAnimation(direction),
      child: FadeTransition(
        opacity: this,
        child: child,
      ),
    );
  }
}

enum MovementDirection {
  leftToRight,
  rightToLeft,
}
