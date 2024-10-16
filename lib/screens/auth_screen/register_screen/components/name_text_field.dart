import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/name_validator_provider.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NameValidatorProvider>(
      builder: (context, nameValidatorProvider, child) {
        return TextFieldWidget(
          controller: nameValidatorProvider.nameController,
          labelText: 'Nama',
          hintText: 'Nama',
          onChanged: (_) => nameValidatorProvider.validateName(),
          errorText: nameValidatorProvider.nameError,
          textCapitalization: TextCapitalization.none,
          prefixIcon: const FractionallySizedBox(
            widthFactor: 0.06,
            child: Icon(Icons.abc_sharp)
          ),
        );
      },
    );
  }
}