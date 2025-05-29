import 'package:flutter/material.dart';
import '../../../my_utils.dart';
import '../consts/app_localization_keys.g.dart';

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
        label: LocaleKeys.email.translate(context),
        hint: LocaleKeys.email.translate(context),
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyEmail.translate(context);
          }
          if (!value.isValidEmail()) {
            return LocaleKeys.wrongEmail.translate(context);
          }
          return null;
        },
      ),
    );
  }
}
