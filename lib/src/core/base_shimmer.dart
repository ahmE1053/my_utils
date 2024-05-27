import 'context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  const BaseShimmer({
    super.key,
    this.borderRadius,
  });

  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode
          ? Colors.grey.shade300.withOpacity(0.3)
          : Colors.grey.shade300,
      highlightColor: context.isDarkMode
          ? Colors.grey.shade100.withOpacity(0.3)
          : Colors.grey.shade100,
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius ?? 24.0),
        ),
      ),
    );
  }
}
