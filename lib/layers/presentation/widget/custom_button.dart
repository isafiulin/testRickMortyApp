// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.black,
    this.borderColor = Colors.red,
    this.iconSize = 18.0,
    this.borderRadius = 10.0,
    this.textCenterAlign = true,
    this.iconLeftAlign = true,
    this.spaceBetweenIcon = true,
    this.withShadow = false,
    this.fontSize = 14.0,
    this.fontWeight,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.isEnable = true,
    this.picture,
    this.disableColor,
    this.textStyle,
    this.verticalPadding = 7,
  });

  final double? width;
  final double? height;
  final Function onPressed;
  final String title;
  final Widget? icon;
  final SvgPicture? picture;
  final double iconSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color? disableColor;
  final bool textCenterAlign;
  final bool iconLeftAlign;
  final bool spaceBetweenIcon;
  final bool withShadow;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsets padding;
  final bool isEnable;
  final TextStyle? textStyle;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: width == null
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 25)
            : EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          highlightColor: Colors.grey,
          onTap: () {
            if (isEnable) {
              onPressed();
            }
          },
          child: Ink(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: isEnable ? backgroundColor : disableColor ?? Colors.grey,
              border: Border.all(
                  color: isEnable
                      ? borderColor
                      : disableColor != null
                          ? borderColor
                          : Colors.grey),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: spaceBetweenIcon
                  ? const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    )
                  : EdgeInsets.symmetric(
                      vertical: verticalPadding,
                    ),
              child: Row(
                mainAxisAlignment: textCenterAlign
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: _buildBlock(_theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBlock(ThemeData _theme) {
    return [Expanded(child: _buildTitle(_theme))];
  }

  Widget _buildTitle(ThemeData _theme) {
    return AutoSizeText(
      title,
      maxLines: 1,
      minFontSize: 10,
      textAlign: TextAlign.center,
      style: textStyle ??
          TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}
