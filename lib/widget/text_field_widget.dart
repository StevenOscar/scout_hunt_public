import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool? filled;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextAlign? textAlign;
  final TextStyle? errorStyle;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textStyle,
    this.hintStyle,
    this.textAlign,
    this.errorStyle
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: TextFormField(
        style: textStyle ?? TextStyleWidget.bodyB1(),
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType, //mengubah jenis keyboard
        controller: controller,
        onChanged: onChanged,
        cursorColor: ColorThemeStyle.brown100,
        onTapOutside: (PointerDownEvent event) {FocusManager.instance.primaryFocus?.unfocus();},
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintStyle,
          errorText: errorText,
          errorStyle: errorStyle,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: filled,
          labelStyle: TextStyleWidget.bodyB1(),
          enabledBorder: OutlineInputBorder(
            // Garis border biasa
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // Garis border saat difokuskan
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: ColorThemeStyle.brown100, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          errorBorder: OutlineInputBorder(
            // Garis border saat terjadi kesalahan penginputan data
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Garis border saat terjadi kesalahan penginputan data
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
        ),
      ),
    );
  }
}
