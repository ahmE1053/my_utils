import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../consts/app_localization_keys.g.dart';
import 'text_field.dart';
import 'utils/full_text_field_model.dart';

class MyPhoneTextField extends StatelessWidget {
  const MyPhoneTextField({
    super.key,
    required this.textFieldModel,
  });

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      textFieldModel: textFieldModel.replaceIfNull(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textDirection: TextDirection.ltr,
        label: LocaleKeys.phoneNumber.tr(),
        hint: LocaleKeys.phoneNumber.tr(),
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.emptyPhone.tr();
          }
          return null;
        },
      ),
    );
  }
}
