import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class MyUserAvatar extends StatelessWidget {
  const MyUserAvatar({
    super.key,
    required this.userName,
    required this.userId,
    this.userImage,
    this.shape,
    this.borderRadius,
    this.boxFit,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.letters = 1,
    this.width = 24,
    this.height = 24,
    this.useInk = false,
    this.imageAlignment,
  });

  final String userId;
  final String userName;
  final double width;
  final double height;
  final EdgeInsets? padding;
  final BoxFit? boxFit;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final int letters;
  final Alignment? imageAlignment;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;
  final String? userImage;
  final bool useInk;

  @override
  Widget build(BuildContext context) {
    late Widget namedAvatar;
    final lettersText =
        userName.split(' ').take(letters).map((e) => e[0]).join('');
    if (useInk) {
      namedAvatar = Ink(
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.circle,
          borderRadius: borderRadius,
          color: backgroundColor ?? getColorFromStringHSL(userId),
        ),
        padding: padding ?? EdgeInsets.all(8),
        child: FittedBox(
          fit: boxFit ?? BoxFit.scaleDown,
          child: Text(
            lettersText,
            style: MyUtilAppTextStyle.getTextStyle(
              fontWeight: 500,
              color: foregroundColor ?? Colors.white,
            ),
          ),
        ),
      );
    } else {
      namedAvatar = Container(
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.circle,
          borderRadius: borderRadius,
          color: backgroundColor ?? getColorFromStringHSL(userId),
        ),
        padding: padding ?? EdgeInsets.all(8),
        child: FittedBox(
          fit: boxFit ?? BoxFit.scaleDown,
          child: Text(
            lettersText,
            style: MyUtilAppTextStyle.getTextStyle(
              fontWeight: 500,
              color: foregroundColor ?? Colors.white,
            ),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(100),
      child: CachedNetworkImageWithLoader(
        imageUrl: userImage ?? '-',
        fit: BoxFit.cover,
        alignment: imageAlignment,
        error: SizedBox(
          width: width,
          height: height,
          child: namedAvatar,
        ),
      ),
    );
  }
}

/// Returns a consistent color for a given string with good contrast for white text.
/// The same string will always produce the same color on any platform.
Color getColorFromString(String input) {
  // Step 1: Generate a consistent hash from the string
  int hash = 0;
  for (int i = 0; i < input.length; i++) {
    hash = input.codeUnitAt(i) + ((hash << 5) - hash);
  }

  // Step 2: Convert hash to RGB values
  int r = (hash & 0xFF0000) >> 16;
  int g = (hash & 0x00FF00) >> 8;
  int b = hash & 0x0000FF;

  // Step 3: Ensure good contrast with white
  // Calculate luminance (simplified formula)
  final double luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;

  // If too bright (poor contrast with white), darken the color
  if (luminance > 0.55) {
    final double darkenFactor = 0.7; // Adjust this value as needed
    r = (r * darkenFactor).round().clamp(0, 255);
    g = (g * darkenFactor).round().clamp(0, 255);
    b = (b * darkenFactor).round().clamp(0, 255);
  }

  return Color.fromRGBO(r, g, b, 1.0);
}

/// Alternative method that uses HSL to ensure good contrast and vibrant colors
Color getColorFromStringHSL(String input) {
  // Generate a deterministic hash
  int hash = 0;
  for (int i = 0; i < input.length; i++) {
    hash = input.codeUnitAt(i) + ((hash << 5) - hash);
  }

  // Use the hash to generate a hue (0-360)
  final double hue = (hash % 360).abs().toDouble();

  // Fix saturation and lightness to ensure vibrant colors with good contrast
  // Saturation between 65% and 90% makes colors vibrant
  final double saturation = 0.75;

  // Lightness between 25% and 50% ensures good contrast with white text
  final double lightness = 0.35;

  // Convert HSL to RGB
  return _hslToColor(hue, saturation, lightness);
}

/// Helper function to convert HSL to Color
Color _hslToColor(double h, double s, double l) {
  // Implementation of HSL to RGB conversion
  double r, g, b;

  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    double hue2rgb(double p, double q, double t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    }

    final double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    final double p = 2 * l - q;
    r = hue2rgb(p, q, (h / 360) + 1 / 3);
    g = hue2rgb(p, q, h / 360);
    b = hue2rgb(p, q, (h / 360) - 1 / 3);
  }

  return Color.fromRGBO(
      (r * 255).round(), (g * 255).round(), (b * 255).round(), 1.0);
}
