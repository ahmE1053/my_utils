import 'package:flutter/material.dart';
import 'package:my_utils/src/translator.dart';

import 'consts/app_localization_keys.g.dart';
import 'consts/text_styles.dart';
import 'context_extensions.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.toDo,
    this.text,
  });

  final void Function()? toDo;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text?.translate(context) ?? LocaleKeys.areYouSure.translate(context),
              style: MyUtilAppTextStyle.getTextStyle(
                fontSize: 16,
                fontWeight: 600,
                color: context.isDarkMode ? Color(0xfff1f1f1) : Color(
                    0xff2b2e59),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      LocaleKeys.no.translate(context),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      toDo?.call();
                    },
                    child: Text(
                      LocaleKeys.yes.translate(context),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomizableConfirmDialog extends StatelessWidget {
  const CustomizableConfirmDialog({
    super.key,
    this.toDo,
    this.text,
    this.subtitle,
    this.yesText,
    this.noText,
    this.subtitleColor,
    this.textColor,
  });

  final void Function()? toDo;
  final String? text;
  final String? subtitle;
  final String? noText;
  final String? yesText;
  final Color? textColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text?.translate(context) ?? LocaleKeys.areYouSure.translate(context),
              style: MyUtilAppTextStyle.getTextStyle(
                fontSize: 16,
                fontWeight: 600,
                color: textColor != null ? textColor! : context.isDarkMode
                    ? Color(0xfff1f1f1)
                    : Color(0xff2b2e59),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if(subtitle != null)
              Text(
                subtitle!.translate(context),
                style: MyUtilAppTextStyle.getTextStyle(
                  fontSize: 13,
                  color: subtitleColor != null ? subtitleColor! : context
                      .isDarkMode ?
                  Colors.grey[100] : Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        (noText ?? LocaleKeys.no).translate(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      toDo?.call();
                    },
                    child: FittedBox(fit: BoxFit.scaleDown, child: Text(
                      (yesText ?? LocaleKeys.yes).translate(context),
                    ),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
