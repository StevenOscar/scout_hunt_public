import 'package:flutter/material.dart';
import 'package:scout_hunt/style/color_theme_style.dart';


class ListTileWidget {
  static Widget defaultContainer({
    required Function()? onTap,
    Widget? leading,
    Widget? trailing,
    Text? title,
    Text? subtitle,
    Color? tileColor,

  }) {
    return ListTile(
      tileColor: tileColor ??ColorThemeStyle.brown60,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      onTap: onTap,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing
    );
  }
}