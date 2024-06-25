import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import '../consts/app_localization_keys.g.dart';
import '../string_extensions.dart';
import 'text_field.dart';
import 'utils/full_text_field_model.dart';

class MyPasswordTextField extends StatelessWidget {
  const MyPasswordTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        textDirection: TextDirection.ltr,
        label: LocaleKeys.password.tr(),
        hint: LocaleKeys.password.tr(),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return LocaleKeys.emptyPassword.tr();
          }
          return null;
        },
      ),
    );
  }
}

class MyRegisterPasswordTextField extends StatelessWidget {
  const MyRegisterPasswordTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        textDirection: TextDirection.ltr,
        label: LocaleKeys.password.tr(),
        hint: LocaleKeys.password.tr(),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return LocaleKeys.emptyPassword.tr();
          }
          if (!value.isStrongPassword()) {
            return LocaleKeys.weakPassword.tr();
          }
          return null;
        },
      ),
    );
  }
}

class MyConfirmPasswordField extends StatelessWidget {
  const MyConfirmPasswordField({
    super.key,
    required this.passwordController,
    required this.textFieldModel,
  });

  final TextEditingController passwordController;
  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        textDirection: TextDirection.ltr,
        label: LocaleKeys.password.tr(),
        hint: LocaleKeys.password.tr(),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyPassword.tr();
          }
          if (value != passwordController.text) {
            return LocaleKeys.wrongConfirmPassword.tr();
          }
          return null;
        },
      ),
    );
  }
}
