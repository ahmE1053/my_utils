import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  const ReadMoreText({
    super.key,
    required this.text,
    this.style,
    this.buttonStyle,
  });

  final TextStyle? style, buttonStyle;
  final String text;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  String? minimizedText;
  bool showAll = false;

  @override
  void initState() {
    final splitText = widget.text.split(' ');
    if (splitText.length > 30) {
      final buffer = StringBuffer();
      for (int i = 0; i < 15; i++) {
        buffer.write(
          '${splitText[i]} ',
        );
      }
      minimizedText = buffer.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (minimizedText == null) {
      return Text(
        widget.text,
        style: widget.style,
      );
    }
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          showAll = !showAll;
          setState(() {});
        },
        child: AnimatedSize(
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 250),
          child: RichText(
            text: TextSpan(
              text: showAll ? widget.text : minimizedText!,
              style: widget.style,
              children: [
                if (!showAll)
                  TextSpan(
                    text: 'seeMore'.tr(context: context),
                    style: widget.buttonStyle,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
