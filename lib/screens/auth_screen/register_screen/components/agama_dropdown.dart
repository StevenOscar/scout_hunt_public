import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/agama_validator_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class AgamaDropdown extends StatelessWidget {
  const AgamaDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgamaValidatorProvider>(
      builder: (context, agamaValidatorProvider, child) {
        return ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                // Garis border biasa
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey, // Warna garis
                  width: 2.0, // Ketebalan garis
                ),
              ),
              labelStyle: TextStyleWidget.bodyB1(),
              hintStyle: TextStyleWidget.bodyB1(),
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                // Garis border saat difokuskan
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: ColorThemeStyle.brown100, // Warna garis
                  width: 2.0, // Ketebalan garis
                ),
              ),
            ),
            value: agamaValidatorProvider.agamaValue,
            items: [
              DropdownMenuItem(
                value: "islam",
                child: Text(
                  "Islam",
                  style: TextStyleWidget.bodyB1(),
                )
              ),
              DropdownMenuItem(
                value: "katolik",
                child: Text(
                  "Katolik",
                  style: TextStyleWidget.bodyB1(),
                )
              ),
              DropdownMenuItem(
                value: "kristen",
                child: Text(
                  "Kristen",
                  style: TextStyleWidget.bodyB1(),
                )
              ),
              DropdownMenuItem(
                value: "hindu",
                child: Text(
                  "Hindu",
                  style: TextStyleWidget.bodyB1(),
                )
              ),
              DropdownMenuItem(
                value: "buddha",
                child: Text(
                  "Buddha",
                  style: TextStyleWidget.bodyB1(),
                )
              ),
            ],
            onChanged: (agamaValue){
              agamaValidatorProvider.selectAgama(agamaValue.toString());
            }
          ),
        );
      },
    );
  }
}