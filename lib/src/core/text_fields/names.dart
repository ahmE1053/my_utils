import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../consts/app_localization_keys.g.dart';

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
        label: LocaleKeys.fullName.translate(context),
        hint: LocaleKeys.fullName.translate(context),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.translate(context);
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.translate(context);
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
        label: LocaleKeys.firstName.translate(context),
        hint: LocaleKeys.firstName.translate(context),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.translate(context);
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.translate(context);
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
        label: LocaleKeys.secondName.translate(context),
        hint: LocaleKeys.secondName.translate(context),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.translate(context);
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.translate(context);
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
        label: LocaleKeys.lastName.translate(context),
        hint: LocaleKeys.lastName.translate(context),
        textInputType: TextInputType.name,
        inputFormatters: [
          textFieldModel.getNameFormatter,
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyName.translate(context);
          }
          if (value.length < 2) {
            return LocaleKeys.smallName.translate(context);
          }
          return null;
        },
      ),
    );
  }
}
