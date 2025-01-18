import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';

import 'base_shimmer.dart';

class CachedNetworkImageWithLoader extends StatelessWidget {
  const CachedNetworkImageWithLoader({
    super.key,
    required this.imageUrl,
    this.fit,
    this.borderRadius,
    this.error,
    this.alignment,
    this.inkImageBorder,
    this.useInk = false,
  });

  final BoxFit? fit;
  final String imageUrl;
  final double? borderRadius;
  final BorderRadiusGeometry? inkImageBorder;
  final Widget? error;
  final bool useInk;
  static Widget? errorWidget;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      alignment: alignment ?? Alignment.center,
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
      imageBuilder: useInk
          ? (context, imageProvider) =>
          Ink(
            decoration: BoxDecoration(
                borderRadius: inkImageBorder,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                  alignment: alignment ?? Alignment.center,
                )
            ),
          )
          : null,
      fit: fit,
      errorWidget: error == null && errorWidget == null ? null : (_, __,
          ___) => error ?? errorWidget!,
      progressIndicatorBuilder: (context, url, progress) =>
          BaseShimmer(
            borderRadius: borderRadius,
          ),
    );
  }
}
