import 'package:flutter/material.dart';

class VerySmallErrorWidget extends StatelessWidget {
  const VerySmallErrorWidget({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton.filledTonal(
        onPressed: onTap,
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
