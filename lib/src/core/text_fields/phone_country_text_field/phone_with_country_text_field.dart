import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart' show AnimationController, BoxDecoration, BuildContext, Color, Colors, Column, CrossAxisAlignment, Directionality, EdgeInsets, EdgeInsetsDirectional, Expanded, FormField, FormFieldState, GlobalKey, MediaQuery, OverlayPortal, OverlayPortalController, Padding, Row, SingleTickerProviderStateMixin, SizedBox, State, StatefulWidget, Text, TextDirection, TextStyle, Widget;

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
    this.height = 48,
    this.codePickerDecoration,
    this.codePickerArrowColor,
    this.codePickerTextStyle,
    this.codePadding = EdgeInsets.zero,
  });

  final PhoneFieldNotifier phoneValueNotifier;
  final TextFieldModel textFieldModel;
  final double height;
  final BoxDecoration? codePickerDecoration;
  final EdgeInsets codePadding;
  final Color? codePickerArrowColor;
  final TextStyle? codePickerTextStyle;

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
        overlayChildBuilder: (context) => CountriesOverlay(
          buttonRectKey: buttonRectKey,
          animationController: animationController,
          overlayController: overlayController,
          phoneFieldNotifier: widget.phoneValueNotifier,
        ),
        child: FormField(
          validator: (value) => phoneValueNotifier.validator,
          builder: (field) {
            if (!field.hasError) return buttonWithTextField;
            textFieldKey.currentState?.validate();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buttonWithTextField,
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12.0),
                  child: Text(
                    field.errorText?.tr() ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
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

  Widget get buttonWithTextField => SizedBox(
        height: widget.height,
        child: Row(
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
              child: MyPhoneTextField(
                textFieldModel: widget.textFieldModel.replaceIfNull(
                  fieldFormStateKey: textFieldKey,
                  isDense: false,
                  validator: (value) => phoneValueNotifier.validator,
                  errorStyle: const TextStyle(
                    fontSize: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
