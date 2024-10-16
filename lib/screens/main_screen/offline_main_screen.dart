import 'package:flutter/material.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class OfflineMainScreen extends StatelessWidget {
  const OfflineMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsImages.assetsImagesScoutHuntLogo,
              height: 116,
              width: 116,
            ),
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(
                  context,
                  Routes.materiCategoryScreen
                );
              },
              child: Stack(
                children: [
                  Center(child: Image.asset(AssetsImages.assetsImagesMainButton)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        "Materi",
                        style: TextStyleWidget.bodyB1(
                          fontWeight: FontWeightStyle.bold,
                          color: ColorThemeStyle.white100
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}