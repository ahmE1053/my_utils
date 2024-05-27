import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'base_shimmer.dart';

class CachedNetworkImageWithLoader extends StatelessWidget {
  const CachedNetworkImageWithLoader({
    super.key,
    required this.imageUrl,
    this.fit,
    this.borderRadius,
    this.error,
    this.useInk = false,
  });

  final BoxFit? fit;
  final String imageUrl;
  final double? borderRadius;
  final Widget? error;
  final bool useInk;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      // imageUrl: imageUrl,
      imageUrl: imageUrl,
      imageBuilder: useInk
          ? (context, imageProvider) => Material(
                type: MaterialType.transparency,
                child: Ink.image(
                  image: imageProvider,
                  fit: fit,
                ),
              )
          : null,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) => BaseShimmer(
        borderRadius: borderRadius,
      ),
    );
  }
}
