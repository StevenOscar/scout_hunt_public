import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/role_validator_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class RoleRadio extends StatelessWidget {
  const RoleRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoleValidatorProvider>(
      builder: (context, roleValidatorProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              fillColor: const WidgetStatePropertyAll(ColorThemeStyle.brown100),
              value: "siswa",
              groupValue: roleValidatorProvider.roleValue,
              onChanged: (roleValue) {
                roleValidatorProvider.selectRole(roleValue.toString());
              }
            ),
            Text(
              "Siswa",
              style: TextStyleWidget.bodyB1(),
            ),
            const SizedBox(width: 25),
            Radio(
              fillColor: const WidgetStatePropertyAll(ColorThemeStyle.brown100),
              value: "pembina",
              groupValue: roleValidatorProvider.roleValue,
              onChanged: (roleValue) {
                roleValidatorProvider.selectRole(roleValue.toString());
              }
            ),
            Text(
              "Pembina",
              style: TextStyleWidget.bodyB1(),
            ),
          ],
        );
      },
    );
  }
}