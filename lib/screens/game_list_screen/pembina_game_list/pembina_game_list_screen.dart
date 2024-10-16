import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/components/game_list_view.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';

class PembinaGameListScreen extends StatelessWidget {
  const PembinaGameListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GameSetupProvider gameSetupProvider = context.watch<GameSetupProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Permainan",
          style: TextStyleWidget.titleT1(
            color: ColorThemeStyle.white100,
            fontWeight: FontWeightStyle.medium
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 30),
              child: ButtonWidget.defaultContainer(
                onPressed: (){
                  gameSetupProvider.clearProvider();
                  gameSetupProvider.generateGameCode();
                  Navigator.pushNamed(
                    context,
                    Routes.pembinaGameSetupScreen,
                    arguments: "Buat Permainan"
                  );
                },
                text: "Buat Permainan"
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Daftar Permainan",
              style: TextStyleWidget.displayD4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 20),
            const GameListView(),
            const SizedBox(height: 20,)
          ]
        ),
      ),
    );
  }
}