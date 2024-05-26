import 'package:flutter/material.dart'
    show BoxConstraints, Color, EdgeInsets, FocusNode, FormFieldState, GlobalKey, TextAlign, TextDirection, TextEditingController, TextInputAction, TextInputType, TextStyle, ValueNotifier, Widget;
import 'package:flutter/services.dart' show TextInputFormatter;

import '../phone_country_text_field/phone_field_notifier.dart';

class TextFieldModel {
  final bool isPassword;
  final ValueNotifier<bool>? obscureText;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final String? label, hint;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final GlobalKey<FormFieldState>? fieldFormStateKey;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? action;
  final TextInputType? textInputType;
  final Color? fillColor;
  final TextStyle? hintStyle, labelStyle, floatingLabelStyle;
  final Widget? suffix, prefix;
  final TextEditingController controller;
  final int maxLines;
  final int? minLines;
  final TextDirection? textDirection;
  final BoxConstraints? suffixBoxConstraints;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final bool? isDense;
  final bool useLabel;
  final bool useHint;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final Color? textColor;
  final bool? enabled;
  final Color? focusedBorder;
  final Color? enabledBorder;
  final Iterable<String>? autofillHints;
  final void Function(dynamic event)? onTapOutside;
  final void Function(TextEditingController value)? onEditingComplete;

  const TextFieldModel({
    required this.controller,
    this.isPassword = false,
    this.useLabel = false,
    this.useHint = false,
    this.validator,
    this.obscureText,
    this.onChanged,
    this.label,
    this.errorStyle,
    this.fieldFormStateKey,
    this.hint,
    this.style,
    this.inputFormatters,
    this.action,
    this.textInputType,
    this.fillColor,
    this.hintStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.minLines,
    this.textDirection,
    this.suffixBoxConstraints,
    this.padding,
    this.contentPadding,
    this.isDense,
    this.focusNode,
    this.textAlign,
    this.textColor,
    this.enabled,
    this.focusedBorder,
    this.enabledBorder,
    this.autofillHints,
    this.onTapOutside,
    this.onEditingComplete,
  });

  TextFieldModel.fromPhoneNotifier({
    required PhoneFieldNotifier phoneFieldNotifier,
    this.isPassword = false,
    this.useLabel = false,
    this.useHint = false,
    this.validator,
    this.obscureText,
    this.onChanged,
    this.label,
    this.errorStyle,
    this.fieldFormStateKey,
    this.hint,
    this.style,
    this.inputFormatters,
    this.action,
    this.textInputType,
    this.fillColor,
    this.hintStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.minLines,
    this.textDirection,
    this.suffixBoxConstraints,
    this.padding,
    this.contentPadding,
    this.isDense,
    this.focusNode,
    this.textAlign,
    this.textColor,
    this.enabled,
    this.focusedBorder,
    this.enabledBorder,
    this.autofillHints,
    this.onTapOutside,
    this.onEditingComplete,
  }) : controller = phoneFieldNotifier.controller;

  TextFieldModel replaceIfNull({
    bool? isPassword,
    bool? useLabel,
    bool? useHint,
    String? Function(String? value)? validator,
    void Function(String? value)? onChanged,
    String? label,
    String? hint,
    TextStyle? style,
    TextStyle? errorStyle,
    GlobalKey<FormFieldState>? fieldFormStateKey,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? action,
    TextInputType? textInputType,
    Color? fillColor,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    Widget? suffix,
    Widget? prefix,
    int? maxLines,
    int? minLines,
    TextDirection? textDirection,
    BoxConstraints? suffixBoxConstraints,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    bool? isDense,
    FocusNode? focusNode,
    TextAlign? textAlign,
    Color? textColor,
    bool? enabled,
    Color? focusedBorder,
    Color? enabledBorder,
    Iterable<String>? autofillHints,
    void Function(dynamic event)? onTapOutside,
    void Function(TextEditingController value)? onEditingComplete,
  }) =>
      TextFieldModel(
        controller: controller,
        isPassword: isPassword ?? this.isPassword,
        validator: validator ?? this.validator,
        onChanged: onChanged ?? this.onChanged,
        label: label ?? this.label,
        hint: hint ?? this.hint,
        useLabel: useLabel ?? this.useLabel,
        useHint: useHint ?? this.useHint,
        style: style ?? this.style,
        errorStyle: errorStyle ?? this.errorStyle,
        fieldFormStateKey: fieldFormStateKey ?? this.fieldFormStateKey,
        inputFormatters: inputFormatters ?? this.inputFormatters,
        action: action ?? this.action,
        textInputType: textInputType ?? this.textInputType,
        fillColor: fillColor ?? this.fillColor,
        hintStyle: hintStyle ?? this.hintStyle,
        labelStyle: labelStyle ?? this.labelStyle,
        floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
        suffix: suffix ?? this.suffix,
        prefix: prefix ?? this.prefix,
        maxLines: maxLines ?? this.maxLines,
        minLines: minLines ?? this.minLines,
        textDirection: textDirection ?? this.textDirection,
        suffixBoxConstraints: suffixBoxConstraints ?? this.suffixBoxConstraints,
        padding: padding ?? this.padding,
        contentPadding: contentPadding ?? this.contentPadding,
        isDense: isDense ?? this.isDense,
        focusNode: focusNode ?? this.focusNode,
        textAlign: textAlign ?? this.textAlign,
        textColor: textColor ?? this.textColor,
        enabled: enabled ?? this.enabled,
        focusedBorder: focusedBorder ?? this.focusedBorder,
        enabledBorder: enabledBorder ?? this.enabledBorder,
        autofillHints: autofillHints ?? this.autofillHints,
        onTapOutside: onTapOutside ?? this.onTapOutside,
        onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      );

  TextInputFormatter get getNameFormatter =>
      TextInputFormatter.withFunction(
            (oldValue, newValue) {
          bool returnNew = true;
          for (int i = 0; i < newValue.text.length; i++) {
            if (newValue.text[i].contains(
              RegExp(r'^[0-9!@#$%^&*()_+\[\]{}:;"<>?,./|\\]+$'),
            )) {
              returnNew = false;
            }
          }
          if (!returnNew) {
            return oldValue;
          }
          return newValue;
        },
      );
}
