import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/agama_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/login_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/name_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/register_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/role_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class ToRegister extends StatelessWidget {
  const ToRegister({super.key});

  @override
  Widget build(BuildContext context) {
    UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
    PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
    NameValidatorProvider nameValidatorProvider = context.watch<NameValidatorProvider>();
    RoleValidatorProvider roleValidatorProvider = context.watch<RoleValidatorProvider>();
    AgamaValidatorProvider agamaValidatorProvider = context.watch<AgamaValidatorProvider>();
    RegisterProvider registerProvider = context.watch<RegisterProvider>();

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return loginProvider.isLoadingLogin
          ? const SizedBox()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Belum Punya Akun?',
                          style: TextStyleWidget.bodyB1()
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, Routes.registerScreen
                            );
                            usernameValidatorProvider.clearProvider();
                            passwordValidatorProvider.clearProvider();
                            roleValidatorProvider.clearRoleProvider();
                            nameValidatorProvider.clearProvider();
                            agamaValidatorProvider.clearProvider();
                            registerProvider.clearProvider();
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyleWidget.bodyB1(
                              fontWeight: FontWeight.w600,
                              color: ColorThemeStyle.brown100
                            )
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            );
      },
    );
  }
}