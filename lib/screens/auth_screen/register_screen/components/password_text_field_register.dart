import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class PasswordTextFieldRegister extends StatelessWidget {
  const PasswordTextFieldRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordValidatorProvider>(
      builder: (context, passwordValidatorProvider, child) {
        return TextFieldWidget(
          controller: passwordValidatorProvider.passwordController,
          labelText: 'Password',
          hintText: 'Password',
          onChanged: (_) => passwordValidatorProvider.validatePassword(),
          errorText: passwordValidatorProvider.passwordError,
          obscureText: !passwordValidatorProvider.isPasswordVisible,
          textCapitalization: TextCapitalization.none,
          suffixIcon: GestureDetector(
            child: Icon(
              passwordValidatorProvider.isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onTap: () {
              passwordValidatorProvider.togglePasswordVisibility();
            },
          ),
          prefixIcon: const FractionallySizedBox(
            widthFactor: 0.06,
            child: Icon(Icons.lock)
          ),
        );
      },
    );
  }
}