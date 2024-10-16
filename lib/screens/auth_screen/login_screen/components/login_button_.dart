import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/login_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
    PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
    UserProvider userProvider = context.watch<UserProvider>();

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return loginProvider.isLoadingLogin ? const Center(child: CircularProgressIndicator())
          : ButtonWidget.defaultContainer(
              text: "Login",
              onPressed: (usernameValidatorProvider.isUsernameValid && passwordValidatorProvider.isPasswordValid) ?
              () async {
                FocusScope.of(context).unfocus();
                await loginProvider.loginUser(
                  usernameValidatorProvider.usernameController.text,
                  passwordValidatorProvider.passwordController.text
                );
                if(loginProvider.isLoginValid == true){
                  if(loginProvider.userData!.role == 0){
                    await userProvider.getStudentData(loginProvider.userData!);
                  } else {
                    await userProvider.getPembinaData(loginProvider.userData!);
                  }
                  if (!context.mounted) return;
                  if(userProvider.userData!.role == 0){
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.siswaMainScreen,
                      (_) => false
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.pembinaMainScreen,
                      (_) => false
                    );
                  }
                  loginProvider.clearProvider();
                  usernameValidatorProvider.clearProvider();
                  passwordValidatorProvider.clearProvider();
                  loginProvider.setLoadingLogin();
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBarWidget.snackBarWidget(
                        message: "Login Gagal! Coba lagi",
                        backgroundColor: ColorThemeStyle.red
                      ),
                    );
                }
              } : null
            );
      },
    );
  }
}