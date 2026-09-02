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
    this.memCacheWidth,
    this.memCacheHeight,
  });

  final BoxFit? fit;
  final String imageUrl;
  final double? borderRadius;
  final BorderRadiusGeometry? inkImageBorder;
  final Widget? error;
  final bool useInk;
  static Widget? errorWidget;
  final Alignment? alignment;

  /// Optional override for the decode width (in logical pixels) used for the
  /// in-memory cache. When null the widget derives it from the laid-out
  /// constraints and the device pixel ratio so images are never decoded at
  /// their full source resolution.
  final int? memCacheWidth;

  /// Optional override for the decode height. See [memCacheWidth].
  final int? memCacheHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dpr = MediaQuery.devicePixelRatioOf(context);
        int? resolvedCacheWidth = memCacheWidth;
        int? resolvedCacheHeight = memCacheHeight;
        // Derive a sensible decode size from the actual layout so thumbnails
        // are not decoded at full source resolution.
        if (resolvedCacheWidth == null && resolvedCacheHeight == null) {
          if (constraints.maxWidth.isFinite && constraints.maxWidth > 0) {
            resolvedCacheWidth = (constraints.maxWidth * dpr).round();
          } else if (constraints.maxHeight.isFinite &&
              constraints.maxHeight > 0) {
            resolvedCacheHeight = (constraints.maxHeight * dpr).round();
          }
        }
        if (resolvedCacheWidth != null && resolvedCacheWidth <= 0) {
          resolvedCacheWidth = null;
        }
        if (resolvedCacheHeight != null && resolvedCacheHeight <= 0) {
          resolvedCacheHeight = null;
        }
        return CachedNetworkImage(
          imageUrl: imageUrl,
          alignment: alignment ?? Alignment.center,
          imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          memCacheWidth: resolvedCacheWidth,
          memCacheHeight: resolvedCacheHeight,
          imageBuilder: useInk
              ? (context, imageProvider) => Ink(
                    decoration: BoxDecoration(
                        borderRadius: inkImageBorder,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: fit,
                          alignment: alignment ?? Alignment.center,
                        )),
                  )
              : null,
          fit: fit,
          errorWidget: error == null && errorWidget == null
              ? null
              : (_, __, ___) => error ?? errorWidget!,
          progressIndicatorBuilder: (context, url, progress) => BaseShimmer(
            borderRadius: borderRadius,
          ),
        );
      },
    );
  }
}
