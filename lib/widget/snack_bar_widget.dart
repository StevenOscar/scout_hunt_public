import 'package:flutter/material.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SnackBarWidget {
  static SnackBar snackBarWidget({
    required String message,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    SnackBarBehavior? behavior,
    TextStyle? textStyle,
    Duration? duration
  }) {
    return SnackBar(
      behavior: behavior ?? SnackBarBehavior.floating,
      margin: margin ?? const EdgeInsets.only(left: 34, right: 34, bottom: 44),
      backgroundColor: backgroundColor ?? ColorThemeStyle.blue80,
      duration: duration ?? const Duration(seconds: 4),
      content: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          message,
          textAlign: textAlign ?? TextAlign.center,
          style: textStyle ??
              TextStyleWidget.titleT2(
                color: Colors.white,
                fontWeight: FontWeightStyle.medium,
              ),
        ),
      ),
    );
  }
}
