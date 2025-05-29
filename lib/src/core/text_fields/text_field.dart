import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../consts/app_localization_keys.g.dart';

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
  late TextFieldModel textFieldModel;

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

  String? languageCode;

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
      if (value.isEmpty) {
        try {
          textFieldDirection.value =
              context.isArabic ? TextDirection.rtl : TextDirection.ltr;
        } catch (e) {}
      }
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

  void changeCursorLocation() {
    try {
      if (languageCode == null) {
        languageCode = Localizations.localeOf(context).languageCode;
      } else {
        if (languageCode != Localizations.localeOf(context).languageCode) {
          languageCode = Localizations.localeOf(context).languageCode;
          textFieldDirectionListener();
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    changeCursorLocation();
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    textFieldModel = widget.textFieldModel;
    return ListenableBuilder(
      listenable: Listenable.merge([textFieldDirection, obscureText]),
      builder: (context, _) {
        return TextFormField(
          expands: textFieldModel.expands,
          onTap: () {
            if (textFieldDirection.value == TextDirection.rtl) {
              final controller = textFieldModel.controller;
              final tryToSelectLastChar = controller.selection ==
                  TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length - 1),
                  );
              if (tryToSelectLastChar) {
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
                setState(() {});
              }
            }
            if (textFieldModel.onTap != null) {
              textFieldModel.onTap!();
            }
          },
          autocorrect: textFieldModel.enableAutoCorrection,
          enableIMEPersonalizedLearning: textFieldModel.enableAutoCorrection,
          enableSuggestions: textFieldModel.enableAutoCorrection,
          key: textFieldModel.fieldFormStateKey,
          onTapOutside: textFieldModel.onTapOutside,
          maxLength: textFieldModel.maxLength,
          focusNode: textFieldModel.focusNode,
          textDirection:
              textFieldModel.textDirection ?? textFieldDirection.value,
          controller: textFieldModel.controller,
          validator: textFieldModel.validator,
          autovalidateMode:
              textFieldModel.validationMode ?? AutovalidateMode.onUnfocus,
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
          enableInteractiveSelection: textFieldModel.enableInteractiveSelection,
          minLines: textFieldModel.expands ? null : textFieldModel.minLines,
          maxLines: textFieldModel.expands ? null : textFieldModel.maxLines,
          enabled: textFieldModel.enabled ?? true,
          style: textFieldModel.style ?? defaultTextStlye,
          textAlign: textFieldModel.textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            alignLabelWithHint: (textFieldModel.maxLines) > 1 ? true : false,
            floatingLabelStyle: textFieldModel.floatingLabelStyle,
            fillColor:
                textFieldModel.fillColor ?? inputDecorationTheme.fillColor,
            errorStyle: textFieldModel.errorStyle,
            filled:
                (textFieldModel.fillColor ?? inputDecorationTheme.fillColor) !=
                    null,
            isDense: textFieldModel.isDense ?? true,
            border: changeBorderDetails(
              inputDecorationTheme.border,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            disabledBorder: changeBorderDetails(
              inputDecorationTheme.disabledBorder,
              newColor: textFieldModel.disabledBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            errorBorder: changeBorderDetails(
              inputDecorationTheme.errorBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            focusedErrorBorder: changeBorderDetails(
              inputDecorationTheme.focusedErrorBorder,
              newColor: textFieldModel.focusedBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            focusedBorder: changeBorderDetails(
              inputDecorationTheme.focusedBorder,
              newColor: textFieldModel.focusedBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            enabledBorder: changeBorderDetails(
              inputDecorationTheme.enabledBorder,
              newColor: textFieldModel.enabledBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            errorMaxLines: 10,
            contentPadding: textFieldModel.contentPadding,
            prefixIcon: textFieldModel.prefix,
            hintText:
                textFieldModel.useHint == false ? null : textFieldModel.hint,
            label:
                textFieldModel.label == null || textFieldModel.useLabel == false
                    ? null
                    : Text(textFieldModel.label!),
            hintStyle:
                textFieldModel.hintStyle ?? inputDecorationTheme.hintStyle,
            labelStyle:
                textFieldModel.labelStyle ?? inputDecorationTheme.labelStyle,
            suffixIcon: textFieldModel.isPassword &&
                    textFieldModel.suffix == null &&
                    textFieldModel.showPasswordVisibleIcon
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      obscureText.value = !obscureText.value;
                    },
                    icon: SvgPicture(
                      AssetBytesLoader(
                        'packages/my_utils/assets/eye${obscureText.value ? '_slash' : ''}.svg.vec',
                      ),
                    ),
                  )
                : textFieldModel.suffix,
          ),
        );
      },
    );
  }

  TextStyle? get defaultTextStlye {
    if (TextFieldModel.globalDarkTextFieldTextStyle != null &&
        context.isDarkMode) {
      return TextFieldModel.globalDarkTextFieldTextStyle;
    }
    return TextFieldModel.globalTextStyle;
  }

  InputBorder changeBorderDetails(
    InputBorder? defaultDecoration, {
    Color? newColor,
    double? newBorderRadius,
  }) =>
      defaultDecoration == null
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(newBorderRadius ?? 4),
              borderSide: BorderSide(color: newColor ?? Colors.red),
            )
          : (defaultDecoration as OutlineInputBorder).copyWith(
              borderRadius: newBorderRadius == null
                  ? defaultDecoration.borderRadius
                  : BorderRadius.circular(newBorderRadius),
              borderSide: BorderSide(
                color: newColor ?? defaultDecoration.borderSide.color,
              ),
            );
}

class TextFieldValidators {
  final String? message;

  TextFieldValidators([this.message]);

  String? requiredField(String? value) =>
      value!.trim().isEmpty ? (message ?? LocaleKeys.requiredField).translate() : null;
}
