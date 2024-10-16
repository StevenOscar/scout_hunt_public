import 'package:flutter/material.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';


class ButtonWidget {
  static Widget defaultContainer({
    required String? text,
    required Function()? onPressed,
    TextStyle? textstyle,
    Color? backgroundColor,
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? 380,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: onPressed == null ? null
              : backgroundColor ?? ColorThemeStyle.brown100
          ),
          onPressed: onPressed,
          child: Text(
            text ?? 'Button',
            style: textstyle ?? TextStyleWidget.bodyB1(
              fontWeight: FontWeightStyle.semiBold,
              color: onPressed == null
                  ? ColorThemeStyle.white100
                  : ColorThemeStyle.white100,
            ),
          )),
    );
  }
}
