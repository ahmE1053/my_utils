import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../consts/app_localization_keys.g.dart';
import 'text_field.dart';
import 'utils/full_text_field_model.dart';

class MyNameTextField extends StatelessWidget {
  const MyNameTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        label: LocaleKeys.fullName.tr(),
        hint: LocaleKeys.fullName.tr(),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.tr();
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.tr();
          }
          return null;
        },
      ),
    );
  }
}

class MyFirstNameTextField extends StatelessWidget {
  const MyFirstNameTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        label: LocaleKeys.firstName.tr(),
        hint: LocaleKeys.firstName.tr(),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.tr();
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.tr();
          }
          return null;
        },
      ),
    );
  }
}

class MySecondNameTextField extends StatelessWidget {
  const MySecondNameTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        label: LocaleKeys.secondName.tr(),
        hint: LocaleKeys.secondName.tr(),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.tr();
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.tr();
          }
          return null;
        },
      ),
    );
  }
}

class MyLastNameTextField extends StatelessWidget {
  const MyLastNameTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        label: LocaleKeys.lastName.tr(),
        hint: LocaleKeys.lastName.tr(),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.tr();
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.tr();
          }
          return null;
        },
      ),
    );
  }
}
