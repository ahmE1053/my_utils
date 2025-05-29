import 'package:flutter/material.dart';

String Function(String value, BuildContext? context)? _translator;

extension TranslationExtension on String {
  String translate([BuildContext? context]) => _translator?.call(this, context) ?? this;
}
