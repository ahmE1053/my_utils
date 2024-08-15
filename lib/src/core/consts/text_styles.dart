import 'package:flutter/material.dart';

class MyUtilAppTextStyle extends TextStyle {
  const MyUtilAppTextStyle.getTextStyle({
    super.fontSize,
    super.color,
    bool? underlineDecoration,
    int fontWeight = 400,
  })  : assert(fontWeight >= 100 && fontWeight <= 900 && fontWeight % 100 == 0,
            'fontWeight must be between 100 and 900 in increments of 100'),
        super(
          fontFamily: 'Nunito',
          fontFamilyFallback: const ['NotoKufiArabic'],
          fontWeight: fontWeight == 100
              ? FontWeight.w100
              : fontWeight == 200
                  ? FontWeight.w200
                  : fontWeight == 300
                      ? FontWeight.w300
                      : fontWeight == 400
                          ? FontWeight.w400
                          : fontWeight == 500
                              ? FontWeight.w600
                              : fontWeight == 700
                                  ? FontWeight.w700
                                  : fontWeight == 800
                                      ? FontWeight.w800
                                      : FontWeight.w900,
          decorationColor: color,
          decoration:
              underlineDecoration ?? false ? TextDecoration.underline : null,
        );
}
