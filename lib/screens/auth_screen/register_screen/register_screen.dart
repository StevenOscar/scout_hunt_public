  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/agama_validator_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/name_validator_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/register_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/role_validator_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/agama_dropdown.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/name_text_field.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/password_text_field_register.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/register_button.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/register_title.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/role_radio.dart';
  import 'package:scout_hunt/screens/auth_screen/register_screen/components/username_text_field.dart';
  import 'package:scout_hunt/style/color_theme_style.dart';


  class RegisterScreen extends StatelessWidget {
    const RegisterScreen({super.key});

    @override
    Widget build(BuildContext context) {
      UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
      PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
      NameValidatorProvider nameValidatorProvider = context.watch<NameValidatorProvider>();
      RoleValidatorProvider roleValidatorProvider = context.watch<RoleValidatorProvider>();
      AgamaValidatorProvider agamaValidatorProvider = context.watch<AgamaValidatorProvider>();
      RegisterProvider registerProvider = context.watch<RegisterProvider>();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PopScope(
          onPopInvoked: (didPop) {
            usernameValidatorProvider.clearProvider();
            passwordValidatorProvider.clearProvider();
            roleValidatorProvider.clearRoleProvider();
            nameValidatorProvider.clearProvider();
            agamaValidatorProvider.clearProvider();
            registerProvider.clearProvider();
          },
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              color: ColorThemeStyle.brown100,
              padding: const EdgeInsets.only(top: 64, right: 19, left: 19, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorThemeStyle.white100,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: ColorThemeStyle.black100,
                    width: 2
                  )
                ),
                margin: const EdgeInsets.symmetric(vertical: 55, horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    RegisterTitle(),
                    SizedBox(height: 32),
                    NameTextField(),
                    SizedBox(height: 16),
                    UsernameTextField(),
                    SizedBox(height: 16),
                    PasswordTextFieldRegister(),
                    SizedBox(height: 32),
                    AgamaDropdown(),
                    SizedBox(height: 32),
                    RoleRadio(),
                    SizedBox(height: 32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: RegisterButton(),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
