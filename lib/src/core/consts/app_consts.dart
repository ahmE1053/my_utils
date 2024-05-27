import 'package:flutter/material.dart';

class MyUtilAppConsts {
  static final borderRadius24 = BorderRadius.circular(24);
  static final borderRadius8 = BorderRadius.circular(8);
  static final borderRadius4 = BorderRadius.circular(4);
  static final borderRadius12 = BorderRadius.circular(12);
  static final buttonBorderRadius = BorderRadius.circular(12);
  // static final primaryGradient = LinearGradient(
  //   colors: [
  //     LightAppColors.primary,
  //   ],
  //   begin: Alignment.topRight,
  //   end: Alignment.bottomLeft,
  // );
  static final lightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.07),
    spreadRadius: 2,
    blurRadius: 10,
  );
  static final veryLightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.04),
    spreadRadius: 2,
    blurRadius: 2,
  );
  static final heavyShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 2,
    blurRadius: 10,
  );
  static const borderRadiusOnlyTop24 = BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
  );
  static const duration250ms = Duration(milliseconds: 250);
  static const duration500ms = Duration(milliseconds: 500);
  static const duration750ms = Duration(milliseconds: 750);
  static const duration1s = Duration(milliseconds: 1000);
}
