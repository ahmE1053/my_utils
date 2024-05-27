import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({
    super.key,
    required this.numOfStars,
    this.padding,
    this.size,
  });

  final num numOfStars;
  final EdgeInsets? padding;
  final double? size;

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
              colorFilter: const ColorFilter.mode(
                Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else if (currentNumber < -0.2 && currentNumber > -0.8) {
            child = SvgPicture.asset(
              'assets/icons/half_star.svg',
              colorFilter: const ColorFilter.mode(
                Colors.amber,
                BlendMode.srcIn,
              ),
            );
          } else {
            child = SvgPicture.asset(
              'assets/icons/empty_star.svg',
              colorFilter: const ColorFilter.mode(
                Colors.amber,
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
  });

  final ValueNotifier<int> rating;
  final EdgeInsets? padding;
  final double? size;

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
                  colorFilter: const ColorFilter.mode(
                    Colors.amber,
                    BlendMode.srcIn,
                  ),
                );
              } else if (currentNumber < -0.2 && currentNumber > -0.8) {
                child = SvgPicture.asset(
                  'assets/icons/half_star.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.amber,
                    BlendMode.srcIn,
                  ),
                );
              } else {
                child = SvgPicture.asset(
                  'assets/icons/empty_star.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.amber,
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
