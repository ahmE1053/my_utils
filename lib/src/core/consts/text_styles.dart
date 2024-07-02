import 'package:flutter/material.dart';

abstract class MyUtilAppTextStyle {

  static TextStyle getTextStyle({
    double? fontSize,
    Color? color,
    bool? underlineDecoration,
    int fontWeight = 400,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: _getWeight(fontWeight),
        decorationColor: color,
        decoration:
        underlineDecoration ?? false ? TextDecoration.underline : null,
      );

  static FontWeight _getWeight(int weightNumber) {
    assert(
    weightNumber == 100 ||
        weightNumber == 200 ||
        weightNumber == 300 ||
        weightNumber == 400 ||
        weightNumber == 500 ||
        weightNumber == 600 ||
        weightNumber == 700 ||
        weightNumber == 800 ||
        weightNumber == 900,
    );
    return FontWeight.values.firstWhere(
          (element) => element.value == weightNumber,
    );
  }
}
