import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';

import '../../../../my_utils.dart';
import '../../context_extensions.dart';
import '../phone.dart';
import '../utils/full_text_field_model.dart';
import 'countries_overlay.dart';
import 'country_selector_button.dart';
import 'phone_field_notifier.dart';

class MyPhoneWithCountryTextField extends StatefulWidget {
  const MyPhoneWithCountryTextField({
    super.key,
    required this.phoneValueNotifier,
    required this.textFieldModel,
    this.height,
    this.codePickerDecoration,
    this.overlayTextStyle,
    this.codePickerArrowColor,
    this.codePickerTextStyle,
    this.overlayDecoration,
    this.textDirection,
    this.codePadding = EdgeInsets.zero,
    this.enabled = true,
  });

  final PhoneFieldNotifier phoneValueNotifier;
  final TextFieldModel textFieldModel;
  final TextDirection? textDirection;
  final double? height;
  final bool enabled;
  final BoxDecoration? codePickerDecoration;
  final BoxDecoration? overlayDecoration;
  final EdgeInsets codePadding;
  final Color? codePickerArrowColor;
  final TextStyle? codePickerTextStyle;
  final TextStyle? overlayTextStyle;

  @override
  State<MyPhoneWithCountryTextField> createState() =>
      _MyPhoneWithCountryTextFieldState();
}

class _MyPhoneWithCountryTextFieldState
    extends State<MyPhoneWithCountryTextField>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final void Function() controllerListener;
  final buttonRectKey = GlobalKey();
  late final OverlayPortalController overlayController;
  late final PhoneFieldNotifier phoneValueNotifier;
  final textFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    phoneValueNotifier = widget.phoneValueNotifier;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    overlayController = OverlayPortalController();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.bottomViewInsets;
    MediaQuery.orientationOf(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (context) =>
            CountriesOverlay(
              buttonRectKey: buttonRectKey,
              textStyle: widget.overlayTextStyle,
              overlayDecoration: widget.overlayDecoration,
              animationController: animationController,
              overlayController: overlayController,
              phoneFieldNotifier: widget.phoneValueNotifier,
            ),
        child: FormField(
          validator: (value) {
            final validator = widget.textFieldModel.validator;
            final fullNumber = widget.phoneValueNotifier.numberWithCountryCode;
            return validator == null
                ? phoneValueNotifier.validator
                : validator(fullNumber);
          },
          builder: (field) {
            if (!field.hasError) return buttonWithTextField;
            textFieldKey.currentState?.validate();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buttonWithTextField,
                const SizedBox(height: 8),
                Directionality(
                  textDirection: widget.textDirection ??
                      (context.isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12.0),
                    child: Text(
                      field.errorText?.tr() ?? '',
                      style: const MyUtilAppTextStyle.getTextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get buttonWithTextField {
    final child = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CountrySelectorButton(
          buttonRectKey: buttonRectKey,
          overlayController: overlayController,
          animationController: animationController,
          phoneValueNotifier: phoneValueNotifier,
          codePickerDecoration: widget.codePickerDecoration,
          codePickerArrowColor: widget.codePickerArrowColor,
          codePickerTextStyle: widget.codePickerTextStyle,
          codePadding: widget.codePadding,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Directionality(
            textDirection: widget.textDirection ??
                (context.isArabic ? TextDirection.rtl : TextDirection.ltr),
            child: ListenableBuilder(listenable: phoneValueNotifier.countryListener, builder: (context, child) => MyPhoneTextField(
              textFieldModel: widget.textFieldModel.replaceIfNull(
                fieldFormStateKey: textFieldKey,
                enabled: widget.enabled,
                focusNode: phoneValueNotifier.focusNode,
                hint: phoneValueNotifier.country.hintText,
                isDense: false,
                validator: (_) {
                  final validator = widget.textFieldModel.validator;
                  final fullNumber =
                      widget.phoneValueNotifier.numberWithCountryCode;
                  return validator == null
                      ? phoneValueNotifier.validator
                      : validator(fullNumber);
                },
                errorStyle: const MyUtilAppTextStyle.getTextStyle(
                  fontSize: 0,
                ),
              ),
            ),),
          ),
        ),
      ],
    );
    if (widget.height == null) {
      return IntrinsicHeight(
        child: child,
      );
    }
    return SizedBox(
      height: widget.height,
      child: child,
    );
  }
}
