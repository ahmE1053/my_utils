import 'package:flutter/material.dart';
import 'package:my_utils/src/translator.dart';

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
        label: LocaleKeys.password.translate(context),
        hint: LocaleKeys.password.translate(context),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return LocaleKeys.emptyPassword.translate(context);
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
        label: LocaleKeys.password.translate(context),
        hint: LocaleKeys.password.translate(context),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return LocaleKeys.emptyPassword.translate(context);
          }
          if (!value.isStrongPassword()) {
            return LocaleKeys.weakPassword.translate(context);
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
        label: LocaleKeys.confirmPassword.translate(context),
        hint: LocaleKeys.confirmPassword.translate(context),
        textInputType: TextInputType.visiblePassword,
        isPassword: true,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyPassword.translate(context);
          }
          if (value != passwordController.text) {
            return LocaleKeys.wrongConfirmPassword.translate(context);
          }
          return null;
        },
      ),
    );
  }
}
