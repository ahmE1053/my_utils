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
          fontVariations: fontWeight == 100
              ? const [
                  FontVariation.weight(
                    100,
                  ),
                ]
              : fontWeight == 200
                  ? const [
                      FontVariation.weight(
                        200,
                      ),
                    ]
                  : fontWeight == 300
                      ? const [
                          FontVariation.weight(
                            300,
                          ),
                        ]
                      : fontWeight == 400
                          ? const [
                              FontVariation.weight(
                                400,
                              ),
                            ]
                          : fontWeight == 500
                              ? const [
                                  FontVariation.weight(
                                    500,
                                  ),
                                ]
                              : fontWeight == 600
                                  ? const [
                                      FontVariation.weight(
                                        600,
                                      ),
                                    ]
                                  : fontWeight == 700
                                      ? const [
                                          FontVariation.weight(
                                            700,
                                          ),
                                        ]
                                      : fontWeight == 800
                                          ? const [
                                              FontVariation.weight(
                                                800,
                                              ),
                                            ]
                                          : const [
                                              FontVariation.weight(
                                                900,
                                              ),
                                            ],
          decorationColor: color,
          decoration:
              underlineDecoration ?? false ? TextDecoration.underline : null,
        );
}
