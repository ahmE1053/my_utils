import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../phone_country_text_field/phone_field_notifier.dart';

class TextFieldModel {
  final bool isPassword;
  final ValueNotifier<bool>? obscureText;
  final String? Function(String? value)? validator;
  final AutovalidateMode? validationMode;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;
  final String? label, hint;
  final TextStyle? style;
  static TextStyle? globalTextStyle;
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
  final bool? useLabel;
  final bool showPasswordVisibleIcon;
  final bool enableInteractiveSelection;
  final bool enableAutoCorrection;
  final bool? useHint;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final Color? textColor;
  final bool? enabled;
  final Color? focusedBorder;
  final Color? enabledBorder;
  final double? allBorderRadius;
  final Iterable<String>? autofillHints;
  final void Function(dynamic event)? onTapOutside;
  final void Function(TextEditingController value)? onEditingComplete;

  const TextFieldModel({
    required this.controller,
    this.isPassword = false,
    this.showPasswordVisibleIcon = true,
    this.enableInteractiveSelection = true,
    this.enableAutoCorrection = true,
    this.useLabel,
    this.allBorderRadius,
    this.useHint,
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
    this.onTap,
    this.textInputType,
    this.fillColor,
    this.validationMode,
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
    this.showPasswordVisibleIcon = true,
    this.enableInteractiveSelection = true,
    this.enableAutoCorrection = true,
    this.useLabel,
    this.allBorderRadius,
    this.useHint,
    this.onTap,
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
    this.validationMode,
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
    bool? showPasswordVisibleIcon,
    bool? enableInteractiveSelection,
    bool? enableAutoCorrection,
    bool? useHint,
    double? allBorderRadius,
    String? Function(String? value)? validator,
    void Function(String? value)? onChanged,
    String? label,
    String? hint,
    TextStyle? style,
    TextStyle? errorStyle,
    AutovalidateMode? validationMode,
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
        showPasswordVisibleIcon:
            showPasswordVisibleIcon ?? this.showPasswordVisibleIcon,
        enableInteractiveSelection:
            enableInteractiveSelection ?? this.enableInteractiveSelection,
        enableAutoCorrection: enableAutoCorrection ?? this.enableAutoCorrection,
        validator: this.validator ?? validator,
        onChanged: this.onChanged ?? onChanged,
        label: this.label ?? label,
        hint: this.hint ?? hint,
        allBorderRadius: this.allBorderRadius ?? allBorderRadius,
        useLabel: useLabel ?? this.useLabel,
        useHint: useHint ?? this.useHint,
        style: this.style ?? style,
        validationMode: this.validationMode ?? validationMode,
        errorStyle: this.errorStyle ?? errorStyle,
        fieldFormStateKey: this.fieldFormStateKey ?? fieldFormStateKey,
        inputFormatters: this.inputFormatters ?? inputFormatters,
        action: this.action ?? action,
        textInputType: this.textInputType ?? textInputType,
        fillColor: this.fillColor ?? fillColor,
        hintStyle: this.hintStyle ?? hintStyle,
        labelStyle: this.labelStyle ?? labelStyle,
        floatingLabelStyle: this.floatingLabelStyle ?? floatingLabelStyle,
        suffix: this.suffix ?? suffix,
        prefix: this.prefix ?? prefix,
        maxLines: maxLines ?? this.maxLines,
        minLines: this.minLines ?? minLines,
        textDirection: this.textDirection ?? textDirection,
        suffixBoxConstraints: this.suffixBoxConstraints ?? suffixBoxConstraints,
        padding: this.padding ?? padding,
        contentPadding: this.contentPadding ?? contentPadding,
        isDense: this.isDense ?? isDense,
        focusNode: this.focusNode ?? focusNode,
        textAlign: this.textAlign ?? textAlign,
        textColor: this.textColor ?? textColor,
        enabled: this.enabled ?? enabled,
        focusedBorder: this.focusedBorder ?? focusedBorder,
        enabledBorder: this.enabledBorder ?? enabledBorder,
        autofillHints: this.autofillHints ?? autofillHints,
        onTapOutside: this.onTapOutside ?? onTapOutside,
        onEditingComplete: this.onEditingComplete ?? onEditingComplete,
      );

  TextInputFormatter get getNameFormatter => TextInputFormatter.withFunction(
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
