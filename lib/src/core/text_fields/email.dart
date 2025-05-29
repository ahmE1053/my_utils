import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import '../consts/app_localization_keys.g.dart';
import '../string_extensions.dart';
import 'text_field.dart';
import 'utils/full_text_field_model.dart';

class MyEmailTextField extends StatelessWidget {
  const MyEmailTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        textDirection: TextDirection.ltr,
        label: LocaleKeys.email.tr(),
        hint: LocaleKeys.email.tr(),
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyEmail.tr();
          }
          if (!value.isValidEmail()) {
            return LocaleKeys.wrongEmail.tr();
          }
          return null;
        },
      ),
    );
  }
}
