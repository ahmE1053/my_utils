import 'package:flutter/material.dart';

class MyUtilAppConsts {
  static final borderRadius24 = BorderRadius.circular(24);
  static final borderRadius8 = BorderRadius.circular(8);
  static final borderRadius4 = BorderRadius.circular(4);
  static final borderRadius12 = BorderRadius.circular(12);
  static final buttonBorderRadius = BorderRadius.circular(12);

  static const lightShadow = BoxShadow(
    color: Color(0xffe8e8e8),
    spreadRadius: 2,
    blurRadius: 10,
  );
  static const veryLightShadow = BoxShadow(
    color: Color(0xffefefef),
    spreadRadius: 2,
    blurRadius: 2,
  );
  static const heavyShadow = BoxShadow(
    color: Color(0xffdadada),
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
