import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({
    super.key,
    required this.numOfStars,
    this.padding,
    this.size,
    this.starColor,
  });

  final num numOfStars;
  final EdgeInsets? padding;
  final double? size;
  final Color? starColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (innerIndex) {
          final currentNumber = numOfStars - (innerIndex + 1);
          late Widget child;
          if (currentNumber > -0.2) {
            child = SvgPicture.asset(
              'assets/icons/star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else if (currentNumber < -0.2 && currentNumber > -0.8) {
            child = SvgPicture.asset(
              'assets/icons/half_star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else {
            child = SvgPicture.asset(
              'assets/icons/empty_star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          }
          return SizedBox(
            height: size,
            width: size,
            child: Padding(
              padding: padding ?? const EdgeInsetsDirectional.only(end: 8),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class MyRatingBarSelection extends StatelessWidget {
  const MyRatingBarSelection({
    super.key,
    required this.rating,
    this.padding,
    this.size,
    this.starColor,
  });

  final ValueNotifier<int> rating;
  final EdgeInsets? padding;
  final double? size;
  final Color? starColor;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: rating,
      builder: (context, _) {
        return Row(
          children: List.generate(
            5,
                (index) {
              final currentNumber = rating.value - (index + 1);
              late Widget child;
              if (currentNumber > -0.2) {
                child = SvgPicture.asset(
                  'assets/icons/star.svg',
                  colorFilter: ColorFilter.mode(
                    starColor ?? Colors.amber,
                    BlendMode.srcIn,
                  ),
                );
              } else if (currentNumber < -0.2 && currentNumber > -0.8) {
                child = SvgPicture.asset(
                  'assets/icons/half_star.svg',
                  colorFilter: ColorFilter.mode(
                    starColor ?? Colors.amber,
                    BlendMode.srcIn,
                  ),
                );
              } else {
                child = SvgPicture.asset(
                  'assets/icons/empty_star.svg',
                  colorFilter: ColorFilter.mode(
                    starColor ?? Colors.amber,
                    BlendMode.srcIn,
                  ),
                );
              }
              return SizedBox(
                height: size,
                width: size,
                child: Padding(
                  padding: padding ?? const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: () => rating.value = index + 1,
                    child: child,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class MyRatingBarSelectionWithoutNotifier extends StatelessWidget {
  const MyRatingBarSelectionWithoutNotifier({
    super.key,
    required this.rating,
    required this.onRate,
    this.padding,
    this.size,
    this.starColor,
  });

  final int rating;
  final void Function(int newRating) onRate;
  final EdgeInsets? padding;
  final double? size;
  final Color? starColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) {
          final currentNumber = rating - (index + 1);
          late Widget child;
          if (currentNumber > -0.2) {
            child = SvgPicture.asset(
              'assets/icons/star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else if (currentNumber < -0.2 && currentNumber > -0.8) {
            child = SvgPicture.asset(
              'assets/icons/half_star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else {
            child = SvgPicture.asset(
              'assets/icons/empty_star.svg',
              colorFilter: ColorFilter.mode(
                starColor ?? Colors.amber,
                BlendMode.srcIn,
              ),
            );
          }
          return SizedBox(
            height: size,
            width: size,
            child: Padding(
              padding: padding ?? const EdgeInsetsDirectional.only(end: 8),
              child: GestureDetector(
                onTap: () => onRate(index + 1),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
