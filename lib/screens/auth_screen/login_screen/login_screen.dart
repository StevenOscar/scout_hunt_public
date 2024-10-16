import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/components/login_button_.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/components/login_title.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/components/password_text_field_login.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/components/to_register.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/components/username_text_field_login.dart';
import 'package:scout_hunt/style/color_theme_style.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
    PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding:
            const EdgeInsets.only(top: 64, right: 19, left: 19, bottom: 10),
        color: ColorThemeStyle.brown100,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: ColorThemeStyle.white100,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: ColorThemeStyle.black100,
              width: 2
            )
          ),
          margin: const EdgeInsets.symmetric(vertical: 110, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoginTitle(),
              const SizedBox(height: 32),
              const UsernameTextFieldLogin(),
              const SizedBox(height: 16),
              const PasswordTextFieldLogin(),
              const SizedBox(height: 30),
              SizedBox(height: usernameValidatorProvider.isUsernameValid && passwordValidatorProvider.isPasswordValid ? 20 : 0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: LoginButton(),
              ),
              const SizedBox(height: 20),
              const ToRegister()
            ],
          ),
        ),
      ),
    );
  }
}
