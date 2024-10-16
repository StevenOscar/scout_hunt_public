import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';

import 'splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      checkInternet(context);
    });
  }

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
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkInternet (BuildContext context) async {
  SplashProvider splashScreenProvider = Provider.of<SplashProvider>(context, listen: false);
  await splashScreenProvider.pingGoogle(context);
  BuildContext dialogContext = context;

  Future.delayed(const Duration(seconds: 3), () async{
    if(splashScreenProvider.hasInternet == true){
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
    } else {
      showDialog(
        context: dialogContext,
        builder: (dialogContext) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Internet tidak terdeteksi",
                style: TextStyleWidget.headlineH4(
                  fontWeight: FontWeightStyle.bold,
                  color: ColorThemeStyle.brown100
                ),
              ),
            ),
            content: const Text("Ingin coba cek lagi?"),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget.defaultContainer(
                    width: 100,
                    height: 35,
                    onPressed: (){
                      Navigator.pop(dialogContext);
                      Navigator.pushReplacementNamed(context, Routes.offlineMainScreen);
                    },
                    text: "Tidak"
                  ),
                  const SizedBox(width: 20),
                  ButtonWidget.defaultContainer(
                    backgroundColor: ColorThemeStyle.brown100,
                    width: 100,
                    height: 35,
                    onPressed: () async {
                      Navigator.pop(dialogContext);
                      await checkInternet(context);
                    },
                    text: "Ya"
                  ),
                ],
              ),
            ],
          );
        }
      );
    }
  });
}