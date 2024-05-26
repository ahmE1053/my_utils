import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart'
    show BorderSide, BuildContext, Colors, EdgeInsets, IconButton, InputDecoration, Listenable, ListenableBuilder, State, StatefulWidget, Text, TextAlign, TextDirection, TextFormField, TextStyle, Theme, ValueNotifier, Widget;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../consts/app_localization_keys.g.dart';
import 'utils/full_text_field_model.dart';
import 'utils/get_text_field_direction.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late final ValueNotifier<TextDirection> textFieldDirection;
  late final ValueNotifier<bool> obscureText;
  late final void Function() textFieldDirectionListener;
  late final TextFieldModel textFieldModel;

  TextDirection get getInitDirection {
    String value = textFieldModel.controller.text.trim();
    if (value.isNotEmpty) {
      for (int i = 0; i < value.length; i++) {
        if (double.tryParse(value[i]) == null) {
          return getDirection(value[i]);
        }
      }
    }
    return TextDirection.ltr;
  }

  @override
  void initState() {
    super.initState();
    textFieldModel = widget.textFieldModel;
    textFieldDirection = ValueNotifier(getInitDirection);
    obscureText =
        textFieldModel.obscureText ?? ValueNotifier(textFieldModel.isPassword);
    textFieldDirectionListener = () {
      String value = textFieldModel.controller.text;
      value = value.trim();
      for (int i = 0; i < value.length; i++) {
        if (value[i] == ' ') continue;
        if (double.tryParse(value[i]) == null) {
          textFieldDirection.value = getDirection(value[i]);
          break;
        }
      }
    };
    textFieldModel.controller.addListener(textFieldDirectionListener);
  }

  @override
  void dispose() {
    textFieldDirection.dispose();
    if (textFieldModel.obscureText == null) {
      obscureText.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme
        .of(context)
        .inputDecorationTheme;
    return ListenableBuilder(
      listenable: Listenable.merge([textFieldDirection, obscureText]),
      builder: (context, _) {
        return TextFormField(
          key: textFieldModel.fieldFormStateKey,
          onTapOutside: textFieldModel.onTapOutside,
          focusNode: textFieldModel.focusNode,
          textDirection:
          textFieldModel.textDirection ?? textFieldDirection.value,
          controller: textFieldModel.controller,
          validator: textFieldModel.validator,
          onEditingComplete: () {
            if (textFieldModel.onEditingComplete != null) {
              textFieldModel.onEditingComplete!(textFieldModel.controller);
            }
          },
          autofillHints: textFieldModel.autofillHints,
          onChanged: textFieldModel.onChanged,
          inputFormatters: textFieldModel.inputFormatters,
          autofocus: false,
          textInputAction: textFieldModel.action,
          keyboardType: textFieldModel.textInputType,
          obscureText: obscureText.value,
          obscuringCharacter: '•',
          minLines: textFieldModel.minLines,
          maxLines: textFieldModel.maxLines,
          enabled: textFieldModel.enabled ?? true,
          style: textFieldModel.style ??
              const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
          textAlign: textFieldModel.textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            alignLabelWithHint:
            (textFieldModel.maxLines ?? 0) > 1 ? true : false,
            floatingLabelStyle: textFieldModel.floatingLabelStyle,
            fillColor:
            textFieldModel.fillColor ?? inputDecorationTheme.fillColor,
            errorStyle: textFieldModel.errorStyle,
            filled:
            (textFieldModel.fillColor ?? inputDecorationTheme.fillColor) !=
                null,
            isDense: textFieldModel.isDense ?? true,
            border: inputDecorationTheme.border,
            disabledBorder: inputDecorationTheme.disabledBorder,
            errorBorder: inputDecorationTheme.errorBorder,
            focusedErrorBorder: inputDecorationTheme.focusedErrorBorder,
            focusedBorder:
            Theme
                .of(context)
                .inputDecorationTheme
                .focusedBorder!
                .copyWith(
              borderSide: BorderSide(
                color: textFieldModel.focusedBorder ??
                    Theme
                        .of(context)
                        .inputDecorationTheme
                        .focusedBorder!
                        .borderSide
                        .color,
              ),
            ),
            enabledBorder:
            Theme
                .of(context)
                .inputDecorationTheme
                .enabledBorder!
                .copyWith(
              borderSide: BorderSide(
                color: textFieldModel.enabledBorder ??
                    Theme
                        .of(context)
                        .inputDecorationTheme
                        .enabledBorder!
                        .borderSide
                        .color,
              ),
            ),
            errorMaxLines: 5,
            contentPadding: textFieldModel.contentPadding,
            prefixIcon: textFieldModel.prefix,
            hintText: textFieldModel.useHint ? textFieldModel.hint : null,
            label: textFieldModel.label == null || !textFieldModel.useLabel
                ? null
                : Text(textFieldModel.label!),
            hintStyle:
            textFieldModel.hintStyle ?? inputDecorationTheme.hintStyle,
            labelStyle:
            textFieldModel.labelStyle ?? inputDecorationTheme.labelStyle,
            suffixIcon:
            textFieldModel.isPassword && textFieldModel.suffix == null
                ? IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                obscureText.value = !obscureText.value;
              },
              icon: SvgPicture.asset(
                'assets/icons/eye${obscureText.value ? '_slash' : ''}.svg',
              ),
            )
                : textFieldModel.suffix,
          ),
        );
      },
    );
  }
}

class TextFieldValidators {
  String? requiredField(String? value) =>
      value!.trim().isEmpty ? LocaleKeys.requiredField.tr() : null;
}
