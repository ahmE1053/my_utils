import 'package:flutter/material.dart';
import 'package:my_utils/src/translator.dart';

import 'consts/text_styles.dart';
import 'context_extensions.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(
        bottom: context.bottomViewInsets + 24,
        left: 16,
        right: 16,
      ),
      content: Text(
        text.translate(context),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}

void showSnackBarFromState(ScaffoldMessengerState state, String text) {
  state.hideCurrentSnackBar();
  state.showSnackBar(
    SnackBar(
      margin: const EdgeInsets.only(
        bottom: 24,
        left: 16,
        right: 16,
      ),
      content: Text(
        text.translate(state.context),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}

void showSnackBarMessenger(
    ScaffoldMessengerState messenger, BuildContext context, String text) {
  messenger.showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(
        bottom: context.bottomViewInsets + 24,
        left: 16,
        right: 16,
      ),
      content: Text(
        text.translate(context),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}

void showSuccessSnackBar(
  BuildContext context,
  String text, [
  bool useBottomInsets = true,
  Duration? duration,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(
        bottom: useBottomInsets ? context.bottomViewInsets + 24 : 12,
        left: 16,
        right: 16,
      ),
      backgroundColor: Colors.green,
      duration: duration ?? Duration(seconds: 4),
      content: Text(
        text.translate(context),
        style: const MyUtilAppTextStyle.getTextStyle(
          fontSize: 14,
          fontWeight: 500,
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(
        bottom: context.bottomViewInsets + 24,
        left: 16,
        right: 16,
      ),
      backgroundColor: Colors.redAccent,
      content: Text(
        text.translate(context),
        style: const MyUtilAppTextStyle.getTextStyle(
          fontSize: 14,
          fontWeight: 500,
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}
