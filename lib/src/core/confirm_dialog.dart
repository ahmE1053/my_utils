import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'consts/app_localization_keys.g.dart';
import 'consts/text_styles.dart';
import 'string_extensions.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text?.tr() ?? LocaleKeys.areYouSure.tr(),
              style: MyUtilAppTextStyle.getTextStyle(
                fontSize: 16,
                fontWeight: 600,
                color: '2b2e59'.getColor,
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
                      LocaleKeys.no.tr(),
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
                      LocaleKeys.yes.tr(),
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
