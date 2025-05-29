import 'package:flutter/material.dart';

extension MediaQueryHelper on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primaryColor => colorScheme.primary;

  Color get secondaryColor => colorScheme.secondary;

  Color get primaryContainerColor => colorScheme.primaryContainer;

  Color get secondaryContainerColor => colorScheme.secondaryContainer;

  Color get errorColor => colorScheme.error;

  double get topViewPadding => MediaQuery.viewPaddingOf(this).top;

  double get bottomViewPadding => MediaQuery.viewPaddingOf(this).bottom;

  double get bottomViewInsets => MediaQuery.viewInsetsOf(this).bottom;

  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  //
  // AppColors get colors => Theme.of(this).extension<AppColors>()!;
  //
  // NewAppColors get newColors => Theme.of(this).extension<NewAppColors>()!;

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  bool get isShowingCurrentContext => ModalRoute.of(this)?.isCurrent == true;

  RelativeRect get getPlace {
    final RenderBox button = findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(this).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
// void setToArabic() => setLocale(const Locale('ar'));
// void setToEnglish() => setLocale(const Locale('en'));
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }

  Size get getSize {
    final renderObject = currentContext?.findRenderObject();
    return (renderObject as RenderBox).size;
  }
}
