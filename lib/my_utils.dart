library my_utils;

import 'package:flutter/material.dart';

import 'src/core/cached_network_image.dart';
import 'src/core/text_fields/phone_country_text_field/country_info.dart';
import 'src/core/text_fields/utils/full_text_field_model.dart';
import 'src/state_models/state_model_overlay_loading.dart';

export "src/core/animated_text.dart";
export 'src/core/animation_extensions.dart';
export "src/core/base_shimmer.dart";
export "src/core/cached_network_image.dart";
export "src/core/confirm_dialog.dart";
export "src/core/consts/app_consts.dart";
export "src/core/consts/text_styles.dart";
export 'src/core/context_extensions.dart';
export 'src/core/datetime_extensions.dart';
export 'src/core/duration_extension.dart';
export "src/core/empty_widget.dart";
export "src/core/error_column.dart";
export "src/core/error_text_with_animation.dart";
export "src/core/exceptions/general_exception.dart";
export "src/core/full_screen_error_widget.dart";
export "src/core/loading_indicator.dart";
export "src/core/my_user_avatar.dart";
export "src/core/num_extensions.dart";
export "src/core/rating_bar.dart";
export "src/core/read_more_text.dart";
export "src/core/small_error_widget.dart";
export "src/core/snackbar.dart";
export 'src/core/string_extensions.dart';
export 'src/core/text_fields/email.dart';
export 'src/core/text_fields/names.dart';
export 'src/core/text_fields/passwords.dart';
export 'src/core/text_fields/phone.dart';
export 'src/core/text_fields/phone_country_text_field/country_info.dart';
export 'src/core/text_fields/phone_country_text_field/phone_field_notifier.dart';
export 'src/core/text_fields/phone_country_text_field/phone_with_country_text_field.dart';
export 'src/core/text_fields/text_field.dart';
export 'src/core/text_fields/utils/full_text_field_model.dart';
export 'src/core/text_fields/utils/get_text_field_direction.dart';
export "src/core/very_small_error_widget.dart";
export "src/core/wait_before_resend.dart";
export "src/state_models/pagination_model_widget.dart";
export "src/state_models/pagination_state_model.dart";
export "src/state_models/state_model.dart";
export "src/state_models/state_model_listener_widget.dart";
export "src/state_models/state_model_overlay_loading.dart";
export "src/state_models/state_model_widget.dart";
export "src/state_models/state_model_with_opacity_widget.dart";

void setMyUtils({
  TextStyle? globalTextFieldTextStyle,
  TextStyle? globalDarkTextFieldTextStyle,
  TextStyle? globalStateModelErrorTextStyle,
  Widget? cachedNetworkImageErrorWidget,
  Widget? stateModelLoadingIndicator,
  List<CountryInfo>? allowedCountriesInPhoneTextField,
}) {
  if (globalTextFieldTextStyle != null) {
    TextFieldModel.globalTextStyle = globalTextFieldTextStyle;
  }
  if (globalTextFieldTextStyle != null) {
    TextFieldModel.globalDarkTextFieldTextStyle = globalDarkTextFieldTextStyle;
  }
  if (cachedNetworkImageErrorWidget != null) {
    CachedNetworkImageWithLoader.errorWidget = cachedNetworkImageErrorWidget;
  }
  if (allowedCountriesInPhoneTextField != null) {
    CountryInfo.phoneNumbersList = allowedCountriesInPhoneTextField;
  }
  if (stateModelLoadingIndicator != null) {
    StateModelOverlayLoading.defaultLoadingIndicator =
        stateModelLoadingIndicator;
  }
  if (globalStateModelErrorTextStyle != null) {
    StateModelOverlayLoading.globalStateModelErrorTextStyle =
        globalStateModelErrorTextStyle;
  }
}
