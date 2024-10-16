import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsernameValidatorProvider>(
      builder: (context, usernameValidatorProvider, child) {
        return TextFieldWidget(
          controller: usernameValidatorProvider.usernameController,
          labelText: 'Username',
          hintText: 'Username',
          onChanged: (_) => usernameValidatorProvider.validateUsername(),
          errorText: usernameValidatorProvider.usernameError,
          textCapitalization: TextCapitalization.none,
          prefixIcon: const FractionallySizedBox(
            widthFactor: 0.06,
            child: Icon(Icons.person)
          ),
        );
      },
    );
  }
}