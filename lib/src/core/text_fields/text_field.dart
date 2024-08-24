import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';

import '../consts/app_localization_keys.g.dart';
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
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    textFieldModel = widget.textFieldModel;
    return ListenableBuilder(
      listenable: Listenable.merge([textFieldDirection, obscureText]),
      builder: (context, _) {
        return TextFormField(
          expands: textFieldModel.expands,
          onTap: textFieldModel.onTap,
          autocorrect: textFieldModel.enableAutoCorrection,
          enableIMEPersonalizedLearning: textFieldModel.enableAutoCorrection,
          enableSuggestions: textFieldModel.enableAutoCorrection,
          key: textFieldModel.fieldFormStateKey,
          onTapOutside: textFieldModel.onTapOutside,
          focusNode: textFieldModel.focusNode,
          textDirection:
              textFieldModel.textDirection ?? textFieldDirection.value,
          controller: textFieldModel.controller,
          validator: textFieldModel.validator,
          autovalidateMode: textFieldModel.validationMode,
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
          minLines: textFieldModel.minLines,
          maxLines: textFieldModel.maxLines,
          enabled: textFieldModel.enabled ?? true,
          style: textFieldModel.style ?? TextFieldModel.globalTextStyle,
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
              inputDecorationTheme.border!,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            disabledBorder: changeBorderDetails(
              inputDecorationTheme.disabledBorder!,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            errorBorder: changeBorderDetails(
              inputDecorationTheme.errorBorder!,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            focusedErrorBorder: changeBorderDetails(
              inputDecorationTheme.focusedErrorBorder!,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            focusedBorder: changeBorderDetails(
              inputDecorationTheme.enabledBorder!,
              newColor: textFieldModel.focusedBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            enabledBorder: changeBorderDetails(
              inputDecorationTheme.enabledBorder!,
              newColor: textFieldModel.enabledBorder,
              newBorderRadius: textFieldModel.allBorderRadius,
            ),
            errorMaxLines: 5,
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

  InputBorder changeBorderDetails(
    InputBorder defaultDecoration, {
    Color? newColor,
    double? newBorderRadius,
  }) =>
      (defaultDecoration as OutlineInputBorder).copyWith(
        borderRadius: newBorderRadius == null
            ? defaultDecoration.borderRadius
            : BorderRadius.circular(newBorderRadius),
        borderSide: BorderSide(
          color: newColor ?? defaultDecoration.borderSide.color,
        ),
      );
}

class TextFieldValidators {
  String? requiredField(String? value) =>
      value!.trim().isEmpty ? LocaleKeys.requiredField.tr() : null;
}
