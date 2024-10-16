import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/pembina_game_list_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';

class SaveGameButton extends StatelessWidget {
  final String saveButton;
  const SaveGameButton({
    super.key,
    required this.saveButton
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    PembinaGameListProvider pembinaGameListProvider = context.watch<PembinaGameListProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Consumer<GameSetupProvider>(
        builder: (_, gameSetupProvider, child) {
          return gameSetupProvider.isLoadingSave ?
            Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text(
                  "Menyimpan data soal.. Harap tunggu sejenak",
                  textAlign: TextAlign.center,
                  style: TextStyleWidget.labelL1(),
                )
              ],
            )) :
            ButtonWidget.defaultContainer(
              onPressed: (gameSetupProvider.isTitleValid && gameSetupProvider.questionList.isNotEmpty) ? () async {
                if(saveButton == "Buat Permainan"){
                  await gameSetupProvider.saveGame(
                    username: userProvider.userData!.username
                  );
                } else if(saveButton == "Edit Permainan"){
                  await gameSetupProvider.updateGame(
                    username: userProvider.userData!.username
                  );
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBarWidget.snackBarWidget(
                      message: "Data Permainan berhasil disimpan",
                      backgroundColor: ColorThemeStyle.greenCarbon
                    ),
                  );
                Navigator.pop(context);
                await pembinaGameListProvider.getGameList(userProvider.userData!.username);
                gameSetupProvider.clearProvider();
              } : null,
              text: "Simpan Permainan"
            );
        },
      ),
    );
  }
}