import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_text_style.dart';

class AppText extends StatelessWidget {
  const AppText({
    required Key key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines = 1,
    this.isUnderline = false,
    this.noMaxLinesLimit = false,
    this.overflow,
    this.minFontSize,
    this.dividerColor,
    this.textDirection,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int maxLines;
  final bool isUnderline;
  final bool noMaxLinesLimit;
  final TextOverflow? overflow;
  final double? minFontSize;
  final Color? dividerColor;
  final TextDirection? textDirection;
  double _getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: textDirection ?? TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style ?? AppTextStyles.montserratArabicLight14;
    final textWidth = _getTextWidth(text, resolvedStyle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
          text,
          style: resolvedStyle,
          maxLines: noMaxLinesLimit ? 100 : maxLines,
          minFontSize: minFontSize ?? 10,
          maxFontSize: 100,
          textAlign: textAlign,
          textDirection: textDirection ?? Directionality.of(context),
          overflow: noMaxLinesLimit
              ? TextOverflow.visible
              : overflow ?? TextOverflow.ellipsis,
        ),
        if (isUnderline)
          Container(
            height: 1.5,
            width: textWidth,
            color: dividerColor ?? AppColors.blackText,
          ),
      ],
    );
  }
}
