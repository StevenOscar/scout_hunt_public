import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/pembina_game_list_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';

class GameListView extends StatelessWidget {
  const GameListView({super.key});

  @override
  Widget build(BuildContext context) {
    GameSetupProvider gameSetupProvider = context.watch<GameSetupProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    return Consumer<PembinaGameListProvider>(
      builder: (context, pembinaGameListProvider, child) {
        return pembinaGameListProvider.gameList.isNotEmpty ?
          pembinaGameListProvider.isLoadingData ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              Text(
                "Mendownload data permainan\nMohon tunggu sejenak",
                style: TextStyleWidget.bodyB1(),
                textAlign: TextAlign.center,
              )
            ],
          ) :
          ListView.builder(
            itemCount: pembinaGameListProvider.gameList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListTileWidget.defaultContainer(
                  tileColor: ColorThemeStyle.brown60,
                  onTap: () async{
                    await pembinaGameListProvider.getGameData(
                      gameCode : pembinaGameListProvider.gameList[index].gameCode,
                      index : index
                    );
                    await gameSetupProvider.setEditPermainan(
                      questionList: pembinaGameListProvider.gameData!.questionList,
                      title: pembinaGameListProvider.gameData!.title,
                      gameCode: pembinaGameListProvider.gameList[index].gameCode,
                    );
                    if(!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      Routes.pembinaGameSetupScreen,
                      arguments: "Edit Permainan"
                    );
                  },
                  title: Text(
                    pembinaGameListProvider.gameList[index].title,
                    style: TextStyleWidget.headlineH3(
                      color: ColorThemeStyle.white100,
                      fontWeight: FontWeightStyle.bold
                    ),
                  ),
                  subtitle: Text(
                    "Kode Permainan : ${pembinaGameListProvider.gameList[index].gameCode}",
                    style: TextStyleWidget.bodyB3(
                      color: ColorThemeStyle.white100
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          title: Center(
                            child: Text(
                              "Hapus Permainan?",
                              style: TextStyleWidget.headlineH4(
                                fontWeight: FontWeightStyle.bold,
                                color: ColorThemeStyle.brown100
                              ),
                            )
                          ),
                          content: Text("Apakah anda yakin ingin menghapus '${pembinaGameListProvider.gameList[index].title}'?"),
                          actions: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ButtonWidget.defaultContainer(
                                  width: 100,
                                  height: 35,
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  text: "Tidak"
                                ),
                                const SizedBox(width: 20),
                                ButtonWidget.defaultContainer(
                                  backgroundColor: ColorThemeStyle.red,
                                  width: 100,
                                  height: 35,
                                  onPressed: () async {
                                    await pembinaGameListProvider.deleteGame(index);
                                    await pembinaGameListProvider.getGameList(userProvider.userData!.username);
                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                  },
                                  text: "Ya"
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: ColorThemeStyle.white100,
                      size: 27,
                    )
                  ),
                )
              );
            }
          ) : const Text("Anda belum membuat permainan");
      },
    );
  }
}