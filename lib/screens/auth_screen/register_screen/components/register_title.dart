import 'package:flutter/material.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Register',
      style: TextStyleWidget.headlineH1(
        fontWeight: FontWeightStyle.extraBold,
        color: ColorThemeStyle.brown100
      ),
    );
  }
}