import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/agama_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/name_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/register_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/role_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
    PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
    NameValidatorProvider nameValidatorProvider = context.watch<NameValidatorProvider>();
    RoleValidatorProvider roleValidatorProvider = context.watch<RoleValidatorProvider>();
    AgamaValidatorProvider agamaValidatorProvider = context.watch<AgamaValidatorProvider>();

    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, child) {
        return registerProvider.isLoadingRegister ? const Center(child: CircularProgressIndicator())
          : ButtonWidget.defaultContainer(
              text: "Register",
              onPressed: (usernameValidatorProvider.isUsernameValid && passwordValidatorProvider.isPasswordValid && nameValidatorProvider.isNameValid) ? () async {
                FocusScope.of(context).unfocus();
                await registerProvider.registerUser(
                  username: usernameValidatorProvider.usernameController.text,
                  password: passwordValidatorProvider.passwordController.text,
                  name: nameValidatorProvider.nameController.text,
                  role: roleValidatorProvider.roleValue,
                  agama: agamaValidatorProvider.agamaValue
                );
                if(registerProvider.isRegisterValid == true){
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBarWidget.snackBarWidget(
                      message: "Register berhasil!",
                      backgroundColor: ColorThemeStyle.greenCarbon
                    ));
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.loginScreen,
                    (_) => false,
                  );
                  usernameValidatorProvider.clearProvider();
                  passwordValidatorProvider.clearProvider();
                  roleValidatorProvider.clearRoleProvider();
                  nameValidatorProvider.clearProvider();
                  agamaValidatorProvider.clearProvider();
                  registerProvider.clearProvider();
                  registerProvider.setLoadingRegister();
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBarWidget.snackBarWidget(
                      message: registerProvider.message.toString(),
                      backgroundColor: ColorThemeStyle.red
                    )
                  );
                }
              } : null
            );
      },
    );
  }
}